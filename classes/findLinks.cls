public with sharing class findLinks {
    
    @AuraEnabled(cacheable=true) 
    public static LIST<AE__c> getAEs() {
        LIST<AE__c> AEs = [SELECT id, Name, Region__c, Manager__c, APOid__c
                           FROM AE__c 
                           WHERE Active__c=true
                           ORDER BY Name];
       return AEs;
    }

    @AuraEnabled(cacheable=true) 
    public static LIST<Account> getAccounts(id aeId) {
        LIST<Account> Accounts = [SELECT id, Name, Type, URL__c // AE__c, AE__r.id, 
                           FROM Account 
                           WHERE AE__r.id = :aeId
                           ORDER BY Name];
       return Accounts;
    }

    @AuraEnabled(cacheable=true) 
    public static LIST<Subscription__c> getSubscriptions(id accountId) {
        LIST<Subscription__c> Subscriptions = [SELECT id, Name, Account__c, APOSubscriptionId__c, APOcontractURL__c, 
                                               Quantity__c, QuantityString__c, Monthly__c, MonthlyString__c, Total__c, TotalString__c,
                                               End__c, EndString__c, Start__c, StartString__c
                           FROM Subscription__c 
                           WHERE Account__c = :accountId  // account id in this Salesforce, not APO's
                           ORDER BY Name ];
       return Subscriptions;
    }


    @AuraEnabled(cacheable=true) 
    public static LIST<link__c> getLinks(string searchValue, boolean allCheck, string valueOfSelectedType) {

        string whereValue = '%' + searchValue + '%';
        string excludeArchive = ' AND Archived__c = False ';  if (allCheck) excludeArchive = ' ';

        string filterByType = '';
        if (valueOfSelectedType==null || valueOfSelectedType=='' || valueOfSelectedType=='--none--') filterByType = ''; // do nothing
        else filterByType = ' AND Type__c=\'' + valueOfSelectedType + '\''; // + valueOfSelectedType + '\' ';

        String q = 'SELECT id, Name, Details__c, URL__c, Type__c, EditLink__c, Archived__c ' + 
                    ' FROM Link__c ' +
                    ' WHERE name like :whereValue ' +
                    excludeArchive +
                    filterByType +
                    ' ORDER BY Name ';
        
        /*
        LIST<link__c> links = [SELECT id, Name, Details__c, URL__c, Type__c, EditLink__c, Archived__c
                               FROM Link__c 
                               WHERE name like :whereValue 
                               ORDER BY Type__c asc, Name];
        */ 

        // system.debug(q); 
        LIST<link__c> links = Database.query(q);

        return links;
    }
}