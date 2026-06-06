trigger battleTrigger on Battle__c (before insert, before update, after insert, after update) {

    new battleTriggerHandler().execute();
}