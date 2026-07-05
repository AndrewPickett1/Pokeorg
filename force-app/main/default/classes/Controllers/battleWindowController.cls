public class battleWindowController {
    
    @AuraEnabled
    public static List<Object> pkmnMoves(String BattleId, Integer Pkmn){

        if(Pkmn == 1){
            Battle__c battle = [SELECT Id, Pokemon_1__c FROM Battle__c WHERE Id = :BattleId LIMIT 1];
            System.debug('Battle Id: ' + battle);
            System.debug('Pkmn 1 Id: ' + battle.Pokemon_1__c);

            List<Object> moveList = [
                SELECT Id, Pokemon__c, Move__c, Type__c, PP__c, Max_PP__c,
                TM__r.Category__c, TM__r.Power__c, TM__r.Type__c,
                TM__r.Name,TM__r.Status_Modifier__c
                FROM Move__c 
                WHERE Pokemon__c = :battle.Pokemon_1__c LIMIT 4
                ];
            system.debug(moveList);
            return moveList;
        } else {
            Battle__c battle = [SELECT Id, Pokemon_2__c FROM Battle__c WHERE Id = :BattleId LIMIT 1];
            System.debug('Battle Id: ' + battle);
            System.debug('Pkmn 2 Id: ' + battle.Pokemon_2__c);

            List<Object> moveList = [
                SELECT Id, Pokemon__c, Move__c, Type__c, PP__c, Max_PP__c,
                TM__r.Category__c, TM__r.Power__c, TM__r.Type__c,
                TM__r.Name,TM__r.Status_Modifier__c
                FROM Move__c 
                WHERE Pokemon__c = :battle.Pokemon_2__c LIMIT 4
                ];
            system.debug(moveList);
            return moveList;  
        }

        
        
    }

}