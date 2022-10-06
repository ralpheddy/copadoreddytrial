public with sharing class findLinks {
    
    @AuraEnabled(cacheable=true) 
    public static LIST<AE__c> getAEs(string managerName){ // string managerName) {
        /*LIST<AE__c> AEs = [SELECT id, Name, Region__c, Manager__c, APOid__c, Created_Source__c
                           FROM AE__c 
                           WHERE Active__c=true
                           ORDER BY Name];
       return AEs;*/
       // managerName = 'Paul Fox';
       string q = 'SELECT id, Name, Region__c, Manager__c, APOid__c, Created_Source__c ' +
                   ' FROM AE__c ' +
                   ' WHERE Active__c=true ';
                   
                   if ( managerName != null && managerName != '' && managerName != 'All' ) {
                      q += ' AND Manager__c =\'' + managerName + '\' ';
                   }
                   q += ' ORDER BY Name ';
       return Database.query(q);
    }

    @AuraEnabled(cacheable=true) 
    public static LIST<AE__c> getManagers() {
        LIST<AE__c> AEs = [SELECT id, Manager__c FROM AE__c  WHERE Active__c=true ORDER BY Manager__c];
        Set<String> managers = new Set<String>();
        for (Integer i = 0; i< aes.size(); i++)
        {
            managers.add(aes[i].Manager__c); // contains distict managers
        }
        LIST<AE__c> managerAEs = new LIST<AE__c>();
        For ( String s : managers ){
            if ( s!=null && s!='') {
                AE__c ae = new AE__c();
                ae.Manager__c = s;
                managerAEs.add(ae);
            }
        }
        return managerAEs;
    }

    @AuraEnabled(cacheable=true) 
    public static LIST<Account> getAccounts(id aeId) {
        LIST<Account> Accounts = [SELECT id, Name, Type, URL__c, APOAccountOwner__c, 
                                Created_Source__c, Contract_Expiration__c, Multiple_Contracts__c, APOContractId__c, // AE__c, AE__r.id, 
                                Subscription_Total__c
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
                                               Contract_Term__c, Contract_Number__c,
                                               Processed__c, ProcessedCreate__c, ProcessedAccountJoin__c, ProcessedWhiteSpace__c,
                                               SKU__c, Group__c, GroupName__c 
                           FROM Subscription__c 
                           WHERE Account__c = :accountId  // account id in this Salesforce, not APO's
                           ORDER BY Group__r.SortOrder__c]; // Name ];
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
            Owner_Name__c, 
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
                                Incremental__c, IncrementalString__c,
                                SKU__c, GroupLink__c, GroupId__c, GroupName__c
                                // , 
                                // Product_Code__c, Owner_Role__c, Next_Step__c
                           FROM OppRow__c 
                           WHERE Opp__c = :oppSelectedId  // oppSelectedId id in this Salesforce, not APO's
                           ORDER BY SKU__r.Group__r.SortOrder__c]; // Name ];
       return OppRows;
    }

    //not being used
    /*
    @AuraEnabled(cacheable=true) 
    public static LIST<WhiteSpace__c> getWhiteSpace(id accountId) {
        LIST<WhiteSpace__c> ws = [SELECT Account__c, Group__c, GroupName__c, GroupSort__c,
                                         OppTotal__c, OppQuantity__c,
                                         SubTotal__c, SubQuantity__c
                                 FROM WhiteSpace__c 
                                 WHERE Account__c = '0010100000TJrvEAAT' // WHERE Account__c = :accountId
                                 ORDER BY GroupSort__c];
       return ws;
    }*/

    @AuraEnabled(cacheable=true) 
    public static LostRow__c getLostRow(id lostRowId) {
        LIST<LostRow__c> lrs = [SELECT id, Name, Close_Date__c, 
                                    APOAccountName__c,
                                    Lost__c, Lost_Reason__c, Lost_Reason_Additional_Notes__c, Lost_Reason_Detail__c,
                                    Opportunity_Name__c, Total__c,
                                    SKU__c, SKU__r.Name, SKU__r.Group__r.id, Group__c, URL__c
                                 FROM LostRow__c 
                                 WHERE id = 'a0901000003znBfAAI' ];
        LostRow__c lr;
        if ( lrs.size()>0 ) lr = lrs[0];
        else {
            lr = new LostRow__c();
            lr.Lost_Reason__c = 'ERROR: not found';
        }
        return lr;
    }

    
    @AuraEnabled(cacheable=true) 
    public static LIST<Group__c> getWSGroups(id accountId) {
        LIST<Group__c> groups = [SELECT id, Name, OppTotal__c, OppTotalString__c, SubTotal__c, SubTotalString__c, showHasLost__c
                                 FROM Group__c
                                 ORDER BY SortOrder__c];
        // System.Debug(accountId); // 
        // accountId = '0010100000TXOJy'; 
        LIST<WhiteSpace__c> wsAccount = [SELECT id, name, Account__c, Group__c, GroupName__c, 
                                                OppTotal__c, OppQuantity__c, SubTotal__c, SubQuantity__c,
                                                hasLost__c, showHasLost__c, Test__c,
                                                Lost_Reason__c, Lost_Reason_Additional_Notes__c, Lost_Reason_Detail__c,
                                                Opportunity_Name__c, Close_Date__c, LostTotal__c, Product__c,
                                                AccountName__c, LostOppURL__c
                                         FROM WhiteSpace__c 
                                         WHERE Account__c = :accountId
                                         ORDER BY GroupSort__c];
        LIST<Group__c> wsGroups  = new LIST<Group__c>();
        for (Integer i = 0; i < groups.size(); i++) { // for (Group__c groups : group) {
            Group__c newWS = new Group__c();
            newWS.Name = groups[i].Name;
            for ( WhiteSpace__c ws : wsAccount ){
                if ( groups[i].Id == ws.Group__c ) { 
                    if ( newWS.OppTotal__c == null ) newWS.OppTotal__c = 0; // set to 0 if null
                    if ( newWS.SubTotal__c == null ) newWS.SubTotal__c = 0; // set to 0 if null
                    if ( ws.OppTotal__c != null ) newWS.OppTotal__c += ws.OppTotal__c; // groups[i].OppTotal__c = 0;
                    if ( newWS.OppTotal__c != 0 ) newWS.hasOpen__c = true;
                    if ( ws.SubTotal__c != null ) newWS.SubTotal__c += ws.SubTotal__c; //groups[i].SubTotal__c = 0;
                    if ( newWS.SubTotal__c !=0 ) newWs.hasLicenses__c = true;
                    newWS.Opportunity_Name__c = ws.Opportunity_Name__c;
                    newWS.AccountName__c = ws.AccountName__c;
                    newWS.Close_Date__c = ws.Close_Date__c;
                    newWS.LostTotal__c = ws.LostTotal__c;
                    newWS.Product__c = ws.Product__c;
                    newWS.LostOppURL__c = ws.LostOppURL__c;
                    newWS.Lost_Reason__c = ws.Lost_Reason__c;
                    newWs.Lost_Reason_Additional_Notes__c = ws.Lost_Reason_Additional_Notes__c;
                    newWs.Lost_Reason_Detail__c = ws.Lost_Reason_Detail__c;
                    newWS.showHasLost__c = ws.showHasLost__c;
                    
                    // newWS.Name = 'success';
                }
            }
            wsGroups.add(newWS);
        }
        return wsGroups;
    }

    @AuraEnabled(cacheable=true) 
    public static decimal getTotalOpen(id accountId) {
        LIST<WhiteSpace__c> wsAccount = [SELECT id, OppTotal__c, SubTotal__c FROM WhiteSpace__c WHERE Account__c = :accountId ];
        decimal open = 0;
        decimal sub = 0;
        for ( WhiteSpace__c ws : wsAccount ){
            if ( ws.OppTotal__c != null ) open += ws.OppTotal__c; // groups[i].OppTotal__c = 0;
            if ( ws.SubTotal__c != null ) sub += ws.SubTotal__c; //groups[i].SubTotal__c = 0;
        }
        return open;
    }
    @AuraEnabled(cacheable=true) 
    public static decimal getTotalSubscription(id accountId) {
        LIST<WhiteSpace__c> wsAccount = [SELECT id, OppTotal__c, SubTotal__c FROM WhiteSpace__c WHERE Account__c = :accountId ];
        decimal open = 0;
        decimal sub = 0;
        for ( WhiteSpace__c ws : wsAccount ){
            if ( ws.OppTotal__c != null ) open += ws.OppTotal__c; // groups[i].OppTotal__c = 0;
            if ( ws.SubTotal__c != null ) sub += ws.SubTotal__c; //groups[i].SubTotal__c = 0;
        }
        return sub;
    }




    // GET LINKS
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