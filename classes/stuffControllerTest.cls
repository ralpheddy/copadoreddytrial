@isTest

private class stuffControllerTest {
    
    static testMethod void runTests() {

        stuffController.getStuff();
        Stuff__c s = new Stuff__c();
        s.name = 'test';
        insert s;
        stuffController.markDone(s.id);
    }
}