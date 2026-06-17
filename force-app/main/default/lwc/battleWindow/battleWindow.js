//to do:
// Buttons should have visual selection
// moves should be accessed via a wire
// toast event/page refresh on move submission

import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue, getRecordNotifyChange } from 'lightning/uiRecordApi';

//need to use custom css from static resource
import {loadStyle} from 'lightning/platformResourceLoader';
import AnimateCSS from '@salesforce/resourceUrl/AnimateCSS';

import BATTLE_OBJECT from '@salesforce/schema/Battle__c';
import PKMN1_ID from '@salesforce/schema/Battle__c.Pokemon_1__r.Id';
import PKMN2_ID from '@salesforce/schema/Battle__c.Pokemon_2__r.Id';
import BATTLE_STATUS from '@salesforce/schema/Battle__c.Status__c';
import VICTOR from '@salesforce/schema/Battle__c.Victor__c';

import PKMN1_NAME from '@salesforce/schema/Battle__c.Pokemon_1__r.Pokedex_Entry__r.Name';
import PKMN2_NAME from '@salesforce/schema/Battle__c.Pokemon_2__r.Pokedex_Entry__r.Name';

import PKMN1_SPRITE from '@salesforce/schema/Battle__c.Pokemon_1__r.Pokedex_Entry__r.Sprite_Back_URL__c';
import PKMN2_SPRITE from '@salesforce/schema/Battle__c.Pokemon_2__r.Pokedex_Entry__r.Sprite_Front_URL__c';

import PKMN1_MAXHP from '@salesforce/schema/Battle__c.Pokemon_1__r.Max_HP__c';
import PKMN1_CURRHP from '@salesforce/schema/Battle__c.Pokemon_1__r.Current_HP__c';
import PKMN2_MAXHP from '@salesforce/schema/Battle__c.Pokemon_2__r.Max_HP__c';
import PKMN2_CURRHP from '@salesforce/schema/Battle__c.Pokemon_2__r.Current_HP__c';

import BATTLE_WINDOW from './battleWindow.html';
import VICTORY_WINDOW from './battleVictoryWindow.html';

import getPkmnMoveList from '@salesforce/apex/battleWindowController.pkmnMoves';
import battleClass from '@salesforce/apex/battleClass.turnCalc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {RefreshEvent} from 'lightning/refresh'

import { getRelatedListRecords } from 'lightning/uiRelatedListApi';


export default class BattleWindow extends LightningElement {
    
    // IDEA - pokemon card LWC - would show all the pkmn in your party. Could add to Users page.

    //displays victory window if status = completed
    render(){
        if (getFieldValue(this.battleRecord.data, BATTLE_STATUS) === 'Completed'){ 
            return VICTORY_WINDOW;
        } else {
            return BATTLE_WINDOW;
        }
    }

    @api recordId;
    battleObject = BATTLE_OBJECT

    //pokemon arent refreshing because the battle record hasn't changed
    @wire(getRecord, {
        recordId: '$recordId', 
        fields: [PKMN1_ID, PKMN2_ID, PKMN1_NAME, PKMN2_NAME, PKMN1_SPRITE, PKMN2_SPRITE, PKMN1_MAXHP, PKMN1_CURRHP, PKMN2_MAXHP, PKMN2_CURRHP, BATTLE_STATUS, VICTOR]})
    battleRecord;

    // names and sprites
    // I think these need to be done in a getter since it is possible to switch out the pokemon on the Battle record. 
    get pkmn1NameField(){
        return getFieldValue(this.battleRecord.data, PKMN1_NAME)
    }
    get pkmn2NameField(){
        return getFieldValue(this.battleRecord.data, PKMN2_NAME)
    }
    get pkmn1SpriteURL(){
        return getFieldValue(this.battleRecord.data, PKMN1_SPRITE)
    }
    get pkmn2SpriteURL(){
        return getFieldValue(this.battleRecord.data, PKMN2_SPRITE)
    }
    get victor(){
        if(getFieldValue(this.battleRecord.data, PKMN1_ID) === getFieldValue(this.battleRecord.data, VICTOR)){
            return getFieldValue(this.battleRecord.data, PKMN1_NAME)
        } else if(getFieldValue(this.battleRecord.data, PKMN2_ID) === getFieldValue(this.battleRecord.data, VICTOR)){
            return getFieldValue(this.battleRecord.data, PKMN2_NAME)
        }
    }

    // is fainted logic
    get pkmn1Id(){
        return getFieldValue(this.battleRecord.data, PKMN1_ID)
    }
    get pkmn2Id(){
        return getFieldValue(this.battleRecord.data, PKMN2_ID)
    }

    //instantiate move set vars
    pkmn1MoveSet; pkmn2MoveSet;
    pkmn1MoveSelection; pkmn2MoveSelection;
    error;

    // pulls sprite URLs upon page load
    async connectedCallback(){
        
        //loads styles before running the rest of the initializations
        await loadStyle(this, AnimateCSS);
        
        //get pkmn 1 moves
        getPkmnMoveList({
            BattleId: this.recordId,
            Pkmn: 1
        })
            .then((result) => {
                //initializes move set
                this.pkmn1MoveSet = [
                    {Move__c: '...'}, 
                    {Move__c: '...'}, 
                    {Move__c: '...'}, 
                    {Move__c: '...'}
                ];
                //populates moves into moveset
                console.log('result: ' + JSON.stringify(result))
                for(let i = 0; i < result.length; i++){
                    this.pkmn1MoveSet[i] = result[i];
                }
                console.log(this.pkmn1MoveSet);
            })
            .catch((error) => {
                console.error(error);
            });
        
        // get pkmn 2 moves
        getPkmnMoveList({
            BattleId: this.recordId,
            Pkmn: 2
        })
            .then((result) => {
                //initializes move set
                this.pkmn2MoveSet = [
                    {Move__c: '...'}, 
                    {Move__c: '...'}, 
                    {Move__c: '...'}, 
                    {Move__c: '...'}
                ];

                for(let i = 0; i < result.length; i++){
                    this.pkmn2MoveSet[i] = result[i];
                }
            })
            .catch((error) => {
                console.error(error);
            });

        

    }

    handlePkmn1MoveSelection(event){
        //console.log('Event Name: ' + event.target.value);
        this.pkmn1MoveSelection = event.target.value
    }

    handlePkmn2MoveSelection(event){
        //console.log('Event Name: ' + event.target.value);
        this.pkmn2MoveSelection = event.target.value


    }

    handleTurnSubmission(){
        console.log('Pkmn 1 Move: ' + this.pkmn1MoveSelection);
        console.log('Pkmn 2 Move: ' + this.pkmn2MoveSelection);

        //calls battle class
        battleClass({
            pkmn1Move: this.pkmn1MoveSelection,
            pkmn2Move: this.pkmn2MoveSelection
        })
        .then((result) => {
            console.log(result)
            this.dispatchEvent(new RefreshEvent());

            const event = new ShowToastEvent({
                title: 'Success',
                message: 'Move submitted successfully'
            })
            this.dispatchEvent(event)

        })
        .error((error) => {
            console.error(error);
        })
        //refresh page
        //getRecordNotifyChange([{recordId: this.recordId}])

        //toast success event


    }


}