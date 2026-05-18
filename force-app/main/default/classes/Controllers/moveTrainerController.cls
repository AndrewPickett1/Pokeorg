public class moveTrainerController {
    
    @AuraEnabled
    public static void createMoves(List<Id> ids, Id pkmnId){

        List<Move__c> movesToAdd = new List<Move__c>();

        for (Id tmId : ids){
            //Creates move and adds to a collection for subsequent creation
            Move__c move = new Move__c();
            move.Pokemon__c = pkmnId;
            move.TM__c = tmId;
            movesToAdd.add(move);
        }
        insert movesToAdd;


    }
    @AuraEnabled
    public static void deleteMoves(List<Id> ids){
        List<Move__c> currentMoves = [SELECT Id FROM Move__c WHERE Id IN :ids];
        System.debug('Moves to be Deleted: ' + currentMoves);
        delete currentMoves;
    }

    @AuraEnabled
    public static List<Move__c> getMoves(Id pkmnId){
        List<Move__c> currentMoves = [SELECT Id, Name, Move__c, Type__c, TM__r.Power__c FROM Move__c WHERE Pokemon__c = :pkmnId];
        System.debug('Current Pokemon Moves: ' + currentMoves);

        return currentMoves;
    }
}