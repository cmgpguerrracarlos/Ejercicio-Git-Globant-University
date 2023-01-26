@isTest
public class DailyLeadProcessorTest {
    private static String CRON_EXP = '0 0 0 ? * * *';
	@isTest
    static void dailytest(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0;i<500;i++){
            if(i<250){
                leads.add(new Lead(LastName = 'carlos', Company = 'salesforxe'));
            }else{
                leads.add(new Lead(LastName = 'carlos', Company = 'fuk', LeadSource='other'));
            }
        }
        insert leads;
        
        Test.startTest();
        String jobId = System.Schedule('Process Lead', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        List<Lead> updated = [SELECT Id FROM Lead WHERE LeadSource='Dreamforce'];
        System.assertEquals(200, updated.size(),'error');
        
        List<CronTrigger> cnt = [SELECT ID, TimesTriggered, NextFireTime FROM CronTrigger WHERE ID =: jobid];
        System.debug('');
        
    }
}