@isTest

public class mapControllerTest {
    
    static testMethod void runTests() {
        mapController m = new mapController();
        m.LoadRVPs();
        m.LoadAEs();
        m.LoadAccounts();
        m.LoadSFAEs();
        m.LoadSFRVPs();
        m.confirmQuerySyntax();

        m.SetAccountFilters();
        m.getAEsFromAccounts();
        m.getSFAEsFromAccounts();
        m.getSFRVPsFromSFAEs();
        
    }
}