public class toolsController {

    public transient LIST<OppRow__c> oppRows {get;set;}
    public transient LIST<Opp__c> opps {get;set;}
    public transient LIST<AE__c> aes {get;set;}
    public transient LIST<Account> accounts {get;set;}
    public transient LIST<Subscription__c> subscriptions {get;set;}

    public string comment {get;set;}
    public boolean found;
    public integer countDeletedAEs {get;set;}
    public integer countCreatedAEs {get;set;}
    public integer countDeletedAccounts {get;set;}
    public integer countCreatedAccounts {get;set;}
    public integer countDeletedOpps {get;set;}
    public integer countCreatedOpps {get;set;}
    public integer countCreatedOppsRunningTotalOppRowsProcessed {get;set;}
    public string commentOppsProcessed {get;set;}
    public integer countDeletedOppRows {get;set;}
    public integer countJoinOppRowsToOpps {get;set;}
    
    public integer countClearProcessed {get;set;}
    public integer countClearProcessedSubs {get;set;}

    public integer countDeletedSubscriptions {get;set;}
    public integer countCreatedAEsSub {get;set;}
    public string commentCreateAEsFromSubscriptions {get;set;}
    public integer countCreatedAccountsSub {get;set;}
    public integer countCreateAccountFromSubscriptionsRunningTotalProcessed {get;set;}
    public string commentSubscriptionsProcessedForCreate {get;set;}
    public integer countJoinSubscriptionsRunningTotalProcessed {get;set;}
    public string commentSubscriptionsProcessed {get;set;}
    
    public toolsController(){
        countCreatedOppsRunningTotalOppRowsProcessed = 0;
        countJoinSubscriptionsRunningTotalProcessed = 0;
        countCreateAccountFromSubscriptionsRunningTotalProcessed = 0;
        comment = '';
    }
    
