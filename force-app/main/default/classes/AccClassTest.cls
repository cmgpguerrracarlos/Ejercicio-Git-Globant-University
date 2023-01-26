@isTest
public with sharing class AccClassTest {
    
    @isTest
    static void casoreturntrue(){
        String val = 'true';
        Test.startTest();
        String result = AccClass.metododeprueba(val);
        Test.stopTest();

        System.assertEquals('false', result,'ggggggggggggggggggggg');
    }
    @isTest
    static void casoreturnfalse(){
        String val = 'false';
        Test.startTest();
        String result = AccClass.metododeprueba(val);
        Test.stopTest();

        System.assertEquals('true',result,'ggggggggggggggggggggg');
    }

    @isTest
    static void casoreturnnull(){
        String val = null;
        Test.startTest();
        String result = AccClass.metododeprueba(val);
        Test.stopTest();

        System.assertEquals('false',result,'ggggggggggggggggggggg');
    }

    @isTest
    static void casoreturnother(){
        String val = 'fd';
        Test.startTest();
        String result = AccClass.metododeprueba(val);
        Test.stopTest();

        System.assertEquals('',result,'ggggggggggggggggggggg');
    }
}