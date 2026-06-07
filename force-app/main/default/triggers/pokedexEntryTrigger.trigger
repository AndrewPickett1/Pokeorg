trigger pokedexEntryTrigger on Pokedex_Entry__c (before insert, before update, after insert, after update) {

    new pokedexEntryTriggerHandler().execute();

}