    // LOAD
    public void LoadOppRows(){
        oppRows = [SELECT id, Name, 
                    Account__c, APOAccountId__c, APOAccountName__c, Account_Type__c,
                    ACV_APO__c, ACV_APOString__c, ACVcalculated__c, Amount__c,
                    Opportunity_Name__c, Opp__c, APOOppId__c,
                    Account_Owner__c, Account_Manager__c,
                    Owner_Name__c, 
                    Close_Date__c, CloseString__c,
                    Forecast__c, Stage__c, Type__c,
                    Product__c, Quantity__c, QuantityString__c, 
                    Sales_Price__c, SalesPriceString__c,
                    Total__c, TotalString__c,
                    ProcessedOpp__c, ProcessedOppRow__c
                    // Product_Code__c, Owner_Role__c, Next_Step__c
                   FROM OppRow__c 
                   ];
    }
    public void LoadAEs(){
        aes = [SELECT id, Name, Manager__c from AE__c];
    }
    public void LoadAccounts(){
        accounts = [SELECT id, Name, AE__c, Type, APOAccountId__c, Created_Source__c from Account];
    }
    public void LoadOpps(){
        opps = [SELECT id, Name,
                Account__c, AE__c,
                ACV_APO__c, ACV_APOString__c, ACVcalculated__c, Amount__c,
                APOAccountId__c, APOAccountName__c,
                APOOppId__c, URL__c,
                Close_Date__c, CloseString__c,
                Forecast__c, Stage__c, Type__c,
                Owner_Name__c
           FROM Opp__c];
    }
    public void LoadSubscriptions(){
        subscriptions = [SELECT id, Name, 
                                Account__c, APOAccountId__c, APOAccountName__c,
                                APOSubscriptionId__c, APOContractId__c, APOcontractURL__c, 
                                APOAccountOwner__c, APOAccountOwnerManager__c,
                                Quantity__c, QuantityString__c, Total__c, TotalString__c,
                                Purchase_Price__c, PurchaseString__c,
                                End__c, EndString__c, Start__c, StartString__c,
                                Processed__c, ProcessedCreate__c, ProcessedAccountJoin__c
                         FROM Subscription__c];
    }
    
    
    // AEs
    public void deleteAllAEs(){
        aes = [SELECT id from AE__c];
        countDeletedAEs = aes.size();
        delete aes;
    }
    // Create AEs From OppRows
    public void CreateAEsFromRows(){
        LoadOppRows();
        LIST<AE__c> newAEs = new LIST<AE__c>();
        countCreatedAEs = 0;
        for (OppRow__c oppRow : oppRows ){
            string aeOR = oppRow.Account_Owner__c;
            found = false;
            for (Integer i = 0; i < newAEs.size(); i++) {
                AE__c newAE = newAEs[i];
                if ( aeOR.equals(newAE.name )) { 
                   found = true;
                   i = newAEs.size() + 1; // stop the loop
                }
            }
            if ( found == false ) {
                AE__c ae = new AE__c();
                ae.name = aeOR;
                ae.Manager__c = oppRow.Account_Manager__c;
                ae.Created_Source__c = 'OppRow';
                newAEs.add(ae);
                countCreatedAEs++;
            }
        }
        insert newAEs;
    }
    
    
    public void deleteAllAccounts(){
        accounts = [SELECT id from Account];
        countDeletedAccounts = accounts.size();
        delete accounts;
    }
    public void CreateAccountsFromRows(){
        LoadOppRows();
        LoadAEs();
        countCreatedAccounts = 0;        
        LIST<Account> newAccounts = new LIST<Account>();
        for (OppRow__c oppRow : oppRows ){
            string accountAPOid = oppRow.APOAccountId__c;
            found = false;
            for (Integer i = 0; i < newAccounts.size(); i++) {
               if ( accountAPOid.equals(newAccounts[i].APOAccountId__c )) { // already in the new list
                   found = true;
                   i = newAccounts.size() + 1;  // stop the loop
               }
            }
            if ( found == false ){ // not found, add it
                Account a = new Account();
                a.name = oppRow.APOAccountName__c;
                a.APOAccountId__c = oppRow.APOAccountId__c;
                a.Type = oppRow.Account_Type__c;
                a.Created_Source__c = 'OppRow';
                string accOwner = oppRow.Account_Owner__c;
                for (AE__c ae : aes ){
                    if ( accOwner == ae.name ) a.AE__c = ae.Id;
                }
                newAccounts.add(a);
                countCreatedAccounts++;
            }
        }
        insert newAccounts;
    }
    
    
    public void deleteAllOpps(){
        opps = [SELECT id from Opp__c];
        countDeletedOpps = opps.size();
        delete opps;
    }
    public void CreateOppsFromRows(){
        LoadOppRows();
        LoadAEs();
        LoadAccounts();
        integer countForLoop = 0;
        countCreatedOpps = 0;
        LIST<Opp__c> newOpps = new LIST<Opp__c>();
        for (Integer j = 0; j < oppRows.size(); j++) { // for (OppRow__c oppRow : oppRows ){
            if ( oppRows[j].ProcessedOpp__c == false ) {
                string APOOppId = oppRows[j].APOOppId__c;
                found = false;
                for (Integer i = 0; i < newOpps.size(); i++) {
                   if ( APOOppId.equals(newOpps[i].APOOppId__c )) { // match, already in the new list
                       found = true;
                       i = newOpps.size() + 1;  // stop the loop
                   }
                }
                if ( found == false ){ // not found, add it
                    Opp__c opp = new Opp__c();
                    string oppName = oppRows[j].Opportunity_Name__c;
                    if ( oppName.length() > 80 ) oppName = oppName.substring(0,80);
                    opp.name = oppName;
                    opp.APOOppId__c = oppRows[j].APOOppId__c;
                    opp.ACV_APO__c = oppRows[j].ACV_APO__c;
                    opp.APOAccountId__c = oppRows[j].APOAccountId__c;
                    opp.APOAccountName__c = oppRows[j].APOAccountName__c;
                    opp.Close_Date__c = oppRows[j].Close_Date__c;
                    opp.Forecast__c = oppRows[j].Forecast__c;
                    opp.Stage__c = oppRows[j].Stage__c;
                    opp.Type__c = oppRows[j].Type__c;
                    opp.Owner_Name__c = oppRows[j].Owner_Name__c;
                                    
                    string accountAPOid = oppRows[j].APOAccountId__c;
                    for (Account acc : accounts ){
                        if ( accountAPOid == acc.APOAccountId__c ) opp.Account__c = acc.Id;
                    }
                    string accOwner = oppRows[j].Account_Owner__c;
                    for (AE__c ae : aes ){
                        if ( accOwner == ae.name ) opp.AE__c = ae.Id;
                    }
                    newOpps.add(opp);
                    countCreatedOpps++;
                }
                oppRows[j].ProcessedOpp__c = true;
                countForLoop++;
                if (countForLoop>999) j = oppRows.size() + 1;  // stop the loop
            }
        }
        countCreatedOppsRunningTotalOppRowsProcessed += countForLoop;
        commentOppsProcessed = 'Processed ' + countForLoop + ' of ' + countCreatedOppsRunningTotalOppRowsProcessed + ' in ' + oppRows.size();
        update oppRows;
        insert newOpps;
    }
    
    
    
