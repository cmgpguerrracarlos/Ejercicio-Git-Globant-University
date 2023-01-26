@isTest
public with sharing class CasesRelatedTest {

    @isTest
    static void willUpdateTwoCasesRelated(){
        Case caseParent = new Case(Status = 'New', Origin = 'Email',Result__c = 'test' );
        insert caseParent;
        caseParent = [SELECT ID,Result__c FROM Case WHERE id = : caseParent.ID];
        Case caseChild = new Case(Status = 'New', Origin = 'Email', ParentId=caseParent.ID, Result__c = 'test');
        insert caseChild;
        Test.startTest();
        update new Case(ID = caseChild.ID, Result__c='Changed');
        Test.stopTest();
        caseParent = [SELECT ID,Result__c FROM Case WHERE id = : caseParent.ID];

        System.assertEquals('Changed', caseParent.Result__c,'Error');
    }

    @isTest
    static void willUpdateTwoCasesRelatedUpdateWithEmptyField(){
        Case caseParent = new Case(Status = 'New', Origin = 'Email',Result__c = 'test' );
        insert caseParent;
        caseParent = [SELECT ID,Result__c FROM Case WHERE id = : caseParent.ID];
        Case caseChild = new Case(Status = 'New', Origin = 'Email', ParentId=caseParent.ID, Result__c = 'test');
        insert caseChild;
        Test.startTest();
        update new Case(ID = caseChild.ID, Result__c='');
        Test.stopTest();
        caseParent = [SELECT ID,Result__c FROM Case WHERE id = : caseParent.ID];

        System.assertEquals(null, caseParent.Result__c,'Error');
    }
}