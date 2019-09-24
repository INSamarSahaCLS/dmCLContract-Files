/******************************************************************************************************************
* Author: Samar Saha (INNOVEX)
* Date: Sep - 2019
* Update History - 
*****************************************************************************************************************/ 
public class INV_DM_Data_Creation {
    public List<DM_Loan_Account__c> errorUpdate = new List<DM_Loan_Account__c>();
    public static Id contractId;
    Savepoint sp;
    public void DataCreation(List<DM_Loan_Account__c> dmList){
        system.debug('Inside DataCreation Method');
        Id parentId;
        contractId=dmList[0].Id;
        System.debug('contract Id - '+contractId);
        parentid = insertLoanContract(dmList);
 
        system.debug('ParentId '+parentId);
        /*system.debug('child repay- '+dmList[0].DM_Repayment_Schedule_Summarys__r);        
        system.debug('child Repayment Amort'+dmList[0].DM_Repayment_Schedules__r);*/
        
        if(parentId<>null){           
            if(errorUpdate.isEmpty()){                 
                     if(!dmList[0].DM_Repayment_Schedules__r.isEmpty()){
                        insertRepaySchedule(dmList[0].DM_Repayment_Schedules__r,parentId);
                     }
            }
        }            
        
        if(!errorUpdate.isEmpty()){
            update errorUpdate;
        }else{
            Dm_Loan_Account__c dmLoan = new Dm_loan_Account__c(Id= dmList[0].Id, migration_status__c='Success', DM_Error__c='', DM_Invalid_Data__c=false, DM_Is_Migrated__c=True, Migrated_CL_Contract__C=parentId);
            update dmLoan;
        }
        
    }//Data Creation
    
    private Id insertLoanContract(List<DM_Loan_Account__c> dmList){
        system.debug('insertLoanContract');
        DM_MigrationHandler dmHandler = new DM_MigrationHandler();
        loan__Loan_Account__c loan;
        List<loan__Loan_Account__c> loanList = new List<loan__Loan_Account__c>();
        if(!dmList.isEmpty()){
            for(DM_Loan_Account__c dmloan : dmList){
               loan = dmHandler.Dm_FieldMapping_LoanAccount(dmloan);
                system.debug('loan after mapping'+loan);
                if(loan<>null)
                    sp = Database.setSavepoint();
                    loanList.add(loan);
            }    
            try{
                if(!loanList.isEmpty()){
                    insert loanList;
                    return loanList[0].Id;
                }     
            }catch(Exception ex){
               errorUpdate.add(new DM_Loan_Account__c(Id=contractId, DM_Error__c= 'Exception Thrown - CL Contract - '+ ex.getMessage(), DM_Invalid_Data__c=True, migration_status__c='Failed'));
               return null;
            }  
        }
        return null;
    }//END insertLoanContract        
    
    private void insertRepaySchedule(List<DM_Repayment_Schedule__c> dm_RepaySch, Id parentId){
        loan__Repayment_Schedule__c repaySch;
        DM_MigrationHandler dmHandler = new DM_MigrationHandler();
        List<loan__Repayment_Schedule__c> repaySchList = new List<loan__Repayment_Schedule__c>();
        if(!dm_RepaySch.isEmpty()){
            for(DM_Repayment_Schedule__c dmRepaySch : dm_RepaySch){
               repaySch = dmHandler.DM_StaticFieldMapping_RepaySCH(dmRepaySch,parentId);
                system.debug('rePaySch'+repaySch);
                if(repaySch<>null)
                    repaySchList.add(repaySch);
            }    
            try{
                if(!repaySchList.isEmpty()){
                    //Create SavePoint
                    insert repaySchList;
                }     
            }catch(Exception ex){
              errorUpdate.add(new DM_Loan_Account__c(Id=contractId, DM_Error__c= 'Exception Thrown - Repayment Schedule - '+ ex.getMessage(), DM_Invalid_Data__c=True));
              Database.rollback(sp);
            }  
         }
    }
    
}//END DM_Data_Creation