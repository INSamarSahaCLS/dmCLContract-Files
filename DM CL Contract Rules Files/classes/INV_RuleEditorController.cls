/******************************************************************************************************************
* Author: Samar Saha (INNOVEX)
* Date: Jun - 2019
* Update History - 
*****************************************************************************************************************/ 
public class INV_RuleEditorController{

    public String ruleId{get;set;}
    public Boolean isRuleRender{ get;set;}
    public String ruleViewId { get; set;}
    public String ruleDelId { get; set;}
    public clcommon__Rule_Set__c ruleSetDetails = new clcommon__Rule_Set__c();
    public List<clcommon__Rule__c> ruleList { get; set; }
    public Boolean editMode {get; set;}
    Public String namespace{get; set;}
    
     // Constructor
    public INV_RuleEditorController() {    
      
    } 
    
    public INV_RuleEditorController(ApexPages.StandardController controller) {
         namespace = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;

        
    }     
    
      /**
    * Method: loadRuleSetRules()
    *
    * Description: Reloads Rule List based on Rule Set Name.
    */
    public PageReference loadRuleSetRules(){
        
       /*if(!String.isBlank(selectedSourceSystem)){
            
            String functionName = Constants.RULE_SET_FUNCTION_STRATEGY+':'+selectedSourceSystem;
            ruleList = StrategyControllerUtil.getRuleListForRuleSet(ruleSetName,functionName);
            
        }*/         
       
        return null;              
    }
    
       /**
* Method: populateRulesList()
*
* Description:Populate All Rule List.
*/
    public PageReference populateRulesList(){
        
         //Fetch all collections RuleSet
         List<clcommon__Rule_Set__c> ruleSetList = [Select Id, Name, clcommon__Function__c, clcommon__Mode_of_Rule_Execution_On_Priority__c, clcommon__Type__c from clcommon__Rule_Set__c];
                  
         if (ruleSetList == null || ruleSetList.size() == 0) {            
                return null;                
         }
            
         List<ID> ruleSetIDList=new List<ID>();          
         for(clcommon__Rule_Set__c ruleset : ruleSetList){           
             ruleSetIDList.add((ID)ruleset.ID);
         }
            
         ruleList = [Select Id, Name, clcommon__Rule_Set__c, clcommon__Rule_Set__r.Name, clcommon__Rule_Set__r.clcommon__Mode_of_Rule_Execution_On_Priority__c, clcommon__Rule_Json__c, 
         clcommon__Rule_Priority__c,clcommon__Object_Type__c,clcommon__Enabled__c from clcommon__Rule__c where clcommon__Rule_Set__c IN: ruleSetIDList];
                                
         return null;              
    }
    
    public void viewRule(){
        
        ruleId = null;
        isRuleRender =true;
        
    }
     
    public void editRule(){
        
        ruleViewId = null;
        isRuleRender =true;
        
    } 
    
    /**
    * Method: deleteRule()
    *
    * Description:It is used to delete the Rule .
    */
    public PageReference deleteRule(){
        PageReference newPagRef =null;
        PageReference pagRef = new PageReference(ApexPages.currentPage().getUrl());
        clcommon.AbstractRule ruleSetupAPI = clcommon.APIFactory.getAbstractRuleSetupAPI();
        ruleSetupAPI.deleteRule(ruleDelId);
        if(pagRef.getUrl().contains('RuleDetailsList')){
            newPagRef = new PageReference('/apex/' + 'INV_RuleEditor');
        }else{
            newPagRef = new PageReference('/apex/' + 'INV_RuleEditor');
        }
        pagRef.setRedirect(true);
        return newPagRef;
    }
                
}//End of class