@isTest

private class stuffControllerTest {
    
    static testMethod void runTests() {

        stuffController.getStuff();
        stuffController.getStaples();
        stuffController.addStuffFromStaple('test');
        stuffController.getCheckList();
        stuffController.getCheckListMV();

        Stuff__c s = new Stuff__c();
        s.name = 'test';
        insert s;
        stuffController.markDone(s.id);
    }
}