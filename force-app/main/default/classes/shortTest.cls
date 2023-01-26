@isTest
public with sharing class shortTest {
    
    @isTest
    static void test()
    {
        String s = 'asdfgh';
        String r = '';
        Test.startTest();
        r= new StringShorter().shorter(s);
        Test.stopTest();
        System.assertEquals('asdfg',r);
    }
}