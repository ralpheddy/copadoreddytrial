@isTest

private class findLinksTest {

    static testMethod void runLinks() {

        string searchValueTest = 'sm';
        findLinks.getLinks(searchValueTest,true,searchValueTest);

        findLinks.getAEs();
        findLinks.getAccounts(searchValueTest);
        findLinks.getSubscriptions(searchValueTest);
    }
}