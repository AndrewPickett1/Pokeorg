public with sharing class BattleService {
    private Move__c pkmn1Move;
    private Move__c pkmn2Move;

    private Pokemon__c pkmn1;
    private Pokemon__c pkmn2;

    private Pokemon__c firstMover;
    private Pokemon__c secondMover;

    private Move__c firstMoverAttack;
    private Move__c secondMoverAttack;


    public BattleService(Id pkmn1MoveId, Id pkmn2MoveId){
        List<Move__c> moveRecords = [SELECT 
            Id, 
            Pokemon__c, 
            PP__c,
            TM__r.Category__c, 
            TM__r.Power__c,
            TM__r.Type__c,
            TM__r.Name,
            TM__r.Status_Modifier__c
            FROM Move__c 
            WHERE (Id = :pkmn1MoveId OR Id = :pkmn2MoveId)
            LIMIT 2
            ];
        
        for(Move__c move : moveRecords){
            if(move.Id == pkmn1MoveId){
                this.pkmn1Move = move;
            } else {
                this.pkmn2Move = move;
            }
        }

        List<Pokemon__c> pkmnRecords = [
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
            Status__c,
            Level__c
            FROM Pokemon__c 
            WHERE (Id = :this.pkmn1Move.Pokemon__c OR Id = :this.pkmn2Move.Pokemon__c)
            LIMIT 2
            ];

        for(Pokemon__c pkmn : pkmnRecords){
            if(pkmn.Id == this.pkmn1Move.Pokemon__c){
                this.pkmn1 = pkmn;
            } else {
                this.pkmn2 = pkmn;
            }
        }
    }
    
    public void turnCalc(Id pkmn1Move, Id pkmn2Move){
        
        determineMoveOrder(this.pkmn1, this.pkmn2);

        applyTurn(this.firstMover, this.secondMover, this.firstMoverAttack);
        applyTurn(this.secondMover, this.firstMover, this.secondMoverAttack);
        
        update this.pkmn1;
        update this.pkmn2;

        update this.pkmn1Move;
        update this.pkmn2Move;
    }

    private Integer damageCalc(Pokemon__c attackingPkmn, Pokemon__c defendingPkmn, Move__c move){
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

    private Boolean eligibleToAttack(Pokemon__c pkmn){
        return pkmn.Current_HP__c > 0 && pkmn.Status__c != 'Sleep';
    }

    public void decrementPP(Move__c move){
            move.PP__c -= 1;
    }

    private void determineMoveOrder(Pokemon__c pkmn1, Pokemon__c pkmn2){
        
        if(pkmn1.Pokedex_Entry__r.Speed__c > pkmn2.Pokedex_Entry__r.Speed__c){
            this.firstMover = pkmn1;
            this.secondMover = pkmn2;

            this.firstMoverAttack = this.pkmn1Move;
            this.secondMoverAttack = this.pkmn2Move;
        } else {
            this.firstMover = pkmn2; 
            this.secondMover= pkmn1; 

            this.firstMoverAttack = this.pkmn2Move;
            this.secondMoverAttack = this.pkmn1Move;
        }

        System.debug('First Mover: ' + this.firstMover);
        System.debug('Second Mover: ' + this.secondMover);
    }

    private void applyTurn(Pokemon__c attackingPkmn, Pokemon__c defendingPokemon, Move__c move){
        
        if(!eligibleToAttack(attackingPkmn)) return;
        defendingPokemon.Current_HP__c -=  damageCalc(attackingPkmn, defendingPokemon, move);
        decrementPP(move);


    }

    //random num generator for move selection
    private Integer randomIntGen(Integer max){
        return Integer.valueOf(math.random() * max);
    }
}