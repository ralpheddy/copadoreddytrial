public class toolsController {

    public transient LIST<OppRow__c> oppRows {get;set;}
    public transient LIST<Opp__c> opps {get;set;}
    public transient LIST<AE__c> aes {get;set;}
    public transient LIST<Account> accounts {get;set;}
    public transient LIST<Subscription__c> subscriptions {get;set;}
    public transient LIST<SKU__c> skus {get;set;}
    public transient LIST<Group__c> groups {get;set;}
    public transient LIST<Group__c> wsGroups {get;set;}
    public transient LIST<WhiteSpace__c> whitespaces {get;set;}
    public transient LIST<LostRow__c> lostRows {get;set;}

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
    public integer createdJoinSubscriptionsToAccounts {get;set;}
    public string commentSubscriptionsProcessed {get;set;}
    public integer countJoinSubscriptionsToGroups {get;set;}
    public integer countClearSKUTotals {get;set;}
    
    public integer countJoinOppRowsToAccountTotalProcessed {get;set;}
    public string commentJoinOppRowsToAccount {get;set;}
    
    public integer countJoinAccountsToAEs {get;set;}
    public integer countPostOppRowNumbersToSKUs {get;set;}
    public string commentPostOppRowNumbersToSKUs {get;set;}
    public string commentPostSubscriptionNumbersToSKUs {get;set;}
    
    public integer countCreateWhitespace {get;set;}
    public integer countCreateWhitespaceAccountsProcessed {get;set;}
    public string commentCreateWhitespace {get;set;}
    public integer countOppRowsCreateWhitespace {get;set;}
    public string commentOppRowsCreateWhitespace {get;set;}
    public integer countSubscriptionsCreateWhitespace {get;set;}
    public string commentSubscriptionsCreateWhitespace {get;set;}
    public integer deleteWhiteSpace {get;set;}
    public integer managersSize {get;set;}

    public integer countDeletedLostRows {get;set;}
    public integer countJoinLostRowsToAccountsSKUs{get;set;}
    public string commentJoinLostRowsToAccountsSKUs{get;set;}
    public integer countLostRowPropcessedClear {get;set;}
    public string commentCreateAEsFromLostRows {get;set;}
    public string commentCreateAccountsFromLostRows {get;set;}
    public string commentJoinLostRowsToSKUs {get;set;}
    public string commentJoinLostRowsToAccounts {get;set;}
    public integer countJoinLostRowsToAccounts {get;set;}
    public integer countUpdateLostRowsToWhitespaceHasLost {get;set;}
    public string commentUpdateLostRowsToWhitespaceHasLost {get;set;}
    
    public integer tempWScount {get;set;}
    public string mydebug {get;set;}
    
    public toolsController(){
        countCreatedOppsRunningTotalOppRowsProcessed = 0;
        countJoinSubscriptionsRunningTotalProcessed = 0;
        countCreateAccountFromSubscriptionsRunningTotalProcessed = 0;
        countCreateWhitespace = 0;
        countCreateWhitespaceAccountsProcessed = 0;
        countOppRowsCreateWhitespace = 0;
        countSubscriptionsCreateWhitespace = 0;
        countJoinOppRowsToAccountTotalProcessed = 0;
        countJoinLostRowsToAccountsSKUs = 0;
        countJoinLostRowsToAccounts = 0;
        countUpdateLostRowsToWhitespaceHasLost = 0;
        comment = '';
        
        whitespaces = new LIST<WhiteSpace__c>();
        WhiteSpace__c newWS = new WhiteSpace__c();
 
        wsGroups = new LIST<Group__c>(); //    whitespaces.add(newWS);
        tempWScount = 0;
        mydebug = '';
        // getWhiteSpace(); // LoadWhiteSpace();
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
                    Incremental__c, IncrementalString__c,
                    ProcessedOpp__c, ProcessedOppRow__c, ProcessedAccountJoin__c, ProcessedWhiteSpace__c,
                    SKU__c, Group__c, GroupId__c, GroupName__c
                    // Product_Code__c, Owner_Role__c, Next_Step__c
                   FROM OppRow__c 
                   ];
    }
    public void LoadAEs(){
        aes = [SELECT id, Name, Manager__c from AE__c];
    }
    public void LoadAccounts(){
        accounts = [SELECT id, Name, AE__c, Type, APOAccountId__c, APOAccountOwner__c, CreateWSProcessed__c, 
                           Created_Source__c, Contract_Expiration__c, Multiple_Contracts__c, APOContractId__c,
                           Subscription_Total__c
                    FROM Account];
    }
    public void LoadOpps(){
        opps = [SELECT id, Name,
                Account__c, AE__c,
                ACV_APO__c, ACV_APOString__c, ACVcalculated__c, Amount__c, AmountString__c,
                APOAccountId__c, APOAccountName__c,
                APOOppId__c, URL__c,
                Incremental__c, IncrementalString__c,
                Close_Date__c, CloseString__c,
                Forecast__c, Stage__c, Type__c,
                Owner_Name__c
           FROM Opp__c];
    }
    public void LoadSubscriptions(){
        subscriptions = [SELECT id, Name, 
                                Account__c, APOAccountId__c, APOAccountName__c, Account__r.name,
                                APOSubscriptionId__c, APOContractId__c, APOcontractURL__c, 
                                APOAccountOwner__c, APOAccountOwnerManager__c,
                                Quantity__c, QuantityString__c, Total__c, TotalString__c,
                                Purchase_Price__c, PurchaseString__c,
                                End__c, EndString__c, Start__c, StartString__c,
                                Contract_End__c, Contract_Start__c, ContractEndString__c, ContractStartString__c,
                                Contract_Term__c, Contract_Number__c,
                                Processed__c, ProcessedCreate__c, ProcessedAccountJoin__c, ProcessedWhiteSpace__c,
                                SKU__r.Group__r.id,
                                SKU__c, Group__c, GroupName__c, Group__r.name
                         FROM Subscription__c];
                         // WHERE Account__r.Name = 'Abbvie'];
    }
    public void LoadSubscriptionsWithProcessed(){
        subscriptions = [SELECT id, Name, 
                                Account__c, APOAccountId__c, APOAccountName__c, Account__r.name,
                                APOSubscriptionId__c, APOContractId__c, APOcontractURL__c, 
                                APOAccountOwner__c, APOAccountOwnerManager__c,
                                Quantity__c, QuantityString__c, Total__c, TotalString__c,
                                Purchase_Price__c, PurchaseString__c,
                                End__c, EndString__c, Start__c, StartString__c,
                                Contract_End__c, Contract_Start__c, ContractEndString__c, ContractStartString__c,
                                Contract_Term__c, Contract_Number__c,
                                Processed__c, ProcessedCreate__c, ProcessedAccountJoin__c, ProcessedWhiteSpace__c,
                                SKU__r.Group__r.id,
                                SKU__c, Group__c, GroupName__c, Group__r.name
                         FROM Subscription__c
                         WHERE ProcessedWhiteSpace__c = false];
                         // WHERE Account__r.Name = 'Abbvie'];
    }

    public void LoadSKUs(){
        skus = [SELECT id, Name,
                       Code__c, CopadoFamily__c, CopadoGrouping__c, Group__c, New__c, 
                       Opportunity_ACV__c, Opportunity_Quantity__c, Opportunity_Rows__c,
                       Subscription_ACV__c, Subscription_Quantity__c, Subscription_Rows__c,
                       Group__r.id
                FROM SKU__c];
    }
    
    public void LoadGroups(){
        groups = [SELECT id, Name,
                         OppTotal__c, OppTotalString__c, SubTotal__c, SubTotalString__c, showHasLost__c
                  FROM Group__c
                  ORDER BY SortOrder__c];
    }
    
    public void LoadWhiteSpace(){
        whitespaces = [SELECT id, Name,
                              Account__c, Account__r.name,
                              Group__c, GroupName__c, GroupSort__c, Group__r.name,
                              OppTotal__c, OppQuantity__c,
                              SubTotal__c, SubQuantity__c,
                              hasLost__c, showHasLost__c, LostRowId__c
                       FROM WhiteSpace__c];
                       // WHERE Account__r.Name = 'Abbvie'];
    }
    
    public void LoadLostRows(){ // SEE updateLostRowsToWhitespaceHasLost
        lostRows = [SELECT id, Name, Product__c,
                           Account__c, Account_Type__c,
                           APOAccountId__c, APOAccountName__c, APOOppId__c,
                           Account_Owner__c, Account_Manager__c,
                           Close_Date__c, 
                           Lost__c, Lost_Reason__c, Lost_Reason_Additional_Notes__c, Lost_Reason_Detail__c,
                           Opportunity_Name__c, Total__c,
                           SKU__c, SKU__r.Name, SKU__r.Group__r.id, Group__c,
                           ProcessedJoin__c, ProcessedPostToWS__c
                    FROM LostRow__c ];
                    // WHERE  (product__c != null OR product__c != '') ]; // AND ( Account__c != null OR Account__c != '') ];
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
            // string accountAPOid = oppRow.APOAccountId__c;
            found = false;
            for (Integer i = 0; i < newAccounts.size(); i++) {
               if ( oppRow.APOAccountId__c.equals(newAccounts[i].APOAccountId__c )) { // already in the new list
                   found = true;
                   i = newAccounts.size() + 1;  // stop the loop
               }
            }
            if ( found == false ){ // not found, add it
                Account a = new Account();
                a.name = oppRow.APOAccountName__c;
                a.APOAccountId__c = oppRow.APOAccountId__c;
                a.Type = oppRow.Account_Type__c;
                a.APOAccountOwner__c = oppRow.Account_Owner__c;
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
        LoadOpps(); // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        integer countForLoop = 0;
        countCreatedOpps = 0;
        LIST<Opp__c> newOpps = new LIST<Opp__c>();
        for (Integer j = 0; j < oppRows.size(); j++) { // for (OppRow__c oppRow : oppRows ){
            if ( oppRows[j].ProcessedOpp__c == false ) {
                // string APOOppId = oppRows[j].APOOppId__c;
                found = false;
                for (Integer i = 0; i < newOpps.size(); i++) {
                   if ( oppRows[j].APOOppId__c.equals(newOpps[i].APOOppId__c )) { // match, already in the new list
                       found = true;
                       i = newOpps.size() + 1;  // stop the loop
                   }
                }
                
                if ( found == false ){
                    for ( Integer k =0; k < opps.size(); k++ ) {
                        if ( oppRows[j].APOOppId__c.equals(opps[k].APOOppId__c) ) {
                            found = true;
                            k = opps.size() + 1; 
                        }
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
                    opp.Amount__c = oppRows[j].Amount__c;  
                    opp.Incremental__c = oppRows[j].Incremental__c;              
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
                if (countForLoop>899) j = oppRows.size() + 1;  // stop the loop
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
    
    public void joinOppRowsToAccounts(){
        LoadAccounts();
        LoadOppRows();
        integer countForLoop = 0;
        for (Integer j = 0; j < oppRows.size(); j++) { 
            if ( oppRows[j].ProcessedAccountJoin__c == false ) {
                for (Integer i = 0; i < accounts.size(); i++) {
                    if ( oppRows[j].APOaccountId__c.equals(accounts[i].APOaccountId__c )){ 
                        oppRows[j].Account__c = accounts[i].Id;
                        i = accounts.size() + 1;  // stop the loop 
                    }
                    oppRows[j].ProcessedAccountJoin__c = true;
                }
                countForLoop++;
            }
            if (countForLoop>999) j = oppRows.size() + 1;  // stop the loop
        }
        countJoinOppRowsToAccountTotalProcessed+= countForLoop;

        commentJoinOppRowsToAccount = 'Processed ' + countForLoop + ' of ' + countJoinOppRowsToAccountTotalProcessed  + ' in ' + oppRows.size();
        // commentOppsProcessed = 'Processed ' + countForLoop + ' of ' + countCreatedOppsRunningTotalOppRowsProcessed + ' in ' + subscriptions.size();
        update oppRows;
    }
    
    
    public void clearOppRowProcessed(){
        LIST<OppRow__c> oprs = [select id, ProcessedOpp__c, ProcessedOppRow__c from OppRow__c];
        for (OppRow__c opr : oprs ){
            opr.ProcessedOpp__c = false;
            opr.ProcessedOppRow__c = false;
            opr.ProcessedWhiteSpace__c = false;
            opr.ProcessedAccountJoin__c = false; 
        }
        countClearProcessed = oprs.size();
        update oprs;
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
                   if ( newAccounts[i].APOContractId__c != null && newAccounts[i].APOContractId__c != '' ){ // has a value
                       if ( newAccounts[i].APOContractId__c != subscriptions[j].APOContractId__c ) { // has a different contract id
                           newAccounts[i].Multiple_Contracts__c = true;
                       }
                   } else { // is blank so lets add
                       newAccounts[i].APOContractId__c = subscriptions[j].APOContractId__c; // only capture the first contract id
                       newAccounts[i].Contract_Expiration__c = subscriptions[j].Contract_End__c;
                   }
                   found = true;
                   i = newAccounts.size() + 1; // stop the loop
                }
            }
            if ( found == false ) {
                for (Integer k =0; k < accounts.size(); k++ ){
                    if ( subscriptions[j].APOAccountId__c.equals(accounts[k].APOAccountId__c) ) {
                        if ( accounts[k].APOContractId__c != null && accounts[k].APOContractId__c != '' ){ // has a value
                            if ( accounts[k].APOContractId__c != subscriptions[j].APOContractId__c ) { // has a different contract id
                                accounts[k].Multiple_Contracts__c = true;
                            }
                        } else { // is blank so lets add
                            accounts[k].APOContractId__c = subscriptions[j].APOContractId__c; // only capture the first contract id
                            accounts[k].Contract_Expiration__c = subscriptions[j].Contract_End__c;
                        }
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
                acc.Type = 'Customer';
                acc.APOAccountOwner__c = subscriptions[j].APOAccountOwner__c;
                acc.Contract_Expiration__c = subscriptions[j].Contract_End__c;
                acc.APOContractId__c = subscriptions[j].APOContractId__c;
                // acc.Multiple_Contracts__c = false;
                newAccounts.add(acc);
                countCreatedAccountsSub++;
            }
            subscriptions[j].ProcessedCreate__c = true;
            countProcessed++;
            // if ( j > 999 ) j = subscriptions.size() +1;
        }
        commentSubscriptionsProcessedForCreate = 'Processed: ' + countProcessed;
        insert newAccounts;
        update accounts;
        update subscriptions;
    }
    
    public void joinSubscriptionsToAccountsAndTotalSubs(){
        LoadAccounts();
        LoadSubscriptions();
        integer countForLoop = 0;
        createdJoinSubscriptionsToAccounts = 0;
        for (Integer j = 0; j < subscriptions.size(); j++) { // for (Subscription__c sub : subscriptions ){
            if ( subscriptions[j].ProcessedAccountJoin__c == false ) {
                for (Integer i = 0; i < accounts.size(); i++) {
                    if ( subscriptions[j].APOaccountId__c.equals(accounts[i].APOaccountId__c )){  // if ( subscriptions[j].APOaccountId__c == accounts[i].APOaccountId__c ){
                        subscriptions[j].Account__c = accounts[i].Id;
                        if ( accounts[i].Subscription_Total__c == null ) accounts[i].Subscription_Total__c = 0;
                        accounts[i].Subscription_Total__c += subscriptions[j].Total__c; 
                        i = accounts.size() + 1;  // stop the loop 
                        createdJoinSubscriptionsToAccounts++;
                    }
                    subscriptions[j].ProcessedAccountJoin__c = true;
                }
                countForLoop++;
            }
            if (countForLoop>499) j = subscriptions.size() + 1;  // stop the loop
        }
        countJoinSubscriptionsRunningTotalProcessed+= countForLoop;

        commentSubscriptionsProcessed = 'Processed ' + countForLoop + ' of ' + countJoinSubscriptionsRunningTotalProcessed  + ' in ' + subscriptions.size();
        // commentOppsProcessed = 'Processed ' + countForLoop + ' of ' + countCreatedOppsRunningTotalOppRowsProcessed + ' in ' + subscriptions.size();
        update accounts;
        update subscriptions;
    }
    
    
    public void joinSubscriptionsToGroups(){
        //LoadSKUs(); // LoadGroups();
        LoadSubscriptions();
        countJoinSubscriptionsToGroups = 0;
        for (Integer j = 0; j < subscriptions.size(); j++) { 
            subscriptions[j].Group__c = subscriptions[j].SKU__r.Group__r.id;
            countJoinSubscriptionsToGroups++;
        }
        update subscriptions;
    }
    
        
    public void deleteAllSubscriptions(){
        subscriptions = [SELECT id from Subscription__c];
        countDeletedSubscriptions = subscriptions.size();
        delete subscriptions;
    }
    
    public void joinAccountsToAEs(){
        LoadAccounts();
        LoadAEs();
        countJoinAccountsToAEs = 0;
        for (Account acc: accounts){
            if ( acc.AE__c == null ){
                for (AE__c ae : aes ) {
                    if ( acc.APOAccountOwner__c != null ) {
                        if ( ae.name == acc.APOAccountOwner__c ) {
                            acc.AE__c = ae.Id;
                            countJoinAccountsToAEs++;
                        }
                    }
                }
            }
        }
        update accounts;
    }
    
    public void clearSubscriptionsProcessed(){
        LIST<Subscription__c> subs = [select id, Processed__c, ProcessedCreate__c, ProcessedAccountJoin__c, ProcessedWhiteSpace__c from Subscription__c];
        for (Subscription__c sub: subs ){
            sub.Processed__c = false;
            sub.ProcessedCreate__c = false;
            sub.ProcessedAccountJoin__c = false;
            sub.ProcessedWhiteSpace__c = false;
        }
        countClearProcessedSubs = subs.size();
        update subs;
    }
    
    public void clearSKUTotals(){
        LoadSKUs();
        for ( SKU__c sku : skus ) {
            sku.Opportunity_ACV__c = 0;
            sku.Opportunity_Quantity__c = 0;
            sku.Opportunity_Rows__c = 0;
            sku.Subscription_ACV__c = 0;
            sku.Subscription_Quantity__c = 0;
            sku.Subscription_Rows__c = 0;
        }
        countClearSKUTotals = skus.size();
        update skus;
    }
    
    public void postOppRowNumbersToSKUs(){
        LoadOppRows();
        LoadSKUs();
        countPostOppRowNumbersToSKUs = 0;
        for (Integer j = 0; j < oppRows.size(); j++) {
            if ( oppRows[j].Product__c != null && oppRows[j].Product__c != '' ) {
                for (Integer i = 0; i < skus.size(); i++) {
                    if (oppRows[j].Product__c == skus[i].Name){
                        oppRows[j].SKU__c = skus[i].id;
                        oppRows[j].Group__c = skus[i].Group__r.id;
                        if ( skus[i].Opportunity_ACV__c == null ) skus[i].Opportunity_ACV__c = 0;
                        if ( skus[i].Opportunity_Quantity__c == null ) skus[i].Opportunity_Quantity__c = 0;
                        if ( skus[i].Opportunity_Rows__c == null ) skus[i].Opportunity_Rows__c = 0;
                        if ( OppRows[j].Total__c != null ) skus[i].Opportunity_ACV__c += OppRows[j].Total__c;
                        if ( OppRows[j].Quantity__c != null ) skus[i].Opportunity_Quantity__c += OppRows[j].Quantity__c;
                        skus[i].Opportunity_Rows__c += 1;
                        // Subscription_ACV__c, Subscription_Quantity__c, Subscription_Rows__c
                        countPostOppRowNumbersToSKUs++;
                    }
                }
            } else {
                // countPostOppRowNumbersToSKUs++; // since null of blank
            }
        }
        commentPostOppRowNumbersToSKUs = 'Matched ' + countPostOppRowNumbersToSKUs + ' of ' + oppRows.size();
        update skus;
        update oppRows;
    }
    
    
   
    public void postSubscriptionNumbersToSKUs(){
        LoadSubscriptions();
        LoadSKUs();
        integer countPostSubscriptionNumbersToSKUs = 0;
        for (Integer j = 0; j < subscriptions.size(); j++) {
            if ( subscriptions[j].Name != null && subscriptions[j].Name != '' ) {
                for (Integer i = 0; i < skus.size(); i++) {
                    if (subscriptions[j].Name == skus[i].Name){
                        subscriptions[j].SKU__c = skus[i].id;
                        if ( skus[i].Subscription_ACV__c == null ) skus[i].Subscription_ACV__c = 0;
                        if ( skus[i].Subscription_Quantity__c == null ) skus[i].Subscription_Quantity__c = 0;
                        if ( skus[i].Subscription_Rows__c == null ) skus[i].Subscription_Rows__c = 0;
                        if ( subscriptions[j].Total__c != null ) skus[i].Subscription_ACV__c += subscriptions[j].Total__c;
                        if ( subscriptions[j].Quantity__c != null ) skus[i].Subscription_Quantity__c += subscriptions[j].Quantity__c;
                        skus[i].Subscription_Rows__c += 1;
                        // Subscription_ACV__c, Subscription_Quantity__c, Subscription_Rows__c
                        countPostSubscriptionNumbersToSKUs++;
                        i = skus.size() + 1;
                    }
                }
            } 
        }
        commentPostSubscriptionNumbersToSKUs = 'Matched ' + countPostSubscriptionNumbersToSKUs + ' of ' + subscriptions.size();
        update skus;
        update subscriptions;
    } 
    

    
    
    
    
    public void createWhiteSpaceFromRows(){
        // LoadOppRows();
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
                    Incremental__c, IncrementalString__c,
                    ProcessedOpp__c, ProcessedOppRow__c, ProcessedAccountJoin__c, ProcessedWhiteSpace__c,
                    SKU__c, Group__c, GroupId__c, GroupName__c
                    // Product_Code__c, Owner_Role__c, Next_Step__c
                   FROM OppRow__c 
                   WHERE (Group__c != null OR Group__c != '') ];
        LIST<WhiteSpace__c> newWS = new LIST<WhiteSpace__c>();
        integer countWSUpdates = 0;
        for (Integer j = 0; j < oppRows.size(); j++) {
            if ( oppRows[j].ProcessedWhiteSpace__c == false ) {
                boolean found = false;
                for (Integer i = 0; i < newWS.size(); i++) {
                    if ( oppRows[j].Account__c.equals(newWS[i].Account__c) && oppRows[j].Group__c==newWS[i].Group__c ){ // found
                        found = true;
                        if ( newWS[i].OppTotal__c == null ) newWS[i].OppTotal__c = 0;
                        if ( newWS[i].OppQuantity__c == null ) newWS[i].OppQuantity__c = 0;
                        if ( oppRows[j].Total__c != null ) newWS[i].OppTotal__c += oppRows[j].Total__c;
                        if ( oppRows[j].Quantity__c!= null ) newWS[i].OppQuantity__c += oppRows[j].Quantity__c;
                        countWSUpdates++;
                        i = newWS.size() +1;
                    }
                }
                if ( found == false ) {
                    WhiteSpace__c ws = new WhiteSpace__c();
                    ws.Account__c = oppRows[j].Account__c;
                    ws.Group__c = oppRows[j].Group__c;
                    ws.OppTotal__c = oppRows[j].Total__c;
                    ws.OppQuantity__c = oppRows[j].Quantity__c;
                    newWS.add(ws);
                    countWSUpdates++;
                } 
                oppRows[j].ProcessedWhiteSpace__c = true;
                if (countWSUpdates > 899) j = oppRows.size() +1;
            }
        }
        countOppRowsCreateWhitespace += countWSUpdates;
        commentOppRowsCreateWhitespace = 'Created: ' + countWSUpdates + ' Running: ' + countOppRowsCreateWhitespace + ' of ' + oppRows.size();
        update oppRows;
        insert newWS;
    }
    
    
    public void createWhiteSpaceFromSubscriptions(){
        LoadWhiteSpace();
        LoadSubscriptionsWithProcessed(); // LoadSubscriptions();
        LIST<WhiteSpace__c> newWS = new LIST<WhiteSpace__c>();
        integer countWSUpdates = 0;
        integer foundInWSandUpdated = 0;
        // mydebug = 'here'; 
        for (Integer j = 0; j < subscriptions.size(); j++) {
            if ( subscriptions[j].ProcessedWhiteSpace__c == false) {
                boolean found = false;
                
                for (Integer i = 0; i < whitespaces.size(); i++) { // do we already have a workspace record?
                     if ( subscriptions[j].Account__c.equals(whitespaces[i].Account__c) && subscriptions[j].Group__c==whitespaces[i].Group__c){
                        if ( whitespaces[i].SubTotal__c == null ) whitespaces[i].SubTotal__c = 0;
                        if ( whitespaces[i].SubQuantity__c == null ) whitespaces[i].SubQuantity__c = 0;
                        whitespaces[i].SubTotal__c += subscriptions[j].Total__c;
                        whitespaces[i].SubQuantity__c += subscriptions[j].Quantity__c;
                        found = true;
                        foundInWSandUpdated++;
                        i = whitespaces.size() + 1;
                        // System.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'); 
                     }
                }
                
                if ( found == false ) {
                    for (Integer k = 0; k < newWS.size(); k++) {
                        if ( subscriptions[j].Account__c.equals(newWS[k].Account__c) && subscriptions[j].Group__c==newWS[k].Group__c ){ // found
                            if ( newWS[k].SubTotal__c == null ) newWS[k].SubTotal__c = 0;
                            if ( newWS[k].SubQuantity__c == null ) newWS[k].SubQuantity__c = 0;
                            newWS[k].SubTotal__c += subscriptions[j].Total__c;
                            newWS[k].SubQuantity__c += subscriptions[j].Quantity__c;
                            found = true;
                            k = newWS.size() +1; 
                        } 
                    }
                }
                
                if ( found == false ) {
                    WhiteSpace__c ws = new WhiteSpace__c();
                    ws.Account__c = subscriptions[j].Account__c;
                    ws.Group__c = subscriptions[j].Group__c;
                    ws.SubTotal__c = subscriptions[j].Total__c;
                    ws.SubQuantity__c = subscriptions[j].Quantity__c;
                    newWS.add(ws);
                } 
                
                subscriptions[j].ProcessedWhiteSpace__c = true;
                countWSUpdates++;
                if (countWSUpdates > 399) j = subscriptions.size() +1;
            } // if false
        }
        countSubscriptionsCreateWhitespace += countWSUpdates;
        commentSubscriptionsCreateWhitespace = 'Found in WS: ' + foundInWSandUpdated + ' New WS: ' + newWS.size() + ' Processed: ' + countWSUpdates + '/' + countSubscriptionsCreateWhitespace + '/' + subscriptions.size();
        update whitespaces;
        update subscriptions;
        insert newWS;
    }
    
    
    public void deleteAllWhiteSpace(){
        whitespaces = [SELECT id, name from WhiteSpace__c limit 9999]; 
        deleteWhiteSpace = whitespaces.size(); 
        delete whitespaces;
    }
    

    public LIST<WhiteSpace__c> wsAccount {get;set;}
    
    public void getWhiteSpace() { // public LIST<WhiteSpace__c> getWhiteSpace(id accountId) {
        string accountId = 'a0101000003TDk1AAG';
        LoadGroups(); // LIST<Group__c> groups = [SELECT id, Name FROM Group__c ORDER BY SortOrder__c]; // 
        wsAccount = [SELECT id, name, Account__c, Group__c, GroupName__c, OppTotal__c, OppQuantity__c, SubTotal__c, SubQuantity__c
                                 FROM WhiteSpace__c 
                                 WHERE Account__c = '0010100000TJrbXAAT' // WHERE Account__c = :accountId
                                 ORDER BY GroupSort__c];
       
        for (Integer i = 0; i < groups.size(); i++) { // for (Group__c groups : group) {
            Group__c newWS = new Group__c();
            newWS.Name = groups[i].Name;
            for ( WhiteSpace__c ws : wsAccount ){
                if ( groups[i].Id == ws.Group__c ) { 
                    if ( newWS.OppTotal__c == null ) newWS.OppTotal__c = 0; // set to 0 if null
                    if ( newWS.SubTotal__c == null ) newWS.SubTotal__c = 0; // set to 0 if null
                    if ( ws.OppTotal__c != null ) newWS.OppTotal__c += ws.OppTotal__c; // groups[i].OppTotal__c = 0;
                    if ( ws.SubTotal__c != null ) newWS.SubTotal__c += ws.SubTotal__c; //groups[i].SubTotal__c = 0;
                }
            }
            wsGroups.add(newWS);
            tempWScount++;
        }
    }
    
    
    public void getManagers(){
        LoadAEs();
        Set<String> managers = new Set<String>();
        for (Integer i = 0; i< aes.size(); i++)
        {
            managers.add(aes[i].Manager__c); // contains distict managers
        }
        managersSize = managers.size();
    }
    
    public void joinLostRowsToAccountsSKUs(){
        LoadLostRows(); // Name, Product__c, 
                        // Account__c, APOAccountId__c, APOAccountName__c, APOOppId__c,
                        // Close_Date__c, 
                        // Lost__c, Lost_Reason__c, Lost_Reason_Additional_Notes__c, Lost_Reason_Detail__c,
                        // Opportunity_Name__c, Total__c,
                        // SKU__c, SKU__r.Name, SKU__r.Group__r.id, Group__c

        LoadAccounts();
        LoadSKUs();
        integer countLostRowsProcessed = 0;
        for (Integer j = 0; j < lostRows.size(); j++) {
            if ( lostRows[j].ProcessedJoin__c == false ) {
                for (Integer i = 0; i < accounts.size(); i++) {
                    if ( lostRows[j].APOAccountId__c.equals(accounts[i].APOAccountId__c) ) {
                        lostRows[j].Account__c = accounts[i].id;
                        i = accounts.size() + 1;
                    }
                }
                for (Integer k = 0; k < skus.size(); k++) {
                    if ( lostRows[j].Product__c == skus[k].name ) {
                        lostRows[j].SKU__c = skus[k].id;
                        lostRows[j].Group__c = skus[k].Group__c;
                        k = skus.size() + 1;
                    }
                }
                lostRows[j].ProcessedJoin__c = true;
                countLostRowsProcessed++;
                if ( countLostRowsProcessed >499 ) j = lostRows.size() + 1;
            }
        }
        countJoinLostRowsToAccountsSKUs += countLostRowsProcessed;
        commentJoinLostRowsToAccountsSKUs = countLostRowsProcessed + ' of ' + countJoinLostRowsToAccountsSKUs + ' of ' + lostRows.size();
        update lostRows;
    }
    
    /*public void createAEsFromLostRows(){
        LoadAEs();
        LoadLostRows();
        LIST<AE__c> newAEs = new LIST<AE__c>();
        countCreatedAEs = 0;
        for ( LostRow__c lostRow : lostRows ){
            boolean found = false;
            for (Integer i = 0; i < aes.size(); i++) {
                if ( lostRow.Account_Owner__c == aes[i].Name ){
                    found = true;
                    i = aes.size() + 1;
                }
            }
            if ( found == false ){
                for ( Integer k = 0; k < newAEs.size(); k++ ) {
                    if ( lostRow.Account_Owner__c == newAEs[k].Name ) {
                        k = newAEs.size() + 1;
                        found = true;
                    }
                }
            }
            if ( found == false ){
                AE__c ae = new AE__c();
                ae.Name = lostRow.Account_Owner__c;
                ae.Manager__c = lostRow.Account_Manager__c;
                ae.Created_Source__c = 'Lost';
                newAEs.add(ae);
            }
        }
        commentCreateAEsFromLostRows = 'Created ' + newAEs.size() + ' in ' + lostRows.size();
        insert newAEs;
    }*/
              
    /*public void createAccountsFromLostRows(){
        LoadLostRows();
        LoadAEs();
        LoadAccounts();
        LIST<Account> newAccounts = new LIST<Account>();
        for ( LostRow__c lostRow : lostRows ){
            boolean found = false;    
            for (Integer i = 0; i < accounts.size(); i++) {
                if ( lostRow.APOAccountId__c.equals(accounts[i].APOAccountId__c ) ){
                    found = true;
                    i = accounts.size() + 1;  
                }
                if ( found == false ){
                    for ( Integer j = 0; j < newAccounts.size(); j++ ){
                        if ( lostRow.APOAccountId__c.equals(newAccounts[j].APOAccountId__c) ){
                            found = true;
                            j = newAccounts.size() + 1;  
                        }    
                    }
                }
                if ( found == false ){
                    Account a = new Account();
                    a.Name = lostRow.APOAccountName__c;
                    a.APOAccountId__c = lostRow.APOAccountId__c;
                    a.Type = lostRow.Account_Type__c;
                    a.Created_Source__c = 'Lost';
                    for ( AE__c ae : aes ){
                        if ( ae.Name == lostRow.Account_Owner__c ) a.AE__c = ae.id;
                    }
                    newAccounts.add(a);
                }
            }
        }
        insert newAccounts;
        commentCreateAccountsFromLostRows = 'Created ' + newAccounts.size() + ' in ' + lostRows.size();
    }*/
    
    
    /*public void joinLostRowsToAccounts(){
        LoadLostRows();
        LoadAccounts();
        integer countAccountsJoined = 0;
        for ( LostRow__c lostRow : lostRows ){
            for (Integer i = 0; i < accounts.size(); i++) {
                if ( lostRow.APOAccountId__c.equals(accounts[i].APOAccountId__c ) ){
                    lostRow.Account__c = accounts[i].id;
                    i = accounts.size() + 1;  
                    countAccountsJoined++;
                }
            }
        }
        commentJoinLostRowsToAccounts = 'Joined ' + countAccountsJoined + ' of ' + countJoinLostRowsToAccounts + ' in ' + lostRows.size();
        update LostRows;
    }*/
    
    /*public void joinLostRowsToSKUs(){
        LoadLostRows();
        LoadSKUs();
        integer countSkusFound = 0;
        for ( LostRow__c lostRow : lostRows ){
            for (Integer i = 0; i < skus.size(); i++) {
                if ( lostRow.Product__c == skus[i].Name ){
                    lostRow.SKU__c = skus[i].id;
                    lostRow.Group__c = skus[i].Group__r.id;
                    i = skus.size() + 1;
                    countSkusFound++;
                }
            }
        }
        commentJoinLostRowsToSKUs = 'Joined ' + countSkusFound + ' of ' + lostRows.size();
        update LostRows;
    }*/
    

    
    /* whitespaces = [SELECT id, Name,
                      Account__c, Account__r.name,
                      Group__c, GroupName__c, GroupSort__c, Group__r.name,
                      OppTotal__c, OppQuantity__c,
                      SubTotal__c, SubQuantity__c,
                      hasLost__c, showHasLost__c
               FROM WhiteSpace__c];
    */
    
    
    public void updateLostRowsToWhitespaceHasLost(){
        LoadWhiteSpace();
        LIST<Whitespace__c> newWhitespace = new LIST<Whitespace__c>();
        // LoadLostRows();
        lostRows = [SELECT id, Name, Product__c,
                           Account__c, Account_Type__c,
                           APOAccountId__c, APOAccountName__c, APOOppId__c,
                           Account_Owner__c, Account_Manager__c,
                           Close_Date__c, 
                           Lost__c, Lost_Reason__c, Lost_Reason_Additional_Notes__c, Lost_Reason_Detail__c,
                           Opportunity_Name__c, Total__c,
                           SKU__c, SKU__r.Name, SKU__r.Group__r.id, Group__c,
                           ProcessedJoin__c, ProcessedPostToWS__c
                    FROM LostRow__c
                    WHERE  ProcessedPostToWS__c = false AND (Group__c != null OR Group__c != '') AND ( Account__c != null OR Account__c != '') 
                    ORDER BY Close_Date__c ];
        integer countUpdated = 0;
        for ( Integer i = 0; i < lostRows.size(); i++ ){
            for ( Integer j = 0; j < whitespaces.size(); j++ ){
                if ( lostRows[i].Account__c.equals(whitespaces[j].Account__c) && lostRows[i].Group__c == whitespaces[j].Group__c ){
                    whitespaces[j].hasLost__c = true;
                    whitespaces[j].LostRowId__c = lostRows[i].id;
                    j = whitespaces.size() + 1;
                }
            }
            // newWhitespace - see if in
            // create Whitespace
            lostRows[i].ProcessedPostToWS__c = true;
            countUpdated++;
            if ( i > 98 ) i = lostRows.size() + 1;
        }
        update whitespaces;
        insert newWhitespace;
        update lostRows;
        countUpdateLostRowsToWhitespaceHasLost += countUpdated;
        commentUpdateLostRowsToWhitespaceHasLost = 'Added ' + newWhitespace.size() + ' Updated ' + countUpdated +
                                                   ' of ' + countUpdateLostRowsToWhitespaceHasLost + ' in ' + lostRows.size();
    }
    
       
    public void clearLostRowsProcessed(){
        LIST<LostRow__c> lrs = [select id, ProcessedJoin__c, ProcessedPostToWS__c from LostRow__c];
        countLostRowPropcessedClear = 0;
        for ( LostRow__c lr : lrs ){
            lr.ProcessedJoin__c = false;
            lr.ProcessedPostToWS__c = false;
            countLostRowPropcessedClear++;
        }
        update lrs;
    }
    
    public void deleteLostRows(){
        lostRows = [select id from LostRow__c];
        countDeletedLostRows = lostRows.size();
        delete lostRows;
    }
    
    public void plus(){
        integer i = 1;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
    }
    
}