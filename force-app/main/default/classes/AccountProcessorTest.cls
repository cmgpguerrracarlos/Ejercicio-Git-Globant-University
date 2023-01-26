@isTest
public class AccountProcessorTest {
    @isTest
    public static void testFunc() {
        account acc = new account(Name = 'MATW INC', Document_number__c='1234123412', Identification_type__c='PP', Document_Type_Number_Id__c='PP1234123412');
        insert acc;
        contact con = new contact();
        con.lastname = 'Mann1';
        con.AccountId = acc.Id;
        insert con;
        contact con1 = new contact();
        con1.lastname = 'Mann2';
        con1.AccountId = acc.Id;
        insert con1;
        
        
        List<Id> acc_list = new List<Id>();
        acc_list.add(acc.Id);
        
        Test.startTest();
        	AccountProcessor.countContacts(acc_list);
        Test.stopTest();
        
        List<account> acc1 = new List<account>([select Number_of_Contacts__c from account where id = :acc.id]);
        
        system.assertEquals(2,acc1[0].Number_of_Contacts__c);
        system.assert(true);

    }
}