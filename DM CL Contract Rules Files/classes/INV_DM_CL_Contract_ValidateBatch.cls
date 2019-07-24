/******************************************************************************************************************
* Author: Samar Saha (INNOVEX)
* Date: Jun - 2019
* Update History - 
*****************************************************************************************************************/ 
global class INV_DM_CL_Contract_ValidateBatch implements Database.Batchable<sObject>{

   public String query;

   global INV_DM_CL_Contract_ValidateBatch(){
       query = INV_RuleObjectQueryGenerator.fetch_DM_CL_Contract_QueryString();      
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
       Set<ID> recordIDs = new Set<ID>();
       for(sObject s: scope){
           recordIDs.add(s.Id);
       }
       
       //List<clcommon__Rule__c> ruleList = [Select Id,clcommon__Rule_Set__c, clcommon__Rule_Set__r.Name, clcommon__Rule_Set__r.clcommon__Mode_of_Rule_Execution_On_Priority__c, clcommon__Rule_Json__c, clcommon__Rule_Priority__c from clcommon__Rule__c where id = 'a2I8E000000W9xg'];
       
       clcommon.AbstractRulesAPI rulesIns = clcommon.APIFactory.getAbstractRulesAPI();
       rulesIns.setIds(recordIDs);
       rulesIns.setCategory('DM CL Contract');
       //rulesIns.setRules(ruleList);
       //rulesIns.skipRulesQuery(true);
       //rulesIns.setRunTimeParameters(paramsMap);
       rulesIns.evaluate();
   }

   global void finish(Database.BatchableContext BC){
       system.debug('******INV_DM_CL_Contract_ValidateBatch**** Finish Method Executed');
   }
}