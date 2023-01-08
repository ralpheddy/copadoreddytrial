public with sharing class stuffController {
    

    @AuraEnabled(cacheable=false) 
    public static LIST<Stuff__c> getStuff(){
        // System.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXX: getStuff');
        LIST<Stuff__c> stuffs = [SELECT Name, Completed__c, id
                                 FROM Stuff__c 
                                 ORDER BY Completed__c, CreatedDate desc];
        
        return stuffs;
    }

    @AuraEnabled() // @AuraEnabled(cacheable=true) 
    public static void markDone(id recId){
        // System.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXX: markDone');
        try{
            Stuff__c st =  [SELECT Name, Completed__c, id
                            FROM Stuff__c 
                            WHERE id= :recId];
            // if (st <> null ){
                st.Completed__c = true;
                update st;
            // }
        } catch (Exception e) {
            System.debug('MARK DONE error: ' + e.getMessage());
        }
    }
}