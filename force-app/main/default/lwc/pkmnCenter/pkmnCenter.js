import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getPartyPokemon from '@salesforce/apex/pkmnCenterController.getPartyPkmn';
import healPartyPkmn from '@salesforce/apex/pkmnCenterController.healPartyPkmn';
import backgroundPng from '@salesforce/resourceUrl/pkmnCenterBackground';
import {RefreshEvent} from 'lightning/refresh'

import Id from '@salesforce/user/Id';

export default class PkmnCenter extends LightningElement {

    //get all pokemon currently in party
    userId = Id;
    partyPkmn;
    background = backgroundPng

    //might want to make this a wire service so pkmn refresh right when you click Heal pkmn
    connectedCallback(){
        getPartyPokemon({
            UserId: this.userId
        })
        .then((result) => {
            console.log(result);
            this.partyPkmn = result
        })
        .catch((error) => {
            console.log(error)
        })
    }

    handleClick(){
        healPartyPkmn({
            partyPkmn: this.partyPkmn
        })
        .then((result) => {
            console.log(result)
            //eval("$A.get('e.force:refreshView').fire();");
            this.dispatchEvent(new RefreshEvent());

            const event = new ShowToastEvent({
                title: 'Success',
                message: 'Your Pokemon have been healed',
                variant: 'success'
            })
            this.dispatchEvent(event)

        })
        .error((error) => {
            console.log(error)
        })
    }


}