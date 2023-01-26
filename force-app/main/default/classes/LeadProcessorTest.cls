@isTest
public with sharing class LeadProcessorTest {
    @isTest
    static void leadProcessorClassTest(){
        
        List<Lead> listName = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            listName.add(new Lead(LastName = 'Connock', Company = 'Salesforce'));
        }
        insert listName;

        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        ID idBa = Database.executeBatch(lp,200);
        Test.stopTest();

        List<Lead> updated =[SELECT ID FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updated.size(),'At least one');
    }
}