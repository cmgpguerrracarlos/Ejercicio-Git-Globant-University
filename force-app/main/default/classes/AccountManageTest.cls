@isTest
public with sharing class AccountManageTest {

        @testSetUp
        static void setUp(){
            Account newAccount = new Account(
                Name = 'test',
                Document_number__c = '1234512345',
                Identification_type__c = 'PP',
                Document_Type_Number_Id__c = 'PP1234512345'
                );
                
            insert newAccount;
        }

        @isTest
        static void createAccountTestWillReturnTheNewIdValid(){
            String error = '';
            ID resultId;

            Test.startTest();
            try {
                resultId = AccountManage.createAccount('test',20,'1212121212','CC');
            } catch (Exception e) {
                error = e.getMessage();    
            }            
            Test.stopTest();

            System.assertEquals('', error, 'An error to create the account');
            System.assertNotEquals(null,resultId, 'The id is null');
        }

        @isTest
        static void updateAccountGoodCase(){
            Account originalAcc = [SELECT Id,Name,Document_Type_Number_Id__c FROM Account LIMIT 1];
            
            Test.startTest();
            Boolean isUpdated = AccountManage.updateAccount(originalAcc.Id, 'NewName', 100,'1234512345', 'NIT');
            Test.stopTest();

            System.assertEquals(true,isUpdated, 'Error: should not be updated');
            Account accountAfterUpdate = [
                                            SELECT Name, NumberOfEmployees, 
                                            Identification_type__c, Document_number__c
                                            FROM Account LIMIT 1
                                        ];

            System.assertEquals('NewName', accountAfterUpdate.Name, 'the name was not updated into db');
            System.assertEquals( 100, accountAfterUpdate.NumberOfEmployees, 'the number of employees was not updated into db');
            System.assertEquals('1234512345', accountAfterUpdate.Document_number__c, 'the document number was not updated into db');
            System.assertEquals('NIT', accountAfterUpdate.Identification_type__c, 'the identification type was not updated into db');

        }

        @isTest
        static void updateAccountNegativeCase(){
            String error = '';
            Account originalAcc = [SELECT Id,Name,Document_Type_Number_Id__c FROM Account LIMIT 1];
            Account newAccount = new Account(
                Name = 'test',
                Document_number__c = '1234512345',
                Identification_type__c = 'CC',
                Document_Type_Number_Id__c = 'CC1234512345'
                );
                
            insert newAccount;
            
            Test.startTest();
            
            try {
                Boolean isUpdated = AccountManage.updateAccount(originalAcc.Id, 'NewName', 100,'1234512345', 'CC');
                
            } catch (Exception e) {
                error = e.getMessage();    
            }          
            Test.stopTest();
            
            System.assertNotEquals('', error, 'An error to create the account');

        }

        @istest
        static void deleteAccountTestReturnsIfWasDeleted(){
            Id originalAccId = [SELECT Id FROM Account LIMIT 1].Id;
            Test.startTest();
            Boolean isDeleted= AccountManage.deleteAccount(originalAccId);
            Test.stopTest();

            System.assert(isDeleted, 'Problem to delete the account');
        }

        @isTest
        static void consutAccountTestGivenValidDocTypeAndNumberReturnsTheAccount() {
            Id originalAccId = [SELECT Id FROM Account LIMIT 1].Id;
            Test.startTest();
            Account result = AccountManage.consultAccount('1234512345', 'PP');
            Test.stopTest();
            System.assertNotEquals(null, result, 'Null value of account recived');
            System.assertEquals(originalAccId, result.Id, 'Invalid value of Id recived');
        }

        @isTest
        static void consutAccountTestGivenNoValidDocTypeAndNumberReturnsTheAccount() {
            Id originalAccId = [SELECT Id FROM Account LIMIT 1].Id;
            Test.startTest();
            Account result = AccountManage.consultAccount('1234554321', 'PP');
            Test.stopTest();
            System.assertEquals(null, result, 'Not null value of account recived');
        }

        @isTest
        static void createOpportunityTest(){
            List<Account> accountList = new List<Account>();
            Account acc = new Account(Name = 'acc1', Create_opportunity__c = true);
            insert acc;
            accountList.add(acc);

            Test.startTest();
                AccountManage.createOpportunity(accountList);
            Test.stopTest();

            Opportunity result = [SELECT Name, StageName ,CloseDate FROM Opportunity LIMIT 1];
            Date now = Date.today();
            String name = 'Opportunity' + acc.Name + String.valueOf(now); 
            System.assertEquals(name,result.Name, 'Name diferent');
            System.assertEquals('Prospection',result.StageName, 'Stage diferent');
            System.assertEquals(Date.today().addDays(30),result.CloseDate, 'Closedate diferent');
        }

}