    public void deleteAllOppRows(){
        oppRows = [SELECT id from OppRow__c];
        countDeletedOppRows = oppRows.size();
        delete oppRows;
    }
    public void joinOppRowsToOpps(){
        LoadOpps();
        LoadOppRows();
        countJoinOppRowsToOpps = 0;
        for (OppRow__c oppRow : oppRows ){
            string APOOppId = oppRow.APOOppId__c;
            for (Integer i = 0; i < opps.size(); i++) {
               if ( APOOppId.equals(opps[i].APOOppId__c )) { // match
                   oppRow.Opp__c = opps[i].Id;
                   countJoinOppRowsToOpps++;
                   i = opps.size() + 1;  // stop the loop
               }
            }
        }
        update oppRows;
    }
    
    public void clearOppRowProcessed(){
        LIST<OppRow__c> ops = [select id, ProcessedOpp__c, ProcessedOppRow__c from OppRow__c];
        for (OppRow__c op : ops ){
            op.ProcessedOpp__c = false;
            op.ProcessedOppRow__c = false;
        }
        countClearProcessed = ops.size();
        update ops;
    }

    public void createAEsFromSubscriptions(){
        LoadSubscriptions();
        LoadAEs();
        LIST<AE__c> newAEs = new LIST<AE__c>();
        countCreatedAEsSub = 0;
        integer countProcessed = 0;
        for (Integer j = 0; j < subscriptions.size(); j++) {
            string aeSub = subscriptions[j].APOAccountOwner__c;
            found = false;
            for (Integer i = 0; i < newAEs.size(); i++) {
                if ( aeSub == newAEs[i].name ) { 
                   found = true;
                   i = newAEs.size() + 1; // stop the loop
                }
            }
            if ( found == false ) {
                for (Integer k =0; k < aes.size(); k++ ){
                    if ( aeSub == aes[k].name ) {
                        found = true;
                        k = aes.size() + 1; // stop the loop
                    }
                } 
            }
            if ( found == false ) {
                AE__c ae = new AE__c();
                ae.name = aeSub;
                comment+=aeSub;
                ae.Manager__c = subscriptions[j].APOAccountOwnerManager__c;
                ae.Created_Source__c = 'Subscription';
                newAEs.add(ae);
                countCreatedAEsSub++;
            }
            subscriptions[j].Processed__c = true;
            countProcessed++;
            // if ( j > 1 ) j = subscriptions.size() +1;
        }
        commentCreateAEsFromSubscriptions = 'Processed: ' + countProcessed;
        insert newAEs;
        update subscriptions;
    }
    
