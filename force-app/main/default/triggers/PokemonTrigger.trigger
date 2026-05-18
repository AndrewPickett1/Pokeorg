trigger PokemonTrigger on Pokemon__c (before insert, before update, after insert, after update) {
    
    //before save logic
    if(trigger.isBefore){
        
        if(trigger.isInsert){
            //before insert
            PokemonTriggerHandler.beforeInsert(trigger.new, trigger.newMap);
            //System.debug('Before Insert Triggered');
        } else if (trigger.isUpdate){
            //before update
            PokemonTriggerHandler.beforeUpdate(trigger.new, trigger.old, trigger.oldMap, trigger.newMap);
            //System.debug('Before Update Triggered');
        }
    } 
    //after save logic
    else if (trigger.isAfter) {
        
        if(trigger.isInsert){
            // after insert
        } else if(trigger.isUpdate){
            // after update
            PokemonTriggerHandler.afterUpdate(Trigger.new, Trigger.old, Trigger.oldMap, Trigger.newMap);
            //System.debug('After Update Triggered');
        }
    }

}