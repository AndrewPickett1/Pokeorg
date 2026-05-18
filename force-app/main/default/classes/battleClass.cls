public with sharing class battleClass {

    public static Integer damageCalc(Pokemon__c attackingPkmn, Pokemon__c defendingPkmn, Move__c move){
        Decimal damage = 0;
        
        
        if(move.TM__r.Category__c == 'Status Modifier'){
            //Status Modifier
            system.debug('Category: Status Modifier');
            defendingPkmn.Status__c = move.TM__r.Status_Modifier__c;

        } else if(move.TM__r.Category__c == 'Special'){
            //Special Damage Calculation
            system.debug('Category: Special');
            damage = ((
                (2 * attackingPkmn.Level__c/5) +2) * 
                move.TM__r.Power__c * 
                (attackingPkmn.Pokedex_Entry__r.Sp_Attack__c / defendingPkmn.Pokedex_Entry__r.Sp_Defense__c)) 
                / 50 + 2;

        } else if (move.TM__r.Category__c == 'Physical') {
            //Physical Damage Calculation
            system.debug('Category: Physical');
            damage = ((
                (2 * attackingPkmn.Level__c/5) +2) * 
                move.TM__r.Power__c * 
                (attackingPkmn.Pokedex_Entry__r.Attack__c / defendingPkmn.Pokedex_Entry__r.Defense__c)) 
                / 50 + 2;
        }

        //STAB
        if(move.TM__r.Type__c == attackingPkmn.Pokedex_Entry__r.Type__c){
            damage = damage * 1.5;
        }

        system.debug(damage);
        return Integer.valueOf(damage);
    }

    public static Pokemon__c moveOrderCalc(Pokemon__c pkmn1, Pokemon__c pkmn2){
        
        if(pkmn1.Pokedex_Entry__r.Speed__c > pkmn1.Pokedex_Entry__r.Speed__c){
            System.debug('First Mover: Pkmn 1');
            return pkmn1;
        } else {
            System.debug('First Mover: Pkmn 2');
            return pkmn2;
        }
    }

    public static void applyTurn(Pokemon__c attackingPkmn, Pokemon__c defendingPokemon, Move__c move, Map<String, Map<String, String>> turnInfoMap){
        Integer dmg = 0;
        dmg = damageCalc(attackingPkmn, defendingPokemon, move);
        defendingPokemon.Current_HP__c -= dmg;

        System.debug('Attacking Pokemon: ' + attackingPkmn.Pokedex_Entry__r.Name);
        System.debug('Defending Pokemon: ' + defendingPokemon.Pokedex_Entry__r.Name);
        System.debug('Move: ' + move.TM__r.Name);
        System.debug('Damage: ' + dmg);
        System.debug('Defending Pokemon HP: ' + defendingPokemon.Current_HP__c);

        //creats map of key info from this pokemons turn
        Map<String, String> turnInfo = new Map<String, String>{
            'attackingPkmn' => attackingPkmn.Pokedex_Entry__r.Name,
            'move' => move.TM__r.Name,
            'dmg' => String.valueOf(dmg)
        };
        turnInfoMap.put(attackingPkmn.Pokedex_Entry__r.Name, turnInfo);

    }

    @AuraEnabled
    public static Map<String, Map<String, String>> turnCalc(Id pkmn1Move, Id pkmn2Move){

        //I wonder if these queries should be done in a constructor
        // querys moves used
        Move__c pkmn1MoveRec = [
            SELECT 
            Id, 
            Pokemon__c, 
            TM__r.Category__c, 
            TM__r.Power__c,
            TM__r.Type__c,
            TM__r.Name,
            TM__r.Status_Modifier__c
            FROM Move__c 
            WHERE Id = :pkmn1Move 
            LIMIT 1
            ];
        Move__c pkmn2MoveRec = [
            SELECT 
            Id, 
            Pokemon__c, 
            TM__r.Category__c, 
            TM__r.Power__c,
            TM__r.Type__c,
            TM__r.Name,
            TM__r.Status_Modifier__c
            FROM Move__c 
            WHERE Id = :pkmn2Move 
            LIMIT 1
            ];
        System.debug('Pkmn 1 Move: ' + pkmn1MoveRec.TM__r.Name);
        System.debug('Pkmn 2 Move: ' + pkmn2MoveRec.TM__r.Name);
        
        // querys pokemon
        Pokemon__c pkmn1 = [
            SELECT 
            Id, 
            Pokedex_Entry__r.Speed__c, 
            Pokedex_Entry__r.Attack__c, 
            Pokedex_Entry__r.Defense__c, 
            Pokedex_Entry__r.Sp_Attack__c,
            Pokedex_Entry__r.Sp_Defense__c,
            Pokedex_Entry__r.Type__c,
            Pokedex_Entry__r.Name,
            Current_HP__c, 
            Level__c
            FROM Pokemon__c 
            WHERE Id = :pkmn1MoveRec.Pokemon__c
            ];
        Pokemon__c pkmn2 = [
            SELECT
            Id, 
            Pokedex_Entry__r.Speed__c, 
            Pokedex_Entry__r.Attack__c, 
            Pokedex_Entry__r.Defense__c, 
            Pokedex_Entry__r.Sp_Attack__c,
            Pokedex_Entry__r.Sp_Defense__c,
            Pokedex_Entry__r.Type__c,
            Pokedex_Entry__r.Name,
            Current_HP__c, 
            Level__c
            FROM Pokemon__c 
            WHERE Id = :pkmn2MoveRec.Pokemon__c
            ];
        System.debug('Pkmn 1 Name: ' + pkmn1.Pokedex_Entry__r.Name);
        System.debug('Pkmn 2 Name: ' + pkmn2.Pokedex_Entry__r.Name);

        // finds first mover
        Pokemon__c firstMover = battleClass.moveOrderCalc(pkmn1, pkmn2);

        //Maps of turn info
        Map<String, Map<String, String>> turnInfoMap = new Map<String, Map<String, String>>();

        if(pkmn1 == firstMover){
            //pkmn1 moves first
            applyTurn(pkmn1, pkmn2, pkmn1MoveRec, turnInfoMap);
            
            //pkmn2 moves second
            if (pkmn2.Current_HP__c > 0) {
                applyTurn(pkmn2, pkmn1, pkmn2MoveRec, turnInfoMap);
            } else {
                system.debug('Battle Complete: pkmn 2 fainted');
            }
        
        } else {
            
            //pkmn2 moves first
            applyTurn(pkmn2, pkmn1, pkmn2MoveRec, turnInfoMap);

            //pkmn1 moves second
            if(pkmn1.Current_HP__c > 0){
                applyTurn(pkmn1, pkmn2, pkmn1MoveRec, turnInfoMap);
            } else {
                system.debug('Battle Complete: pkmn 1 fainted');
            }
        }

        //checks whether or not the pkmns HP has 0 or below HP. If so, set to 0
        if(pkmn1.Current_HP__c <= 0){
            System.debug('finish the battle here');
            System.debug('Winner: Pkmn 2');
            //prevents pokemons HP from going below 0
            pkmn1.Current_HP__c = 0;
            update pkmn1;
            update pkmn2;

        } else if(pkmn2.Current_HP__c <= 0) {
            System.debug('finish the battle here');
            System.debug('Winner: Pkmn 1');
            //prevents pokemons HP from going below 0
            pkmn2.Current_HP__c = 0;
            update pkmn1;
            update pkmn2;

        } else {
            update pkmn1;
            update pkmn2;
        }
        
        System.debug(turnInfoMap);
        return turnInfoMap;

        // Idea: Flow orchestration for prompting move selections from multiple users
    }

    //random num generator for move selection
    public static Integer randomIntGen(Integer max){
        return Integer.valueOf(math.random() * max);
    }
}