    public void createAccountsFromSubscriptions(){
        // ProcessedCreate__c
        // s.Created_Source__c = 'Subscription';
        // countCreateAccountFromSubscriptionsRunningTotalProcessed
        // commentSubscriptionsProcessedForCreate
        LoadSubscriptions();
        LoadAccounts();
        LIST<Account> newAccounts = new LIST<Account>();
        countCreatedAccountsSub = 0;
        integer countProcessed = 0;
        for (Integer j = 0; j < subscriptions.size(); j++) {
            string accountSub = subscriptions[j].APOAccountId__c;  //
            found = false;
            for (Integer i = 0; i < newAccounts.size(); i++) {
                if ( subscriptions[j].APOAccountId__c.equals(newAccounts[i].APOAccountId__c )) { 
                   found = true;
                   i = newAccounts.size() + 1; // stop the loop
                }
            }
            if ( found == false ) {
                for (Integer k =0; k < accounts.size(); k++ ){
                    if ( subscriptions[j].APOAccountId__c.equals(accounts[k].APOAccountId__c) ) {
                        found = true;
                        k = accounts.size() + 1; // stop the loop
                    }
                } 
            }
            if ( found == false ) {
                Account acc = new Account();
                acc.name = subscriptions[j].APOAccountName__c; 
                acc.APOAccountId__c = subscriptions[j].APOAccountId__c;
                acc.Created_Source__c = 'Subscription';
                newAccounts.add(acc);
                countCreatedAccountsSub++;
            }
            subscriptions[j].ProcessedCreate__c = true;
            countProcessed++;
            // if ( j > 999 ) j = subscriptions.size() +1;
        }
        commentSubscriptionsProcessedForCreate = 'Processed: ' + countProcessed;
        insert newAccounts;
        update subscriptions;
    }
    
    public void joinSubscriptionsToAccounts(){
        LoadAccounts();
        LoadSubscriptions();
        integer countForLoop = 0;
        for (Integer j = 0; j < subscriptions.size(); j++) { // for (Subscription__c sub : subscriptions ){
            if ( subscriptions[j].ProcessedAccountJoin__c == false ) {
                for (Integer i = 0; i < accounts.size(); i++) {
                    if ( subscriptions[j].APOaccountId__c.equals(accounts[i].APOaccountId__c )){  // if ( subscriptions[j].APOaccountId__c == accounts[i].APOaccountId__c ){
                        subscriptions[j].Account__c = accounts[i].Id;
                        i = accounts.size() + 1;  // stop the loop
                    }
                    subscriptions[j].ProcessedAccountJoin__c = true;
                }
                countForLoop++;
            }
            if (countForLoop>999) j = subscriptions.size() + 1;  // stop the loop
        }
        countJoinSubscriptionsRunningTotalProcessed+= countForLoop;

        commentSubscriptionsProcessed = 'Processed ' + countForLoop + ' of ' + countJoinSubscriptionsRunningTotalProcessed  + ' in ' + subscriptions.size();
        // commentOppsProcessed = 'Processed ' + countForLoop + ' of ' + countCreatedOppsRunningTotalOppRowsProcessed + ' in ' + subscriptions.size();
        update subscriptions;
    }
    
        
    public void deleteAllSubscriptions(){
        subscriptions = [SELECT id from Subscription__c];
        countDeletedSubscriptions = subscriptions.size();
        delete subscriptions;
    }
    
    public void clearSubscriptionsProcessed(){
        LIST<Subscription__c> subs = [select id, Processed__c, ProcessedCreate__c, ProcessedAccountJoin__c from Subscription__c];
        for (Subscription__c sub: subs ){
            sub.Processed__c = false;
            sub.ProcessedCreate__c = false;
            sub.ProcessedAccountJoin__c = false;
        }
        countClearProcessedSubs = subs.size();
        update subs;
    }
    
    
    
    
    
    
    
    
    
    
    
}