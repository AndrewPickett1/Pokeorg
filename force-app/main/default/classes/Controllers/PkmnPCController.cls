public with sharing class PkmnPCController {
    
    @AuraEnabled(cacheable=true)
    public static List<Pokemon__c> getUsersPkmn(Id userId){

        return [
            SELECT Id, Pokemon_Name__c, In_Party__c
            FROM Pokemon__c
            WHERE Owner__c = :userId
        ];
    } 
}