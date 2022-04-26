public with sharing class newContacts {
    public newContacts() {}

    public void makeTwoContacts() {
        Contact c = new Contact();
        c.FirstName = 'Ralph';
        c.LastName = 'Eddy';
        insert c;
        
        Contact cc = new Contact();
        cc.FirstName = 'Bill';
        cc.LastName = 'Bob';
        cc.email='billy@bob.com';
        insert c;
    }
}