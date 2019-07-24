/******************************************************************************************************************
* Author: Samar Saha (INNOVEX)
* Date: Jun - 2019
* Update History - 
*****************************************************************************************************************/ 
public without sharing class INV_RuleActionsHandler{
    
    public void processSuccess_CL_Product(Set<ID> recIDs ) {        
        //update success records
        List<clcommon__CL_Product__c> prodList = new List<clcommon__CL_Product__c>();       
        //prodList = [Select Id, clcommon__Class__c, clcommon__Product_Name__c from clcommon__CL_Product__c where ID IN: recIDs];
        prodList = INV_RuleObjectQueryGenerator.fetch_CL_Product(recIDs);
        
        for(clcommon__CL_Product__c p : prodList){
            p.clcommon__Product_Name__c = 'Success';
        }        
        update prodList;
    }  
    
    public void processFailure_CL_Product(Set<ID> recIDs ) {        
        //update success records
        List<clcommon__CL_Product__c> prodList = new List<clcommon__CL_Product__c>();        
        //prodList = [Select Id, clcommon__Class__c, clcommon__Product_Name__c from clcommon__CL_Product__c where ID IN: recIDs];
        prodList = INV_RuleObjectQueryGenerator.fetch_CL_Product(recIDs);
        for(clcommon__CL_Product__c p : prodList){
            p.clcommon__Product_Name__c = 'Fail';
        }        
        update prodList;
    }
    
    public void processSuccess_DM_CL_Contract(Set<ID> recIDs) {        
        List<INV_CL__DM_Loan_Account__c> recordList = new List<INV_CL__DM_Loan_Account__c>();                
        recordList = INV_RuleObjectQueryGenerator.fetch_DM_CL_Contract(recIDs);
        for(INV_CL__DM_Loan_Account__c dm : recordList){
            dm.INV_CL__DM_Valid_Data__c = True;
            system.debug('In success-->'+dm.ID);
        }        
        update recordList;
    } 
    
    public void processFailure_DM_CL_Contract(Set<ID> recIDs) {        
        List<INV_CL__DM_Loan_Account__c> recordList = new List<INV_CL__DM_Loan_Account__c>();                
        recordList = INV_RuleObjectQueryGenerator.fetch_DM_CL_Contract(recIDs);
        for(INV_CL__DM_Loan_Account__c dm : recordList){
            dm.INV_CL__DM_Invalid_Data__c = True;
            dm.INV_CL__DM_Error__c = 'Rule Criteria Not Met';
            system.debug('In failure-->'+dm.ID);
        }        
        update recordList;
    } 
    
    //method to query all fields of sObject by record ID
    public void queryRecordsByIDSet(Set<ID> recIDs ) {       
        //ID recordId = '5001a00000CgCE2';
        List<ID> recordList = new List<ID>();
        recordList.addAll(recIDs);
        DescribeSObjectResult describeResult = recordList[0].getSObjectType().getDescribe();        
        List<String> fieldNames = new List<String>( describeResult.fields.getMap().keySet() );
        
        String query =
          ' SELECT ' +
              String.join( fieldNames, ',' ) +
          ' FROM ' +
              describeResult.getName() +
          ' WHERE ' +
              ' id IN :recIDs' +
          ' LIMIT 1 '
        ;
        
        // return generic list of sobjects or typecast to expected type
        List<SObject> records = Database.query( query );        
        System.debug( records );     
    }
    
    
}//End of class