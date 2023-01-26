trigger CaseTask on Case (after insert) {
    if(Trigger.isAfter && Trigger.isInsert ){
        CaseTaskHandler.assigneCaseTask(Trigger.new[0]);
    }
}