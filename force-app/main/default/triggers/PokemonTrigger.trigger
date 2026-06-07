trigger PokemonTrigger on Pokemon__c (before insert, before update, after insert, after update) {
    
new PokemonTriggerHandler().execute();
    //before save logic



}