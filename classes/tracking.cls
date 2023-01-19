public with sharing class tracking {

    public List<Contact> contacts {get;set;}
    public integer countAllContacts {get; set;}
    
    public List<Contact> contactsInState {get;set;}
    public integer countContactsByState {get; set;}
    
    public tracking(){
        contacts = [select Id, Name, Email, MailingState, MailingCity from Contact order by Name];
        countAllContacts = contacts.size();
    }
    
    public void findContactsByState (string state){
        contactsInState = [select Id, Name, Email, MailingState, MailingCity 
                           from Contact 
                           where MailingState = :state
                           order by Name];
        countContactsByState = contactsInState.size();
    }
}