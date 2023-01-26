@RestResource(urlMapping='/case/*/close')
global with sharing class CaseCloseResource {
	@HttpPost
    global static void closeCase(String closeCaseReason) {
        // Parse context
        RestRequest req = RestContext.request;
        String[] uriParts = req.requestURI.split('/');
        Id caseId = uriParts[2];
        Set<Id> ids =new Set<Id>();
        ids.add(caseId);
        CaseService.closeCases( ids, closeCaseReason);     
    }
}