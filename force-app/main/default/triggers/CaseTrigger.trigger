trigger CaseTrigger on Case (after insert, after update) {
    if(Trigger.isAfter ){
        if(Trigger.isInsert ){
            CaseTaskHandler.assigneCaseTask(Trigger.new[0]);
        }

        if(Trigger.isUpdate ){
            CasesRelated.handler(Trigger.new);
            
        }
    }

}