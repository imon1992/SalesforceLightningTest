public with sharing class testClass {
    @AuraEnabled
    public static List<Contact> getContacts() {
        List<Contact> contacts =
            [SELECT Id, Name, MailingStreet, Phone, Email, LeadSource FROM Contact];
        //Add isAccessible() check
        return contacts;
    }

        @AuraEnabled
    public static List<test1__c> test(){
        if (Schema.sObjectType.test1__c.isAccessible()){
            return [Select name from test1__c];
        }
        return null;
    }
}