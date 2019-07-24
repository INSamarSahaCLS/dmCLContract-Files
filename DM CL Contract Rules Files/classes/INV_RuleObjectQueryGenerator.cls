/******************************************************************************************************************
* Author: Samar Saha (INNOVEX)
* Date: Jun - 2019
* Update History - 
*****************************************************************************************************************/ 
public without sharing class INV_RuleObjectQueryGenerator{

    public static List<clcommon__CL_Product__c> fetch_CL_Product(Set<ID> recIDs ) {
        List<clcommon__CL_Product__c> prodList = new List<clcommon__CL_Product__c>();        
        prodList = [Select Id, clcommon__Class__c, clcommon__Product_Name__c from clcommon__CL_Product__c where ID IN: recIDs]; 
        return prodList;
    }
        
    public static List<INV_CL__DM_Loan_Account__c> fetch_DM_CL_Contract(Set<ID> recIDs) {
        List<INV_CL__DM_Loan_Account__c> dmContractList = new List<INV_CL__DM_Loan_Account__c>();        
        dmContractList = [Select Id, inv_cl__dm_principal_remaining__c, 
        inv_cl__dm_contractual_interest_rate__c,
        inv_cl__dm_number_of_installments__c, 
        inv_cl__dm_account__r.id,
        inv_cl__dm_contact__r.id, 
        inv_cl__dm_product__r.id, 
        INV_CL__DM_Invalid_Data__c,
        INV_CL__DM_Valid_Data__c,
        INV_CL__DM_Error__c from INV_CL__DM_Loan_Account__c where ID IN: recIDs]; 
        return dmContractList;
    }
    
    public static String fetch_DM_CL_Contract_QueryString() {
        String Query = 'Select Id, inv_cl__dm_principal_remaining__c, inv_cl__dm_contractual_interest_rate__c, inv_cl__dm_number_of_installments__c,'+ 
        'inv_cl__dm_account__r.id, inv_cl__dm_contact__r.id, inv_cl__dm_product__r.id, inv_cl__DM_Fee_Set__r.id, INV_CL__DM_Invalid_Data__c,'+
        'INV_CL__DM_Valid_Data__c, INV_CL__DM_Error__c from INV_CL__DM_Loan_Account__c'; 
        
        return Query;
    }
       






}