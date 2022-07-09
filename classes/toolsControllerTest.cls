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
        insert opprow;
        
        Subscription__c sub = new Subscription__c();
        sub.Name = 'Name'; 
        sub.APOAccountId__c = '0015p00005YKzcl';
        sub.APOAccountName__c  = 'AccountName';
        sub.APOSubscriptionId__c = 'aDV5p000000wlM4';
        sub.APOContractId__c = '8005p00000FOxAM';
        sub.APOAccountOwner__c = 'Account_Owner';
        sub.APOAccountOwnerManager__c = 'Account_Manager';
        insert sub;

        AE__c ae = new AE__c();
        ae.Name = 'Account_Owner';
        insert ae;

        toolsController TC = new toolsController();
        // TC.toolsController();
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

        TC.createAEsFromSubscriptions();
        TC.createAccountsFromSubscriptions();
        TC.joinSubscriptionsToAccounts();
        TC.deleteAllSubscriptions();
        TC.joinAccountsToAEs();
        TC.clearSubscriptionsProcessed();
        

    }
}