@RestResource(urlMapping='/Account/*')
global with sharing class AccountService {
    @HttpGet
    global static WrapperAccoutService getAccountData() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account resultAccount =  [SELECT Id,Name
                        FROM Account
                        WHERE Id = :accId];
        Contact mainContact  = [SELECT Id,FirstName,LastName FROM Contact WHERE AccountId =: accId LIMIT 1];
        Opportunity lastOpportunity = [SELECT Id, Name FROM Opportunity WHERE AccountId =: accId ORDER BY CreatedDate DESC LIMIT 1];
        WrapperAccoutService result = new WrapperAccoutService();
        result.account = resultAccount;
        result.Contact = mainContact;
        result.opportunity = lastOpportunity; 
        return result;
    }

    global class WrapperAccoutService{
      public Account account{get;set;}
      public Contact Contact{get;set;}
      public Opportunity opportunity {get;set;}

    }
}