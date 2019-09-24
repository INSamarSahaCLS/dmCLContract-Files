/******************************************************************************************************************
* Author: Samar Saha (INNOVEX)
* Date: Sep - 2019
* Update History - 
*****************************************************************************************************************/ 
public with sharing class INV_DM_MigrationHandler 
    {
      public static String productType;
      public loan__Loan_Account__c DM_FieldMapping_LoanAccount(INV_CL__DM_Loan_Account__c scope)
      {
        system.debug('Inside DM_FieldMapping_LoanAccount');
        loan__Loan_Account__c con;
        if(scope !=null)
        {
              productType=scope.Product_Type__c;
              con = new loan__Loan_Account__c();
              con.loan__Account__c = scope.DM_Account__c;
              con.loan__Overdue_Principal__c =  scope.DM_Overdue_Principal__c;
              con.loan__Overdue_Interest__c  =  scope.DM_Overdue_Interest__c;
              con.loan__Contract_Type__c = scope.DM_Contract_Type__c ;
              con.loan__Loan_Product_Name__c = scope.DM_Product__c ;
              con.loan__Product_Type__c = scope.DM_Product_Type__c ;
              con.loan__Loan_Status__c = scope.DM_Loan_Status__c ;
              con.loan__Application_Date__c = scope.DM_Application_Date__c ;
              con.loan__Disbursal_Date__c = scope.DM_Disbursal_Date__c ;
              con.loan__Expected_Disbursal_Date__c = scope.DM_Expected_Disbursal_Date__c ;
              con.loan__Loan_Amount__c =  scope.DM_Loan_Amount__c;
              con.loan__Expected_Repayment_Start_Date__c = scope.DM_Expected_Repayment_Start_Date__c ;
              con.loan__Number_of_Installments__c = scope.DM_Number_of_Installments__c ;
              con.loan__Frequency_of_Loan_Payment__c = scope.DM_Frequency_of_Loan_Payment__c ;
              con.loan__Next_Installment_Date__c =  scope.DM_Next_Installment_Date__c;
              con.loan__Contractual_Interest_Rate__c = scope.DM_Contractual_Interest_Rate__c ;
              con.loan__Interest_Remaining__c = scope.DM_Interest_Remaining__c ;
              con.loan__Fees_Remaining__c =  scope.DM_Fees_Remaining__c;
              con.loan__Principal_Remaining__c = scope.DM_Principal_Remaining__c ;
              con.loan__Rate_Change_Dt_Last__c = scope.DM_Rate_Change_Dt_Last__c;
              con.loan__Oldest_Due_Date__c = scope.DM_Oldest_Due_Date__c;
              con.loan__Pmt_Amt_Cur__c =  scope.DM_Pmt_Amt_Cur__c  ;
              con.loan__Principal_Remaining__c = scope.DM_Principal_Remaining__c ;
              con.loan__Last_Installment_Date__c = scope.DM_Last_Installment_Date__c;
              con.loan__Payment_Amount__c= scope.DM_Payment_Amount__c;
              con.loan__Disbursal_Amount__c= scope.DM_Disbursal_Amount__c;
              con.loan__Disbursed_Amount__c= scope.DM_Disbursed_Amount__c;
              con.loan__Interest_Only_Period__c= scope.DM_Interest_Only_Period__c;
              con.loan__Interest_Type__c= scope.DM_Interest_Type__c;
              con.loan__Payment_Application_Mode__c= scope.DM_Payment_Application_Mode__c;
              con.loan__Time_Counting_Method__c= scope.DM_Time_Counting_Method__c;
              con.loan__Interest_Calculation_Method__c= scope.DM_Interest_Calculation_Method__c;
              con.loan__Last_Accrual_Date__c= scope.DM_Last_Accrual_Date__c;
              con.loan__Next_Due_Generation_Date__c= scope.DM_Next_Due_Generation_Date__c;
              con.loan__Term_Cur__c= scope.DM_Term_Cur__c;
              con.loan__Due_Day__c= scope.DM_Due_Day__c;
              con.loan__Maturity_Date_Current__c= scope.DM_Maturity_Date_Current__c;
              con.loan__Contractual_Due_Day__c= scope.DM_Contractual_Due_Day__c;
              con.loan__First_Installment_Date__c= scope.DM_First_Installment_Date__c;
              con.loan__Second_Installment_Date__c= scope.DM_Second_Installment_Date__c;
              con.loan__Accrual_Start_Date__c= scope.DM_Accrual_Start_Date__c;
              con.loan__Rate_Change_Dt_Next__c= scope.DM_Rate_Change_Dt_Next__c;
              con.loan__Rate_Change_Dt_Last__c= scope.DM_Rate_Change_Dt_Last__c;
              con.loan__Oldest_Due_Date__c= scope.DM_Oldest_Due_Date__c;
              con.loan__Pmt_Amt_Cur__c = scope.DM_Pmt_Amt_Cur__c;
              con.loan__Disbursal_Status__c = scope.DM_Disbursal_Status__c;
              con.loan__Branch__c = scope.DM_Branch__c;
              con.loan__Fee_Set__c = scope.DM_Fee_Set__c;
              scope.DM_Success__c = True ; 
              
              //DM_DynamicFieldMapping(scope,con,productType);
          }
          return con;
    }//END DM_FieldMapping_LoanAccount
         
    
      
      public loan__Repayment_Schedule__c DM_StaticFieldMapping_RepaySCH(DM_Repayment_Schedule__c scope,Id parentId)
      {
        loan__Repayment_Schedule__c repaySch;
        if(scope !=null)
        {
              repaySch = new loan__Repayment_Schedule__c();
              repaySch.loan__Loan_Account__c = parentId;
              repaySch.loan__Due_Date__c = scope.DM_Due_Date__c;
              repaySch.loan__Due_Principal__c = scope.DM_Due_Principal__c;
              repaySch.loan__Due_Interest__c = scope.DM_Due_Interest__c;
              repaySch.loan__Balance__c = scope.DM_Balance__c;
              //DM_DynamicFieldMapping(scope,repaySch,productType);                    
        }
          return repaySch;
      }//END DM_StaticFieldMapping_RepaySCH         
    
      private void DM_DynamicFieldMapping(Sobject scope, Sobject dmSOBJ,String productType){
        system.debug('Inside DM_DynamicFieldMapping');
        DM_Metadata_Config_Wrapper configWrapper1 = ParserUtil.getParser();  
        system.debug('configWraper'+configWrapper1);
        Map<String, Map<String, String>> JSONFieldMapping =  DM_Validate_Impl.getFieldMappingFromJSON(configWrapper1);
        //Map<SImple Loan|DM_Loan_Acc,Map<srcObject|SrcField,TargetObj+TargetField+DataType>>
        Map<String,String> tempMap = new Map<String,String>();
        string objName;
        Sobject sObj;        
        String[] fieldMetadata;
        String[] temp;
        String srcField;
        objName = String.valueOf(scope).split(':')[0];
        system.debug('objName'+objName);
        system.debug('product type'+productType);
        system.debug('JSON Field Mapping keyset '+JSONFieldMapping.keySet());
        system.debug('JSON Field Mapping keyset '+JSONFieldMapping.values());
        if(JSONFieldMapping.containsKey(productType+'|'+objName.toLowerCase())){
            system.debug('productType|SRCObject Matched');
            tempMap = JSONFieldMapping.get(productType+'|'+objName.toLowerCase());
            system.debug('tempMap size '+tempMap);
            if(tempMap<>null){
                for(String key : tempMap.KeySet()){
                    system.debug('Inside TempMap KeySet');
                    temp = key.split('\\|');
                    system.debug('temp'+temp);
                    srcField=temp[1];
                    system.debug('srcField '+srcField);
                    if(tempMap.get(key)<>null){
                        system.debug('inside tempMap');
                        fieldMetadata = tempMap.get(key).split('\\|');
                        if(scope.get(srcField)<>null){
                            if(dynamicDataTypeCheck(fieldMetadata[2],String.valueOf(scope.get(srcField)))){
                                system.debug('data Type check Succeed');
                                if(fieldMetadata[2]=='Text')
                                    dmSOBJ.put(fieldMetadata[1],String.valueOf(scope.get(srcField)));
                                else if(fieldMetadata[2]=='Date')
                                    dmSOBJ.put(fieldMetadata[1],dynamicDataTypeDateConversion(String.valueOf(scope.get(srcField))));//Date.valueOf(String.valueOf(scope.get(srcField)))
                                else if(fieldMetadata[2]=='Checkbox')
                                    dmSOBJ.put(fieldMetadata[1],dynamicBooleanConversion(String.valueOf(scope.get(srcField))));
                                else if(fieldMetadata[2]=='Number')
                                    dmSOBJ.put(fieldMetadata[1],dynamicNumberConversion(String.valueOf(scope.get(srcField))));        
                            }//DynamicDataTypeCheck 
                        }//END if(scope.get(srcField)<>null){
                    }//END if(tempMap.get(srcField)<>null){
                }//END FOR Loop
            }//IF not null
        }//END IF ContainsKey
     }//END DM_DynamicFieldMapping_Contract    
     
     private Boolean dynamicDataTypeCheck(String dataType, String value){
         system.debug('inside dynamicDataTypeCheck');
         system.debug('data type '+dataType);
         if(dataType=='Text'){
             return true;
         }
         
         if(dataType=='Date'){
             Pattern pattern =  Pattern.compile('(0?[1-9]|[12][0-9]|3[01])-(0?[1-9]|1[012])-((19|20)\\d\\d)');
             Matcher matcher = pattern.matcher(value);
             return matcher.matches();
         }
         
         if(dataType=='Number'){
             return value.isNumeric();
         }
         
         if(dataType=='Checkbox'){
             if(Value=='True' || Value=='False')
                 return true;
         }
         return false;
     }//END dynamicDataTypeCheck
        
        private Date dynamicDataTypeDateConversion(String value){
            Date tempDate;
            String[] dateVal;
            dateVal = value.split('-');
            tempdate = date.newinstance(integer.valueOf(dateVal[2]),integer.valueOf(dateVal[0]),integer.valueOf(dateVal[1]));
            return tempdate;
        }//END dynamicDataTypeDateConversion
        
        private Boolean dynamicBooleanConversion(String Value){
            if(Value=='True')
                return true;
            else
                return false; 
        }
        
        private Decimal dynamicNumberConversion(String Value){
            Decimal num = Decimal.valueOf(value);
            return num;
        }
        
}//END class DM_MigrationHandler