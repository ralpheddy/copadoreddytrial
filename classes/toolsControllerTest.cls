@isTest

private class toolsControllerTest {
   
    static testMethod void runOppRows() {

        OppRow__c opprow = new OppRow__c();
        opprow.APOAccountId__c = '0015p00005YKzcl';
        opprow.APOAccountName__c = 'AccountName';
        opprow.Account_Type__c = 'Type';
        opprow.Opportunity_Name__c = 'Opportunity_Name';
        opprow.APOOppId__c = '0065p000013B60j';
        opprow.Account_Owner__c = 'Account_Owner';
        opprow.Account_Manager__c = 'Account_Manager';
        opprow.Owner_Name__c = 'Owner_Name';
        opprow.ProcessedWhiteSpace__c = false;
        opprow.ProcessedAccountJoin__c = false;
        insert opprow;
        
        AE__c ae = new AE__c();
        ae.Name = 'Account_Owner';
        insert ae;

        Group__c g = new Group__c();
        g.Name = 'name';
        insert g;
        SKU__c sku = new SKU__c();
        sku.Name = 'Sku';
        sku.Group__c = g.id;
        insert sku;

        Account acc = new Account();
        acc.Name = 'name';
        insert acc;

        /*
        Subscription__c sub = new Subscription__c();
        sub.Name = 'Name'; 
        sub.APOAccountId__c = '0015p00005YKzcl';
        sub.APOAccountName__c  = 'AccountName';
        sub.APOSubscriptionId__c = 'aDV5p000000wlM4';
        sub.APOContractId__c = '8005p00000FOxAM';
        sub.APOAccountOwner__c = 'Account_Owner';
        sub.APOAccountOwnerManager__c = 'Account_Manager';
        sub.ProcessedWhiteSpace__c = false;
        insert sub;
        */

        toolsController TC = new toolsController();
        // TC.toolsController();

        TC.countJoinSubscriptionsToGroups = 9;

        TC.postOppRowNumbersToSKUs();

        TC.LoadOppRows();
        TC.LoadAEs();
        TC.LoadAccounts();
        TC.LoadOpps();
        TC.LoadSubscriptions();

        TC.deleteAllAEs();
        TC.CreateAEsFromRows();
        TC.deleteAllAccounts();
        TC.CreateAccountsFromRows();
        TC.deleteAllOpps();
        TC.CreateOppsFromRows();
        TC.deleteAllOppRows();
        TC.joinOppRowsToOpps();
        TC.clearOppRowProcessed();

        TC.joinOppRowsToAccounts();

        TC.createAEsFromSubscriptions();
        TC.createAccountsFromSubscriptions();
        TC.joinSubscriptionsToAccountsAndTotalSubs();
        TC.joinSubscriptionsToGroups();
        TC.deleteAllSubscriptions();
        TC.joinAccountsToAEs();
        TC.clearSubscriptionsProcessed();

        
        TC.postSubscriptionNumbersToSKUs();
        TC.createWhiteSpaceFromRows();
        TC.createWhiteSpaceFromSubscriptions();
        TC.deleteAllWhiteSpace();
        TC.getWhiteSpace();



        TC.joinLostRowsToAccountsSKUs();
        TC.updateLostRowsToWhitespaceHasLost();
        TC.clearWhitespaceLostFields();
        TC.clearLostRowsProcessed();
        TC.deleteLostRows();
        


        TC.LoadSKUs();
        TC.LoadGroups();
        TC.LoadWhiteSpace();
        TC.getManagers();
        TC.plus();

        TC.createMapRVPs();
        TC.createMapAEs();
        TC.createMapSFRVPs();
        TC.createMapSFAEs();
        TC.Load_AE_SFAE_Account();
        TC.joinAESFAEaccountToAE();
        TC.joinAESFAEaccountToSFAE();
        TC.postOppRowsToAESFAEAccounts();
        TC.postSubscriptionsToAESFAEAccounts();
        TC.deleteAll_AESFAEAccounts();
        TC.deleteAll_AE_RVP_SFAE_SFRVPs();
    }
}