public class pokedexEntryTriggerHandler extends TriggerHandler {
    
    public override void handleAfterUpdate(){
        enrichPokedexEntryInfo();
    }

    public void enrichPokedexEntryInfo(){
        for(Pokedex_Entry__c pkdxEntry : (List<Pokedex_Entry__c>) this.newList){
            Pokedex_Entry__c oldPkdxEntry = (Pokedex_Entry__c) this.oldMap.get(pkdxEntry.Id);
           
            if(pkdxEntry.Trigger_API_Enrichment__c != oldPkdxEntry.Trigger_API_Enrichment__c){
                System.debug('API Call Triggered');
                pokeAPICallout.makeCallout(pkdxEntry.Name);

            }
        }
    }
}