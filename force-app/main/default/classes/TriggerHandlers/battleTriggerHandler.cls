public class battleTriggerHandler {
    
    public static void beforeInsert(List<Battle__c> newBattle, Map<Id, Battle__c> newBattleMap){

    }

    public static void beforeUpdate(List<Battle__c> newBattle, List<Battle__c> oldBattle, Map<Id, Battle__c> newBattleMap, Map<Id, Battle__c> oldBattleMap){
        
        //SOQL Query to get a map of all Pokemon that are either pokemon 1 or pokemon 2
        // Map<Id, Pokemon__c> relatedPkmn = new Map<Id, Pokemon__c>([
        //     SELECT Id, Name 
        //     FROM Pokemon__c 
        //     WHERE (Id IN :newBattle.Pokemon_1__c OR Id IN :newBattle.Pokemon_2__c)
        //     ]);
        

        for(Battle__c newBattleRec : newBattle){
            Battle__c oldBattleRec = oldBattleMap.get(newBattleRec.Id); 
            if(newBattleRec.Status__c != oldBattleRec.Status__c){
                //mark victor
                if(newBattleRec.Pokemon_1__r.Current_HP__c > newBattleRec.Pokemon_2__r.Current_HP__c){
                    newBattleRec.Victor__c = newBattleRec.Pokemon_1__c;
                } else {
                    newBattleRec.Victor__c = newBattleRec.Pokemon_2__c;
                }
            }
        }

    }

    public static void afterInsert(List<Battle__c> newBattle, Map<Id, Battle__c> newBattleMap){

    }

    public static void afterUpdate(List<Battle__c> newBattle, List<Battle__c> oldBattle, Map<Id, Battle__c> newBattleMap, Map<Id, Battle__c> oldBattleMap){

    }
}