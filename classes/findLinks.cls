public with sharing class findLinks {
    // comment
    @AuraEnabled(cacheable=true) 
    public static LIST<link__c> getLinks() {
        String q = 'SELECT id, Name, Details__c ' + 
                    'FROM Link__c ' +
                    'ORDER BY Name';
        
        
        LIST<link__c> links = [SELECT id, Name, Details__c, URL__c FROM Link__c ORDER BY Name];

        // system.debug(q);
        // LIST<link__c> links = Database.query(q);

        return links;
    }
}