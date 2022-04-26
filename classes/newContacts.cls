public with sharing class newContacts {
    public newContacts() {}

    public void makeTwoContacts() {

        LIST<Contact> contacts = new LIST<Contact>();

        Contact c = new Contact();
        c.FirstName = 'Ralph';
        c.LastName = 'Eddy';
        contacts.add(c);
        
        Contact cc = new Contact();
        cc.FirstName = 'Bill';
        cc.LastName = 'Bob';
        cc.email='billy@bob.com';
        contacts.add(cc);

        insert contacts;
    }
}