trigger MoveTrigger on Move__c (before insert, before update, after insert, after update) {
    new MoveTriggerHandler().execute();
}