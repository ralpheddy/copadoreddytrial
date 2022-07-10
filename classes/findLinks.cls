public with sharing class findLinks {
    
    @AuraEnabled(cacheable=true) 
    public static LIST<AE__c> getAEs() {
        LIST<AE__c> AEs = [SELECT id, Name, Region__c, Manager__c, APOid__c, Created_Source__c
                           FROM AE__c 
                           WHERE Active__c=true
                           ORDER BY Name];
       return AEs;
    }

    @AuraEnabled(cacheable=true) 
    public static LIST<Account> getAccounts(id aeId) {
        LIST<Account> Accounts = [SELECT id, Name, Type, URL__c, APOAccountOwner__c,
                                Created_Source__c // AE__c, AE__r.id, 
                           FROM Account 
                           WHERE AE__r.id = :aeId
                           ORDER BY Name];
       return Accounts;
    }

    @AuraEnabled(cacheable=true) 
    public static LIST<Subscription__c> getSubscriptions(id accountId) {
        LIST<Subscription__c> Subscriptions = [SELECT id, Name, 
                                               Account__c, APOAccountId__c, APOAccountName__c,
                                               APOSubscriptionId__c, APOContractId__c, APOcontractURL__c, 
                                               APOAccountOwner__c, APOAccountOwnerManager__c,
                                               Quantity__c, QuantityString__c, Total__c, TotalString__c,
                                               Purchase_Price__c, PurchaseString__c,
                                               // Monthly__c, MonthlyString__c, 
                                               End__c, EndString__c, Start__c, StartString__c,
                                               Contract_End__c, Contract_Start__c, ContractEndString__c, ContractStartString__c,
                                               Contract_Term__c,
                                               Processed__c, ProcessedCreate__c, ProcessedAccountJoin__c
                           FROM Subscription__c 
                           WHERE Account__c = :accountId  // account id in this Salesforce, not APO's
                           ORDER BY Name ];
       return Subscriptions;
    }

    @AuraEnabled(cacheable=true) 
    // public static LIST<Opp__c> getOpps(id accountId) { // }, id allAEid) {
    public static LIST<Opp__c> getOpps(string accountId, string aeId, boolean searchAll) {
        /*
        LIST<Opp__c> Opps = [SELECT id, Name,
                                Account__c, AE__c,
                                ACV_APO__c, ACV_APOString__c, ACVcalculated__c, Amount__c, AmountString__c,
                                APOAccountId__c, APOAccountName__c,
                                APOOppId__c, URL__c,
            Incremental__c, IncrementalString__c,
                                Close_Date__c, CloseString__c,
                                Forecast__c, Stage__c, Type__c,
                                Owner_Name__c
                           FROM Opp__c 
                           WHERE Account__c = :accountId  // account id in this Salesforce, not APO's
                           ORDER BY Name ];
       return Opps;
        */

       
        string q =   'SELECT id, Name, ' +
                        ' Account__c, AE__c, ' +
                        ' ACV_APO__c, ACV_APOString__c, ACVcalculated__c, Amount__c, AmountString__c, ' +
                        ' APOAccountId__c, APOAccountName__c, ' +
                        ' APOOppId__c, URL__c, ' +
                        ' Incremental__c, IncrementalString__c, ' +
                        ' Close_Date__c, CloseString__c, ' +
                        ' Forecast__c, Stage__c, Type__c, ' +
                        ' Owner_Name__c ' +
                    ' FROM Opp__c ' +
                    ' WHERE '; 
                if ( searchAll ) {
                     q+= ' AE__c = \'' + aeId + '\' ';
                } else {
                    q+= ' Account__c = \'' + accountId + '\' '; 
                }
                q+= ' ORDER BY Name ';
        /*             
                        q+= ' AE__c = \'' + aeId + '\' ';
                    } else {
                        q+= ' Account__c = \'' + accountId + '\' ';   // account id in this Salesforce, not APO's
                    }
                q+= ' ORDER BY Name  ';
        // System.Debug(q);  
        */
        return Database.query(q);
        
    } 

    @AuraEnabled(cacheable=true) 
    public static LIST<OppRow__c> getOppRows(id oppSelectedId) {
        LIST<OppRow__c> OppRows = [SELECT id, Name, 
                                Account__c, APOAccountId__c, APOAccountName__c, Account_Type__c,
                                ACV_APO__c, ACV_APOString__c, ACVcalculated__c, Amount__c,
                                Opportunity_Name__c, Opp__c, APOOppId__c,
                                Account_Owner__c, Account_Manager__c,
                                Owner_Name__c, 
                                Close_Date__c, CloseString__c,
                                Forecast__c, Stage__c, Type__c,
                                Product__c, Quantity__c, QuantityString__c, // Monthly__c, MonthlyString__c,
                                Sales_Price__c, SalesPriceString__c,
                                Total__c, TotalString__c,
                                Incremental__c
                                // Product_Code__c, Owner_Role__c, Next_Step__c
                           FROM OppRow__c 
                           WHERE Opp__c = :oppSelectedId  // oppSelectedId id in this Salesforce, not APO's
                           ORDER BY Name ];
       return OppRows;
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