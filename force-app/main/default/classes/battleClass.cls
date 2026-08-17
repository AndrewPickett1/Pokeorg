public with sharing class battleClass {

    @AuraEnabled
    public static void turnCalc(Id pkmn1Move, Id pkmn2Move){
        
        BattleService bs = new BattleService(pkmn1Move, pkmn2Move);
        try {
            bs.turnCalc();    
        } catch (Exception e) {
            //throw aura handled exception
            throw new AuraHandledException('YOU DID BAD');
        }
        
    }
}