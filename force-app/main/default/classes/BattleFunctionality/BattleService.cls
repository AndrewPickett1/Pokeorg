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
    
    public void turnCalc(){
        
        determineMoveOrder(this.pkmn1, this.pkmn2);
        
        BattleInputWrapper firstMoverInputs = new BattleInputWrapper(this.firstMover, this.secondMover, this.firstMoverAttack);
        BattleInputWrapper secondMoverInputs = new BattleInputWrapper(this.secondMover, this.firstMover, this.secondMoverAttack);

        applyTurn(firstMoverInputs);
        applyTurn(secondMoverInputs);
        
        update new List<SObject>{this.pkmn1, this.pkmn2, this.pkmn1Move, this.pkmn2Move};
    }

    private Boolean eligibleToAttack(Pokemon__c pkmn){
        return pkmn.Current_HP__c > 0 && pkmn.Status__c != 'Sleep';
    }

    private void decrementPP(Move__c move){
            move.PP__c -= 1;
    }

    //todo - add tie conditions
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
    }

    private void applyTurn(BattleInputWrapper inputs){
        
        if(!eligibleToAttack(inputs.attackingPkmn)) return;

        moveCalculation(inputs);
        decrementPP(inputs.move);

    }

    private void moveCalculation(BattleInputWrapper inputs){
        if(inputs.move.TM__r.Category__c == 'Status Modifier'){
            //Status Modifier
            statusModifierCalculation(inputs);
            
        } else if(inputs.move.TM__r.Category__c == 'Special'){
            damageCalculation(inputs, 'Special');
            

        } else if (inputs.move.TM__r.Category__c == 'Physical') {
            //Physical Damage Calculation
            damageCalculation(inputs, 'Physical');
        }
    }

    private void damageCalculation(BattleInputWrapper inputs, String moveCategory){
        //set to 1 to avoid getting issues if for some reason a value isn't populated
        Decimal atk = 1;
        Decimal def = 1;
        Decimal damage = 0;

        if(inputs.move.TM__r.Category__c == 'Special'){
            atk = inputs.attackingPkmn.Pokedex_Entry__r.Sp_Attack__c;
            def = inputs.defendingPkmn.Pokedex_Entry__r.Sp_Defense__c;
        } else {
            atk = inputs.attackingPkmn.Pokedex_Entry__r.Attack__c;
            def = inputs.defendingPkmn.Pokedex_Entry__r.Defense__c;
        }

        damage = (
            ((2 * inputs.attackingPkmn.Level__c/5) +2) * 
                inputs.move.TM__r.Power__c * 
                (atk / def)
            ) / 50 + 2;

        //STAB
        if(inputs.move.TM__r.Type__c == inputs.attackingPkmn.Pokedex_Entry__r.Type__c) damage *= 1.5;
        
        inputs.defendingPkmn.Current_HP__c -= damage.round();
        
        System.debug(inputs.attackingPkmn.Pokedex_Entry__r.Name + ' hit ' + inputs.defendingPkmn.Pokedex_Entry__r.Name + ' with ' + inputs.move.TM__r.Name + ' for ' + String.valueOf(damage.round()) + ' dmg.');
    }

    private void statusModifierCalculation(BattleInputWrapper inputs){
        inputs.defendingPkmn.Status__c = inputs.move.TM__r.Status_Modifier__c;
        system.debug('Category: Status Modifier');
    }

    private class BattleInputWrapper{
        protected Pokemon__c attackingPkmn;
        protected Pokemon__c defendingPkmn;
        protected Move__c move;
        
        BattleInputWrapper(Pokemon__c attackingPkmn, Pokemon__c defendingPkmn, Move__c move){
            this.attackingPkmn = attackingPkmn;
            this.defendingPkmn = defendingPkmn;
            this.move = move;
        }
    }

}