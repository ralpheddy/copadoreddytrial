public with sharing class stuffController {
    

    @AuraEnabled(cacheable=false) 
    public static LIST<Stuff__c> getStuff(){
        // System.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXX: getStuff');
        LIST<Stuff__c> stuffs = [SELECT Name, Completed__c, id
                                 FROM Stuff__c 
                                 WHERE Completed__c=false
                                 ORDER BY Completed__c, CreatedDate desc];
        
        return stuffs;
    }

    @AuraEnabled(cacheable=false) 
    public static LIST<Stuff__c> getStaples(){
        // System.debug('XXXXXXXXXXXXXXXXXXXXXXXXXXXX: getStuff');
        LIST<Stuff__c> stuffs = [SELECT Name, id
                                 FROM Stuff__c 
                                 WHERE isStaple__c=true
                                 ORDER BY StapleOrder__c];
        
        return stuffs;
    }

    @AuraEnabled() 
    public static void addStuffFromStaple(string description){
        try{
            Stuff__c st =  new Stuff__c();
            st.name = description;
            insert st;
        } catch (Exception e) {
            System.debug('Add Stuff From Staple error: ' + e.getMessage());
        }
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

    @AuraEnabled(cacheable=false) 
    public static LIST<Check_List__c> getCheckList(){  
        LIST<Check_List__c> cls = [SELECT Name, isMillValley__c, isSerene__c, id
                                 FROM Check_List__c 
                                 WHERE isSerene__c = true
                                 ORDER BY SortOrder__c, Name];
        
        return cls;
    }
    @AuraEnabled(cacheable=false) 
    public static LIST<Check_List__c> getCheckListMV(){  
        LIST<Check_List__c> cls = [SELECT Name, isMillValley__c, isSerene__c, id
                                 FROM Check_List__c 
                                 WHERE isMillValley__c = true
                                 ORDER BY SortOrder__c, Name];
        
        return cls;
    }
}