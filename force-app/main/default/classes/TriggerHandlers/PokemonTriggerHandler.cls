public class PokemonTriggerHandler {
    
    //Before
    public static void beforeInsert(List<Pokemon__c> newPokemon, Map<Id, SObject> newAccountMap){
        System.debug('Handler - Before Insert Triggered');
        
        Set<Id> pkdxEntryIds = new Set<Id>();
        
        for(Pokemon__c pkmn : newPokemon){
            if(pkmn.Pokedex_Entry__c != null){
                pkdxEntryIds.add(pkmn.Pokedex_Entry__c);
            }
        }

        Map<Id, Pokedex_Entry__c> pkdxEntries = new Map<Id, Pokedex_Entry__c>([SELECT Id, HP__c FROM Pokedex_Entry__c WHERE Id IN :pkdxEntryIds]);

        for(Pokemon__c pkmn : newPokemon){
            pkmn.Max_HP__c = pkdxEntries.get(pkmn.Pokedex_Entry__c).HP__c;
            pkmn.Current_HP__c = pkdxEntries.get(pkmn.Pokedex_Entry__c).HP__c;
        }
    }
    
    public static void beforeUpdate(List<Pokemon__c> newPokemon, List<Pokemon__c> oldPokemon, Map<Id, Pokemon__c> oldPokemonMap, Map<Id, Pokemon__c> newPokemonMap){
        System.debug('Handler - Before Update Triggered');

        //if current HP is < 0, current HP is 0
        for(Pokemon__c pkmn : newPokemon){
            if(pkmn.Current_HP__c < 0){
                pkmn.Current_HP__c = 0;
            }

            if(pkmn.Current_HP__c <= 0 && pkmn.Status__c != null){
                pkmn.Status__c = null;
            }
        }
    }

    //After
    public static void afterInsert(List<Pokemon__c> newPokemon, List<Pokemon__c> oldPokemon, Map<Id, Pokemon__c> oldPokemonMap, Map<Id, Pokemon__c> newPokemonMap){
        System.debug('Handler - After Insert Triggered');
    }

    public static void afterUpdate(List<Pokemon__c> newPokemon, List<Pokemon__c> oldPokemon, Map<Id, Pokemon__c> oldPokemonMap, Map<Id, Pokemon__c> newPokemonMap){
        System.debug('Handler - After Update Triggered');

        //Close battles when pokemon faints
        for(Pokemon__c pkmn : newPokemon){
            Pokemon__c oldPkmn = oldPokemonMap.get(pkmn.Id);
            if(pkmn.Current_HP__c == 0 && oldPkmn.Current_HP__c != 0){
                
                //SOQL QUERY IN A FOR LOOP REEEEEEEEEE
                List<Battle__c> battles = [
                    SELECT Id 
                    FROM Battle__c 
                    WHERE Pokemon_1__c = :pkmn.Id 
                    OR Pokemon_2__c = :pkmn.Id
                    ];  
                System.debug('Found Battles: ' + battles.size());
                
                List<Battle__c> battlesToUpdate = new List<Battle__c>();
                for(Battle__c battle : battles){
                    battle.Status__c = 'Completed';
                    battlesToUpdate.add(battle);
                }

                update battlesToUpdate;

            }
        }
    }

}