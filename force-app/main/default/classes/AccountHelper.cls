public with sharing class AccountHelper {
    @AuraEnabled(Cacheable = true)
    public static List<Case> getCasesByAccountId(Id accountid) {
        List<Case> v1 = [SELECT Id, CaseNumber,CloseReason__c,Status,AccountId 
                        FROM Case 
                        WHERE AccountId =: accountid AND Status != 'Closed' AND CloseReason__c = null
                        WITH SECURITY_ENFORCED
                        ];
        return v1;
    }
}