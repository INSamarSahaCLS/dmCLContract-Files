/******************************************************************************************************************
* Author: Samar Saha (INNOVEX)
* Class Name - INV_ValidateStagingSuccessRecord
* Date: Jul - 2019
* Update History - 
*****************************************************************************************************************/ 
global with sharing class INV_ValidateStagingSuccessRecord implements clcommon.IRuleAction3{
    private Set<ID> recIDs;
    private Map<ID, Map<String, Map<String, Object>>> recordMap;
    private mfiflexUtil.UnitOfWorkTransaction uowTransaction;  
    
    //it is called by rule engine
    public void setIds(Set<Id> recIDs) {        
        //recIDs size will be greater than 0 as Rule Engine will call action methods only when successIDs are present
        system.debug(LoggingLevel.ERROR, '[INV_ValidateStagingSuccessRecord][setIds](recIDs): ' + recIDs);
        this.recIDs = recIDs;       
    }
    
    public void INV_ValidateStagingSuccessRecord() {
        //this.ObjectAPIName = ObjectAPIName;      
    }
    
    //it is called by rule engine
    global void setRecordsMap(Map<Id,Map<String,Map<String,Object>>> recordMap) {
        //recordMap will return the data for all the records irrespective of success or failures
        system.debug(LoggingLevel.ERROR, '[INV_ValidateStagingSuccessRecord][setRecordsMap](recordMap): ' + recordMap);
        
        for(Id id:recordMap.keyset()){
            system.debug('*****Map value******' + id + '-->'+recordMap.get(id).keyset());
        }                
        this.recordMap = recordMap;
    }
    
    //it is called by rule engine
    global void setUnitOfWorkTransaction(mfiflexUtil.UnitOfWorkTransaction uowTransaction){
        this.uowTransaction = uowTransaction;    
    }    
    
    //it is called by rule engine
    global Object evaluate(Map<String,Object> params) {
        system.debug(LoggingLevel.ERROR, '[INV_ValidateStagingSuccessRecord][evaluate](params): ' + params);
        
        try {
            //String packageName = (String)params.get('packageName');
            Set<String> actionSetToBeExecuted =(Set<String>) params.get('actionSetToBeExecuted');
            clcommon__Rule__c ruleRec = (clcommon__Rule__c)params.get('Rule');            
            Map<String, Object> ruleMap = (Map<String, Object>)JSON.deserializeUntyped(ruleRec.clcommon__Rule_Json__c);
            
            Map<String,Object> additionalParamsMap=null;
            //For Success Actions
            List<Object> successActionsList = (List<Object>)ruleMap.get('successActions'); 
            system.debug('[INV_ValidateStagingSuccessRecord] successActionsList  -->'+successActionsList);               
            if (successActionsList!=null && successActionsList.size() >= 1){         
                for (Object successAction: successActionsList) {
                    String className = (String)((Map<String, Object>)successAction).get('apexClassName'); 
                    if(className!=null && !String.isEmpty(className) && className.equals(INV_CL.INV_ValidateStagingSuccessRecord.class.getName())){ 
                        //String additionalParams = (String)((Map<String, Object>)successAction).get('additionalParams');   
                        //additionalParamsMap = (Map<string,Object>)Json.deserializeUntyped(additionalParams); 
                        INV_RuleActionsHandler ruleActionsHandler=new INV_RuleActionsHandler();
                        ruleActionsHandler.processSuccess_DM_CL_Contract(recIDs);   
                        system.debug('[INV_ValidateStagingSuccessRecord] In success -->'+recIDs);                                
                        break;
                    }                  
                }
            }
            //Placeholder for any parameter
            if (additionalParamsMap != null && additionalParamsMap.size()>0) {  
                additionalParamsMap.clear();
            }                                                                                                                                                                                            
        }         
        catch (Exception ex) {
            system.debug(LoggingLevel.ERROR, 'Exception at line number : ' + ex.getLineNumber() + ', Exception : ' + ex);
            system.debug(LoggingLevel.ERROR, 'StackTrace : ' + ex.getStackTraceString());
            throw ex;
        }        
        return null;        
    }
    
    /**
* Method: getActionInputParameters
* Description: It will return list action parameter. it is called by rule engine on  * click of add parameter
*/
    global  List<String> getActionInputParameters() {
        List<String> parameterList = new List<String> {'ObjectAPIName'};           
            return parameterList;
    }  
}