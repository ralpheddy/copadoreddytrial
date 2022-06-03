public with sharing class findLinks {
    // comment
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