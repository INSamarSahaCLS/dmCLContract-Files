/******************************************************************************************************************
* Author: Samar Saha (INNOVEX)
* Date: Jun - 2019
* Update History - 
*****************************************************************************************************************/ 
public class INV_RuleEngineController{
    
    Public String namespace{get; set;}
    
    public INV_RuleEngineController() {    
        namespace = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;
    }        
                
}//End of class