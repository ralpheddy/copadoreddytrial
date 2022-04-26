public with sharing class newContacts {

    public void makeTwoContacts() {

        LIST<Contact> contacts = new LIST<Contact>();

        Contact c = new Contact();
        c.FirstName = 'Mister';
        c.LastName = 'Eddy';
        c.phone = '111-222-3333';
        contacts.add(c);
        
        Contact ddd = new Contact();
        ddd.FirstName = 'Bill';
        ddd.LastName = 'Gates';
        ddd.email='billy@msn.com';
        contacts.add(ddd);

        insert contacts;
    }
}