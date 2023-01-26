public with sharing class CasesRelated {

    public static void handler(List<Case> cases){
        Map<ID,String> results = new Map<Id,String>();
        for(Case ncase :cases){
            if(ncase.ParentId != null){
                results.put(ncase.ParentId, ncase.Result__c);
            }
        }

        List<Case> totalCases = [SELECT ID, Result__c FROM Case WHERE ID IN :results.keySet()];
        for(Case c: totalCases){
            c.Result__c = results.get(c.ID);
        }
        update totalCases;
    }
}