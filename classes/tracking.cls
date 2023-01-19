public with sharing class tracking {

    public List<Contact> contacts {get;set;}
    public integer numContacts {get; set;}
    
    public List<Contact> contactsByState {get;set;}
    public integer numContactsByState {get; set;}
    
    public tracking(){
        contacts = [select Id, Name, Email, MailingState, MailingCity from Contact order by Name];
        numContacts = contacts.size();
    }
    
    public void findContactsByState (string state){
        contactsByState = [select Id, Name, Email, MailingState, MailingCity 
                           from Contact 
                           where MailingState = :state
                           order by Name];
        numContactsByState = contactsByState.size();
    }
}