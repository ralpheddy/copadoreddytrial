@isTest

private class findLinksTest {

    static testMethod void runLinks() {
        
        AE__c ae = new AE__c(); 
        ae.name = 'name';
        ae.Manager__c = 'm';
        insert ae;
        
        string searchValueTest = 'sm';
        findLinks.getLinks(searchValueTest,true,searchValueTest);

        findLinks.getAEs();

        id SearchUsingId = 'a0201000002AjoPAAS';
        string fakeId = 'a0201000002AjoPAAS';
        findLinks.getAccounts(SearchUsingId);
        findLinks.getSubscriptions(SearchUsingId);
        findLinks.getOpps(fakeId, fakeId, true);
        findLinks.getOppRows(SearchUsingId);
        findLinks.getWSGroups(SearchUsingId);

        findLinks.getManagers();
    }
}