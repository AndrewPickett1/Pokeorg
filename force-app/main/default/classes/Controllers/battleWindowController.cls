public class battleWindowController {
    
    @AuraEnabled
    public static String leftPkmnImgUrl(String BattleId){
        //TODO you're always going to be querying for the sprites at the same time so they should probably be one query
        Battle__c Battle = [
            SELECT Pokemon_1__r.Pokedex_Entry__r.Sprite_Back_URL__c
            FROM Battle__c 
            WHERE Id = :BattleId
            LIMIT 1
            ];
        String imgUrl = string.valueOf(Battle.Pokemon_1__r.Pokedex_Entry__r.Sprite_Back_URL__c);

        System.debug('Left Pkmn Img URL is: ' + imgUrl);
        return imgUrl;
    }

    @AuraEnabled
    public static string rightPkmnImgUrl(String BattleId){
        Battle__c Battle = [
            SELECT Pokemon_2__r.Pokedex_Entry__r.Sprite_Front_URL__c
            FROM Battle__c 
            WHERE Id = :BattleId
            LIMIT 1
            ];
        String imgUrl = string.valueOf(Battle.Pokemon_2__r.Pokedex_Entry__r.Sprite_Front_URL__c);

        System.debug('Right Pkmn Img URL is: ' + imgUrl);
        return imgUrl;
    }

    @AuraEnabled
    public static List<Object> pkmnMoves(String BattleId, Integer Pkmn){

        if(Pkmn == 1){
            Battle__c battle = [SELECT Id, Pokemon_1__c FROM Battle__c WHERE Id = :BattleId LIMIT 1];
            System.debug('Battle Id: ' + battle);
            System.debug('Pkmn 1 Id: ' + battle.Pokemon_1__c);

            List<Object> moveList = [SELECT Move__c FROM Move__c WHERE Pokemon__c = :battle.Pokemon_1__c LIMIT 4];
            system.debug(moveList);
            return moveList;
        } else {
            Battle__c battle = [SELECT Id, Pokemon_2__c FROM Battle__c WHERE Id = :BattleId LIMIT 1];
            System.debug('Battle Id: ' + battle);
            System.debug('Pkmn 2 Id: ' + battle.Pokemon_2__c);

            List<Object> moveList = [SELECT Move__c FROM Move__c WHERE Pokemon__c = :battle.Pokemon_2__c LIMIT 4];
            system.debug(moveList);
            return moveList;  
        }

        
        
    }

}