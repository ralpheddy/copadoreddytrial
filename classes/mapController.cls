public class mapController {
    
    public string warning {get;set;}
    public string Debug {get;set;}
    public string Message {get;set;}
    
    public boolean filterCustomers {get;set;}
    public boolean filterProspects {get;set;}
    public boolean filterOther {get;set;}
    
    public LIST<mapRVP__c> rvps {get;set;}
    public LIST<mapAE__c> aes {get;set;}
    public LIST<AE_SFAE_Account__c> accounts {get;set;}
    public LIST<mapSFAE__c> sfaes {get;set;}
    public LIST<mapSFRVP__c> sfrvps {get;set;}
    
    public mapController(){
        Warning = 'Welcome';
        Debug = '';
        Message = '';
        // filterCustomers = false;
        // filterProspects = false;
        // filterOther  = false;
        LoadRVPs();
        LoadAEs();
        LoadAccounts();
        LoadSFAEs();
        LoadSFRVPs();
    }

    public void loadRVPs(){ 
       string rvpId = Apexpages.currentPage().getParameters().get('rvpId');
       string q = ' SELECT id, Name ' +
                  ' FROM mapRVP__c ';
              if ( rvpId != null && rvpId != '' && rvpId != 'All' ) {
                  q += ' WHERE id =\'' + rvpId + '\' ';
              }
              q += ' ORDER BY Name ';
       rvps = Database.query(q);
    } 
    
    
    public void LoadAEs(){ //(string rvpId){ 
       string rvpId = Apexpages.currentPage().getParameters().get('rvpId');
       string aeId = Apexpages.currentPage().getParameters().get('ae2Id');
       string q = ' SELECT id, Name, mapRVP__c ' +
                  ' FROM mapAE__c ';
                if ( rvpId != null && rvpId != '' && rvpId != 'All' ) {
                    q += ' WHERE mapRVP__c =\'' + rvpId + '\' ';
                }
                if ( aeId != null && aeId != '' && aeId != 'All' ) {
                    q += ' WHERE id =\'' + aeId + '\' ';
                }
                q += ' ORDER BY Name ';
       aes = Database.query(q);
    }  

    public void LoadAccounts(){ // (string aeId, string sfaeId) {  
       string aeId = Apexpages.currentPage().getParameters().get('aeId');
       string filterValue = Apexpages.currentPage().getParameters().get('filterValue');
       string rvpId = Apexpages.currentPage().getParameters().get('rvpId');
       string sfaeId = Apexpages.currentPage().getParameters().get('sfaeId');
       string searchString = Apexpages.currentPage().getParameters().get('searchString');
       string sfrvpId = Apexpages.currentPage().getParameters().get('sfrvpId');
       
       warning = 'Filter: ' + filterValue;

       string q = ' SELECT id, Name, Type__c, mapAE__c, mapSFAE__c, formulaRVP__c, formulaSFRVP__c ' +
                  ' FROM AE_SFAE_Account__c ' +
                  ' WHERE Name != \'xxx\' ';  // this line is always true
                if ( aeId != null && aeId != '' && aeId != 'All' )  { q += ' AND mapAE__c =\'' + aeId + '\' '; }
                if ( filterValue == 'Customer' ) q += ' AND Type__c=\'' + filterValue + '\' ';
                if ( filterValue == 'Prospect' ) q += ' AND Type__c=\'' + filterValue + '\' ';
                if ( filterValue == 'Other' ) q += ' AND Type__c!=\'Customer\' AND Type__c!=\'Prospect\' ';
                
                if ( sfaeId != null && sfaeId != '' && sfaeId != 'All' )  { q += ' AND mapSFAE__c =\'' + sfaeId + '\' '; }
                if ( searchString != null && searchString != ''  )  { q += ' AND Name like \'' + searchString + '%\' '; }
                q += ' ORDER BY Name LIMIT 100 ';
       accounts = Database.query(q);
    } 
    

    public void LoadSFAEs(){ // (string sfrvpId){ 
       string sfrvpId = Apexpages.currentPage().getParameters().get('sfrvpId');
       string sfaeId = Apexpages.currentPage().getParameters().get('sfae2Id');
       string q = ' SELECT id, Name, mapSFRVP__c ' +
                  ' FROM mapSFAE__c ';
                if ( sfrvpId != null && sfrvpId != '' && sfrvpId != 'All' ) {
                    q += ' WHERE mapSFRVP__c =\'' + sfrvpId + '\' ';
                }
                if ( sfaeId != null && sfaeId != '' && sfaeId != 'All' ) {
                    q += ' WHERE id =\'' + sfaeId + '\' ';
                }
                q += ' ORDER BY Name';
       sfaes = Database.query(q);
       // Debug = sfrvpId + ' - ' + sfaes.size();
    }  


    public void LoadSFRVPs(){ 
       string sfrvpId = Apexpages.currentPage().getParameters().get('sfrvp2Id');
       // Message = 'xxxxxxxxx' + sfrvpId;
       string q = ' SELECT id, Name ' +
                  ' FROM mapSFRVP__c ';
              if ( sfrvpId != null && sfrvpId != '' && sfrvpId != 'All' ) {
                  q += ' WHERE id =\'' + sfrvpId + '\' ';
              }
              q += ' ORDER BY Name ';
       sfrvps = Database.query(q);
    } 


    public void SetAccountFilters(){
        warning = 'Filter Search';
        accounts = [SELECT id, Name, Type__c FROM AE_SFAE_Account__c LIMIT 5];
    }

    public void confirmQuerySyntax(){
        string fakeId = '12345';
        LIST<mapRVP__c> mrvps = [SELECT id, Name FROM mapRVP__c WHERE id=:fakeId ORDER BY Name];
        LIST<mapAE__c> maes = [SELECT id, Name, mapRVP__c FROM mapAE__c WHERE mapRVP__c='a0C010000069uxnEAA' ORDER BY Name];
        LIST<AE_SFAE_Account__c> accounts = [SELECT id, Name, Type__c, mapAE__c, mapSFAE__c, formulaRVP__c, formulaSFRVP__c FROM AE_SFAE_Account__c WHERE mapAE__c='a0B01000001rJPvEAM' AND mapSFAE__c='' ORDER BY Name];
        LIST<mapSFAE__c> sfaes = [SELECT id, Name, mapSFRVP__c FROM mapSFAE__c WHERE mapSFRVP__c='a0E01000000hVE1EAM' ORDER BY NAME];
        LIST<mapSFRVP__c> sfrvpss = [SELECT id, Name FROM mapSFRVP__c WHERE id=:fakeId ORDER BY Name]; 
    }



}