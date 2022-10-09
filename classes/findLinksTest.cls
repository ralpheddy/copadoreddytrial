@isTest

private class findLinksTest {

    static testMethod void runLinks() {
        
        AE__c ae = new AE__c(); 
        ae.name = 'name';
        ae.Manager__c = 'm';
        insert ae;
        
        Group__c g = new Group__c();
        g.name = 'test';
        insert g;

        Whitespace__c w = new Whitespace__c();
        insert w;

        string searchValueTest = 'sm';
        
        findLinks.getAEs(searchValueTest);
        findLinks.getManagers();

        id SearchUsingId = 'a0201000002AjoPAAS';
        string fakeId = 'a0201000002AjoPAAS';
        findLinks.getAccounts(SearchUsingId);
        findLinks.getSubscriptions(SearchUsingId);
        findLinks.getOpps(fakeId, fakeId, true);
        findLinks.getOppRows(SearchUsingId);
        findLinks.getRenewals(SearchUsingId);
        findLinks.getWSGroups(SearchUsingId);
        findLinks.getLostRow(SearchUsingId);

        findLinks.getTotalOpen(SearchUsingId);
        findLinks.getTotalSubscription(SearchUsingId);

        findLinks.getLinks(searchValueTest,true,searchValueTest);
    }
}