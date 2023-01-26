public with sharing class CaseTaskHandler {
    
    public static void assigneCaseTask(Case nCase){
        List<Task> tasks = new List<Task>();
        Datetime caseCreated = nCase.CreatedDate;
        Datetime limited = caseCreated.addSeconds(-120);
        tasks = [SELECT ID from Task WHERE OwnerId =: nCase.OwnerId AND CreatedDate > :limited];
        for(Task task: tasks){
            task.WhatId = nCase.Id;
            update task;
        }
    }
}