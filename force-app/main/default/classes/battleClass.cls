public with sharing class battleClass {

    @AuraEnabled
    public static Map<String, Map<String, String>> turnCalc(Id pkmn1Move, Id pkmn2Move){
        
        BattleService bs = new BattleService(pkmn1Move, pkmn2Move);
        try {
            return bs.turnCalc(pkmn1Move, pkmn2Move);    
        } catch (Exception e) {
            //throw aura handled exception
            throw new AuraHandledException('YOU DID BAD');
        }
        
        
    }

    @AuraEnabled
    public static void decrementPP(Move__c pkmn1Move, Move__c pkmn2Move){
        BattleService bs = new BattleService(pkmn1Move.Id, pkmn2Move.Id);
        
        try {
            bs.decrementPP(pkmn1Move, pkmn2Move);    
        } catch (Exception e) {
            throw new AuraHandledException('YOU DID BAD AGAIN!');
        }
        


    }


}