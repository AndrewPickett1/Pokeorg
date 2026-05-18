public without sharing class pokeAPIMoveService {
    
    @AuraEnabled(cacheable=true)
    public static List<TM__c> makeCallout(String pokemonId){
        
        //queries for the pkmns name since we dont have it in the LWC
        String pokemonName = [SELECT Pokemon_Name__c FROM Pokemon__c WHERE Id = :pokemonId].Pokemon_Name__c;
        System.debug('Pokemon Name: ' + pokemonName);

        //sets up endpoint URL
        String endpointURL = 'https://pokeapi.co/api/v2/pokemon/'+ pokemonName.toLowerCase();
        System.debug('Endpoint URL: '+ endpointURL);

        //instantiates Http callout
        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setEndpoint(endpointURL);
        req.setMethod('GET');

        //sends request
        HttpResponse response = http.send(req);

        pokemonMove wrapperClass = new pokemonMove();

        if(response.getStatusCode() == 200){
            System.debug('==== CALLOUT SUCCESSFULL ====');
            Map<String, Object> pokemonData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            
            wrapperClass = (pokemonMove) json.deserialize(response.getBody(), pokemonMove.class);
            System.debug('Wrapper Class Data: ' + wrapperClass);

        }
        
        return retrieveMoves(wrapperClass.Moves);
    }

    private static List<TM__c> retrieveMoves(List<pokemonMove.MoveData> wcMoves){
        List<Integer> moveIds = new List<Integer>();
        
        for(pokemonMove.MoveData move: wcMoves){
            String moveId = move.move.url;
            moveId = moveId.remove('https://pokeapi.co/api/v2/move/');
            moveId = moveId.remove('/');
            moveIds.add(Integer.valueOf(moveId));
            System.debug('Move Id: ' + moveId);
        } 

        

        List<TM__c> TMList = [
            SELECT Id, Name, Type__c, Power__c, Accuracy__c, Category__c, PP__c 
            FROM TM__c 
            WHERE Move_Id__c 
            IN :moveIds
            ];

        System.debug('TMs: ' + TMList);
        

        return TMList;

    }
}