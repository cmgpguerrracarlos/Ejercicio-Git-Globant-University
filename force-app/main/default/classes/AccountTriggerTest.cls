@isTest
public with sharing class AccountTriggerTest {

    @isTest
   public static void testHand(){
        List<account> accs = new List<account>();
        for(Integer i=0;i<200;i++){
            Account ac = new Account(
            	Name = 'acc' + i,
                BillingState = 'CA',
                ShippingState = 'CA'
            );
            accs.add(ac);
        }
        Test.startTest();
        system.debug(accs);
        insert accs;
        Test.stopTest();
        List<account> accsRes = [SELECT Id FROM Account];
        
        system.assertEquals(200,accsRes.size() );
        
    }
}