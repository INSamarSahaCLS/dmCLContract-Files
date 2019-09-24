/******************************************************************************************************************
* Author: Samar Saha (INNOVEX)
* Date: Sep - 2019
* Update History - 
*****************************************************************************************************************/ 
public with sharing class INV_DM_SqlQueryGenerator 
{
    public String GetQueryString(String srcObject)
    {
        string query ='';
        string parent='';
        string status='pending';
        
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        
        Map <String, Schema.SObjectField> fieldMap = new Map <String, Schema.SObjectField>();
        
        for(String sObj : srcObject.split(';')){
            system.debug('sObj -->'+sObj);
            fieldMap = schemaMap.get(sObj).getDescribe().fields.getMap();
            String queryFields = Null;
            for(Schema.SObjectField sField :fieldMap.values())
            {
                schema.describefieldresult dfield = sfield.getDescribe();
                if(queryFields != Null)
                {
                    queryFields = queryFields + ',' + dfield.getname();
                }
                else
                {
                    queryFields = dfield.getname();
                }
            } 
            
            if(sobj !='INV_CL__DM_Loan_Account__c'){
                sobj = sobj.replace('__c','s__r');
                query += '(Select '+queryFields+ ' from '+sobj +'),';
            }
            else{               
                    query = query.removeEnd(',');
                    parent = 'select '+queryFields+','+query+' from '+sobj + 
                         ' where INV_CL__Migration_Status__c = \'' + status + '\' ' + ' and INV_CL__DM_Valid_Data__c = true limit 1';                         
                    System.debug('queryFields-->'+queryFields);                   
            }           
        }
        System.debug('query-->'+query);
        System.debug('parent-->'+parent);
        return parent;
    }
}