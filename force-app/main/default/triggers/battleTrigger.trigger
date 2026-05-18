trigger battleTrigger on Battle__c (before insert, before update, after insert, after update) {

    if(trigger.isBefore){

        //before insert
        if(trigger.isInsert){
            
        //before update
        } else if(trigger.isUpdate){
            battleTriggerHandler.beforeUpdate(trigger.new, trigger.old, trigger.newMap, trigger.oldMap);
        }

    }

    else if(trigger.isAfter){

        //after insert
        if(trigger.isInsert){
        
        //after update
        } else if(trigger.isUpdate){
            
        }
    }
}