@isTest
public with sharing class CaseTaskHandlerTest {
    
    @testSetUp
    static void setUp(){
        Contact contact = new Contact(FirstName = 'Carlos', LastName= 'Guerra');
        insert contact;
        Task newTask = new Task(Subject = 'test');
        insert newTask;

    }


    @isTest
    static void caseTaskHandlerWillAssignTaskToCaseWithLessThan2Min(){
        
        Task newTask = [SELECT ID,CreatedDate FROM Task LIMIT 1];
        Test.setCreatedDate(newTask.ID, newTask.CreatedDate.addSeconds(-119));
        Case newCase = new Case(Origin = 'Email', Status = 'New');
        insert newCase;
        Task resultTask = [SELECT ID, WhatId, CreatedDate FROM Task LIMIT 1];
        System.assertEquals(newCase.Id, resultTask.WhatId, 'Error to assign case and task');
    }

    @isTest
    static void caseTaskHandlerWillNotAssignTaskToCaseWithMoreThan4Min(){
        Task newTask = [SELECT ID,CreatedDate FROM Task LIMIT 1];

        Test.setCreatedDate(newTask.ID, newTask.CreatedDate.addMinutes(-4));
        Case newCase = new Case(Origin = 'Email', Status = 'New');
        insert newCase;
        Task resultTask = [SELECT ID, WhatId, CreatedDate FROM Task LIMIT 1];
        System.assertEquals(null, resultTask.WhatId, 'Error should not assign task to a case');
    }
    
}