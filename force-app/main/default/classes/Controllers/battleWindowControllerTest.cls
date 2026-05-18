@isTest
private class battleWindowControllerTest {
    
    @TestSetup
    static void setup(){
        
        List<Pokedex_Entry__c> pkdxEntries = new List<Pokedex_Entry__c>();
        List<Pokemon__c> pkmns = new List<Pokemon__c>();
        List<Move__c> moves = new List<Move__c>();
        
        List<TM__c> tms = new List<TM__c>();
        Integer numTmsToCreate = 4;

        //insert TMs
        for(Integer i = 0; i < numTmsToCreate; i++){
            TM__c tm = new TM__c();
            tm.Name = 'Test TM '+ (i+1);
            tm.Power__c = 100;
            tm.Move_Id__c = (i+1); 
            tms.add(tm);
        }
        insert tms;
        
        //insert pokedex entries
        for(Integer i=0;i<2;i++){
            Pokedex_Entry__c pkdxEntry = new Pokedex_Entry__c();
            pkdxEntry.Name = 'Test Poke ' + (i+1);
            pkdxEntry.Sprite_Back_URL__c = 'testBack' + (i+1);
            pkdxEntry.Sprite_Front_URL__c = 'testFront' + (i+1);

            pkdxEntries.add(pkdxEntry);
        }
        insert pkdxEntries;

        //insert pokemon
        for(Pokedex_Entry__c entry : pkdxEntries){
            Pokemon__c pkmn = new Pokemon__c();
            pkmn.Pokedex_Entry__c = entry.Id;

            pkmns.add(pkmn);
        }
        insert pkmns;


        //insert moves
        for(Integer i=0; i<tms.size(); i++){
            Move__c pkmn1Mv = new Move__c();
            pkmn1Mv.TM__c = tms[i].id;
            pkmn1Mv.Pokemon__c = pkmns[0].id;

            Move__c pkmn2Mv = new Move__c();
            pkmn2Mv.TM__c = tms[i].id;
            pkmn2Mv.Pokemon__c = pkmns[1].id;

            moves.add(pkmn1Mv, pkmn2Mv);
        }
        insert moves;

        Battle__c battle = new Battle__c();
        battle.Pokemon_1__c = pkmns[0].Id;
        battle.Pokemon_2__c = pkmns[1].Id;
        insert battle;
    }

    @isTest
    static void testLeftImgUrl(){
        Battle__c battle = [SELECT Id FROM Battle__c LIMIT 1];

        String url = battleWindowController.leftPkmnImgUrl(battle.Id);

        Assert.isNotNull(url, 'URL should not be null');
    }

    @isTest
    static void testRightImgUrl(){
        Battle__c battle = [SELECT Id FROM Battle__c LIMIT 1];

        String url = battleWindowController.rightPkmnImgUrl(battle.Id);

        Assert.isNotNull(url, 'URL should not be null');
    }
}