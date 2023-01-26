public with sharing class AccountProcessor {
        @future
       public static void countContacts(List<Id> accountId_lst) {
        
        Map<Id,account> account_cno = new Map<Id,account>(); 
        List<account> account_lst_all = new List<account>([select id, Document_number__c, Identification_type__c, Document_Type_Number_Id__c, (select id from contacts) from account]);
        for(account a:account_lst_all) {
            account_cno.put(a.id,a); //populate the map
            
        }
            		
        List<account> account_lst = new List<account>(); // list of account that we will upsert
        	
        for(Id accountId : accountId_lst) {
            if(account_cno.containsKey(accountId)) {
                account acc = new account(
                Id = accountId,
                Number_of_Contacts__c = account_cno.get(accountId).contacts.size(),
                Document_number__c = account_cno.get(accountId).Document_number__c,
                Document_Type_Number_Id__c = account_cno.get(accountId).Document_Type_Number_Id__c,
                Identification_type__c = account_cno.get(accountId).Identification_type__c);
                account_lst.add(acc);
            }
            
        }
        update account_lst;
    }
}