@isTest

private class findLinksTest {

    static testMethod void runLinks() {

        string searchValueTest = 'sm';
        findLinks.getLinks(searchValueTest,true,searchValueTest);

        findLinks.getAEs();

        id SearchUsingId = 'a0201000002AjoPAAS';
        findLinks.getAccounts(SearchUsingId);
        findLinks.getSubscriptions(SearchUsingId);
        findLinks.getOpps(SearchUsingId);
    }
}