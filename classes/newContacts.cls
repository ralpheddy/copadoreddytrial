public with sharing class newContacts {
    public newContacts() {}

    public void makeDoubleContacts() {
        Contact c = new Contact();
        c.FirstName = 'Mister';
        c.LastName = 'Eddy';
        c.phone = '111-222-3333';
        insert c;
        
        // lots of comments
        Contact cc = new Contact();
        cc.FirstName = 'Bill';
        cc.LastName = 'Gates';
        cc.email='billy@msn.com';
        insert c;
    }
}