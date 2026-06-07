public class PokemonTriggerHandler extends TriggerHandler {
    

    public override void handleBeforeInsert(){
        setHPUponCreation();
    }
    
    public override void handleAfterUpdate(){
        updateBattleUponFaint();
    }

    public override void handleBeforeUpdate(){
        faintBehavior();
    }

    public void setHPUponCreation(){
        Set<Id> pkdxEntryIds = new Set<Id>();

        for(Pokemon__c pkmn : (List<Pokemon__c>) this.newList){
            if(pkmn.Pokedex_Entry__c != null){
                pkdxEntryIds.add(pkmn.Pokedex_Entry__c);
            }
        }

        Map<Id, Pokedex_Entry__c> pkdxEntries = new Map<Id, Pokedex_Entry__c>([SELECT Id, HP__c FROM Pokedex_Entry__c WHERE Id IN :pkdxEntryIds]);

        for(Pokemon__c pkmn : (List<Pokemon__c>) this.newList){
            pkmn.Max_HP__c = pkdxEntries.get(pkmn.Pokedex_Entry__c).HP__c;
            pkmn.Current_HP__c = pkdxEntries.get(pkmn.Pokedex_Entry__c).HP__c;
        }
    }

    public void faintBehavior(){
        for(Pokemon__c pkmn : (List<Pokemon__c>) this.newList){
            
            //prevents HP lower than 0
            if(pkmn.Current_HP__c < 0){
                pkmn.Current_HP__c = 0;
            }

            //nulls status if one exists
            if(pkmn.Current_HP__c <= 0 && pkmn.Status__c != null){
                pkmn.Status__c = null;
            }
        }
    }

    public void updateBattleUponFaint(){
        
        Set<Id> faintedPkmn = new Set<Id>();

        //get a list of all pokemon that have fainted
        for(Pokemon__c pkmn : (List<Pokemon__c>) this.newList){
            Pokemon__c oldPkmn = (Pokemon__c) oldMap.get(pkmn.Id);
            
            if(pkmn.Current_HP__c == 0 && oldPkmn.Current_HP__c != 0){
                faintedPkmn.add(pkmn.Id);
            }
        }

        if(!faintedPkmn.isEmpty()){
            List<Battle__c> battles = [
            SELECT Id 
            FROM Battle__c 
            WHERE Pokemon_1__c IN :faintedPkmn 
            OR Pokemon_2__c IN :faintedPkmn
            ]; 

            List<Battle__c> battlesToUpdate = new List<Battle__c>();
            
            for(Battle__c battle : battles){
                battle.Status__c = 'Completed';
                battlesToUpdate.add(battle);
            }

            update battlesToUpdate;
        }
    }

}