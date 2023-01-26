@isTest
public with sharing class AccountServiceTest {
    @isTest
    static void AccountServiceTestRestApiGet(){
        Account accTest = new Account(Name = 'Account test');
        insert accTest;
        Contact assocContact = new Contact(Firstname = 'Carlos', LastName= 'Guerra', AccountId =accTest.ID);
        insert assocContact;
        Opportunity opp = new Opportunity(
                                            Name='New Opp',
                                            StageName='Prospecting',
                                            CloseDate=Date.today().addDays(30), 
                                            AccountId = accTest.Id);
        insert opp;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://globant414-dev-ed.lightning.force.com/services/apexrest/Account/'
            + accTest.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Test.startTest();
        AccountService.WrapperAccoutService result = AccountService.getAccountData();
        Test.stopTest();
        System.assertEquals(accTest.Id, result.account.Id,'Error account no expected');
        System.assertEquals(assocContact.Id, result.contact.Id,'Error contact no expected');
        System.assertEquals(opp.Id, result.opportunity.Id,'Error opportunity no expected');
    }
}