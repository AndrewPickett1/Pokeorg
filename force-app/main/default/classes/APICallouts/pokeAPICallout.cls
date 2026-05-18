public without sharing class pokeAPICallout {

    //should probably be a queueable
    @future(callout=true)
    public static void makeCallout(String pokemonName){
        //gets the Pokedex Entry record to be updated
        Pokedex_Entry__c pkmn = new Pokedex_Entry__c();
        pkmn = [SELECT Id, Name FROM Pokedex_Entry__c WHERE Name = :pokemonName LIMIT 1];

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

        if(response.getStatusCode() == 200){
            System.debug('==== CALLOUT SUCCESSFULL ====');
            Map<String, Object> pokemonData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            
            //okeAPIMoveData wrapperClass = json.deserialize(response.getBody(), PokeAPIMoveData.class);
            //System.debug('Wrapper Class Data: ' + wrapperClass);

            pkmn = handleStats(pokemonData, pkmn);
            pkmn = handleSprites(pokemonData, pkmn);
            //handleMoves(pokemonData, pkmn);
            update pkmn;
        }
    }

    public static Pokedex_Entry__c handleStats(Map<String, Object> pokemonData , Pokedex_Entry__c pkmn){
        System.debug('==== Stats Handler ====');

        //first typecast
        List<Object> statsData = (List<Object>) pokemonData.get('stats');

        //initializes pokemon value map
        Map<String, Integer> statsMap = new Map<String, Integer>();

        //parse the stats
        for(Object statData : statsData){
            //stat value
            Map<String,Object> statDataMap = (Map<String,Object>) statData;
            //System.debug('Base Stat: ' + statDataMap.get('base_stat'));

            //stat name
            Map<String,Object> statName = (Map<String,Object>) statDataMap.get('stat');
            //System.debug('Stat Name: ' + statName.get('name'));

            //put values in map
            statsMap.put(
                //Stat Name
                String.valueOf(statName.get('name')) , 
                //Stat value
                Integer.valueOf(statDataMap.get('base_stat'))
                );
        }
        System.debug(statsMap);

        //update pokemons stats
        pkmn.Attack__c = statsMap.get('attack');
        pkmn.Defense__c = statsMap.get('defense');
        pkmn.HP__c = statsMap.get('hp');
        pkmn.Sp_Attack__c = statsMap.get('special-attack');
        pkmn.Sp_Defense__c = statsMap.get('special-defense');
        pkmn.Speed__c = statsMap.get('speed');

        return pkmn;
    }

    public static void handleMoves(Map<String, Object> pokemonData, Pokedex_Entry__c pkmn){
        System.debug('==== Move Handler ====');

        List<Object> moves = (List<Object>) pokemonData.get('moves');
        System.debug('Moves Size: ' + moves.size());        

        List<Integer> MoveIdList = new List<Integer>();

        for (Object move : moves){
            Map<String, Object> moveData = (Map<String, Object>) move;
            Map<String, Object> moveObject = (Map<String, Object>) moveData.get('move');
            String moveId = String.valueOf(moveObject.get('url'));

            moveId = moveId.remove('https://pokeapi.co/api/v2/move/');
            moveId = moveId.remove('/');
            
            MoveIdList.add(Integer.valueOf(moveId));
        }

        System.debug(MoveIdList);
        
        List<TM__c> TMList = [SELECT Id FROM TM__c WHERE Move_Id__c IN :MoveIdList];
        System.debug(TMList);


    }

    public static Pokedex_Entry__c handleSprites(Map<String, Object> pokemonData , Pokedex_Entry__c pkmn){
        System.debug('==== Sprites Handler ====');
        Map<String, Object> sprites = (Map<String, Object>) pokemonData.get('sprites');
                        
            // get sprite URLs
            String frontSprite = (String) sprites.get('front_default');
            String backSprite = (String) sprites.get('back_default');
            // System.debug('Front Sprite: ' + frontSprite);
            // System.debug('Back Sprite: ' + backSprite);

            pkmn.Sprite_Back_URL__c = backSprite;
            pkmn.Sprite_Front_URL__c = frontSprite;

            return pkmn;
    }

   //used in a flow
   @invocableMethod(label='Make Poke API callout')
   public static void invokeCallout(List<String> pokemonNameList){
       pokeAPICallout.makeCallout(pokemonNameList[0]);
   }

}