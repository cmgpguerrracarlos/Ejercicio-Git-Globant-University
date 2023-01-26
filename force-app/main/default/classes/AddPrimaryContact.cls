public with sharing class AddPrimaryContact implements Queueable{
	private Contact cont;
    private String state;
    public AddPrimaryContact(Contact records, String stateAbbreviation) {
        this.cont = records;
        this.state = stateAbbreviation;
    }
    
    public void execute(QueueableContext context) {
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200];
        List<Contact> contacts = new List<Contact>();
        
        for (Account account : accounts) {
           Contact cloneContact = cont.clone();
            cloneContact.AccountId = account.ID;
          contacts.add(cloneContact);
        }
        insert contacts;
    }
}