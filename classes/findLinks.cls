public with sharing class findLinks {
    // comment
    @AuraEnabled(cacheable=true) 
    public static LIST<link__c> getLinks(string searchValue) {

        string whereValue = '%' + searchValue + '%';
        
        String q = 'SELECT id, Name, Details__c, URL__c, Type__c, EditLink__c ' + 
                    ' FROM Link__c ' +
                    ' WHERE name like :whereValue ' +
                    ' ORDER BY Name';
        
        /*
        LIST<link__c> links = [SELECT id, Name, Details__c, URL__c, Type__c, EditLink__c 
                               FROM Link__c 
                               WHERE name like :whereValue 
                               ORDER BY Type__c asc, Name];
        */ 

        // system.debug(q); //
        LIST<link__c> links = Database.query(q);

        return links;
    }
}