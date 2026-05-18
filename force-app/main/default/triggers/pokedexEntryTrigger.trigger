trigger pokedexEntryTrigger on Pokedex_Entry__c (before insert, before update, after insert, after update) {

    //before save logic
    if(trigger.isBefore){
        
        if(trigger.isInsert){
            //before insert
            pokedexEntryTriggerHandler.beforeInsert(trigger.new, trigger.newMap);
            
        } else if (trigger.isUpdate){
            //before update
            
        }
    } 
    //after save logic
    else if (trigger.isAfter) {
        
        if(trigger.isInsert){
            // after insert
        } else if(trigger.isUpdate){
            // after update
            pokedexEntryTriggerHandler.afterUpdate(trigger.new, trigger.old, trigger.newMap, trigger.oldMap);
        }
    }

}