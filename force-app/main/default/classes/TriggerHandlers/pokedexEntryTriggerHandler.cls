public with sharing class pokedexEntryTriggerHandler {
    
    public static void beforeInsert(List<Pokedex_Entry__c> newPokedexEntry, Map<Id, Pokedex_Entry__c> newPokedexEntryMap){
        System.debug('Handler - Before Insert Triggered');
    }
    
    public static void beforeUpdate(List<Pokedex_Entry__c> newPokedexEntry, List<Pokedex_Entry__c> oldPokedexEntry, Map<Id, Pokedex_Entry__c> newPokedexEntryMap, Map<Id, Pokedex_Entry__c> oldPokedexEntryMap){
        System.debug('Handler - Before Update Triggered');
    }

    //After
    public static void afterInsert(List<Pokedex_Entry__c> newPokedexEntry, List<Pokedex_Entry__c> oldPokedexEntry, Map<Id, Pokedex_Entry__c> newPokedexEntryMap, Map<Id, Pokedex_Entry__c> oldPokedexEntryMap){
        System.debug('Handler - After Insert Triggered');
    }

    public static void afterUpdate(List<Pokedex_Entry__c> newPokedexEntry, List<Pokedex_Entry__c> oldPokedexEntry, Map<Id, Pokedex_Entry__c> newPokedexEntryMap, Map<Id, Pokedex_Entry__c> oldPokedexEntryMap){
        System.debug('Handler - After Update Triggered');

        for(Pokedex_Entry__c pkdxEntry : newPokedexEntry){
            Pokedex_Entry__c oldPkdxEntry = oldPokedexEntryMap.get(pkdxEntry.Id);
            if(pkdxEntry.Trigger_API_Enrichment__c != oldPkdxEntry.Trigger_API_Enrichment__c){
                System.debug('API Call Triggered');
                pokeAPICallout.makeCallout(pkdxEntry.Name);

            }
        }
    }

}