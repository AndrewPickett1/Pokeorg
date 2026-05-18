public class pkmnCenterController {
    
    @AuraEnabled
    public static list<Pokemon__c> getPartyPkmn(string UserId){
        
        list<Pokemon__c> partyPkmn = new list<Pokemon__c>([
            SELECT Id, Pokemon_Name__c, Current_HP__c, Max_HP__c, Status__c
            FROM Pokemon__c 
            WHERE Owner__c = :UserId
            AND In_Party__c = true
            LIMIT 6]);
        
        system.debug('Party Pokemon:');
        for(Pokemon__c pkmn : partyPkmn){
            System.debug(pkmn.Pokemon_Name__c);
        }

        return partyPkmn;
    }

    @AuraEnabled
    public static void healPartyPkmn(list<Pokemon__c> partyPkmn){

        for(Pokemon__c pkmn : partyPkmn){
            pkmn.Current_HP__c = pkmn.Max_HP__c;
            pkmn.Status__c = null;
        }

        update partyPkmn;
    }
    
}