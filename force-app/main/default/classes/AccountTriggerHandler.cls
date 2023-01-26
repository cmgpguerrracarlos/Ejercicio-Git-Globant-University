public with sharing class AccountTriggerHandler {

    public static void CreateAccounts(List<Account> newAccounts){
        List<Account> accs = new List<Account>();
        for(Account a: newAccounts){
            if(a.ShippingState <> a.BillingState){
                a.ShippingState = a.BillingState;
            }
        }
    }

}