public with sharing class AccountsImpl_CMGP extends fflib_SObjectDomain implements Accounts_CMGP{
    public AccountsImpl_CMGP(List<Account> records){
        super(records,Schema.Account.SObjectType);
    }

     public class Constructor implements fflib_SObjectDomain.IConstructable2{
        public fflib_SObjectDomain construct(List<SObject> sObjectList)
        {
            return new AccountsImpl_CMGP(sObjectList);
        }

        public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType)
        {
            return new AccountsImpl_CMGP(sObjectList);
        }
    }
}