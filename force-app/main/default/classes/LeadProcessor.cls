public with sharing class LeadProcessor implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator([SELECT id, Name From Lead]);
    }
    public void execute(Database.BatchableContext bc, List<Lead> leads){
        // process each batch of records
        for(Lead l: leads){
            l.LeadSource = 'Dreamforce';
        }
        update leads;
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug('Done');
    }
}