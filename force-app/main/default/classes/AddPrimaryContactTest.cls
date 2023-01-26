@isTest
public class AddPrimaryContactTest {
	@isTest
    static void addPrimaryTest(){
        List<Account> accounts = new List<Account>();
        for(Integer i=0;i<500;i++){
            Account acc = new account(Name = 'Test', Document_number__c='1234567890'+i, Document_Type_Number_Id__c='PP1234567890'+i,Identification_type__c='PP');
            if(i<250){
                acc.BillingState = 'NY';
            }else{
                acc.BillingState = 'CA';
            }
            accounts.add(acc);
        }
        insert accounts;
        Contact contact = new Contact(FirstName='Simon', LastName='Guerra');
        insert contact;
        
        Test.startTest();
        Id jobId = System.enqueueJob(new AddPrimaryContact(contact, 'CA'));
        Test.stopTest();
        
        List<Contact> contacts = [SELECT ID FROM Contact WHERE Contact.Account.billingState = 'CA'];
        System.debug(contacts.size());
        System.assertEquals(200, contacts.size(),'error');
    }
}