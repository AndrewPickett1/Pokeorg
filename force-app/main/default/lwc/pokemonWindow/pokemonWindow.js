import { LightningElement, api, wire } from 'lwc';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Pokemon__c.Pokedex_Entry__r.Name';
import ID from '@salesforce/schema/Pokemon__c.Id';
import SPRITE_URL from '@salesforce/schema/Pokemon__c.Pokedex_Entry__r.Sprite_Front_URL__c';
import CURR_HP_FIELD from '@salesforce/schema/Pokemon__c.Current_HP__c';
import MAX_HP_FIELD from '@salesforce/schema/Pokemon__c.Max_HP__c';
import STATUS_FIELD from '@salesforce/schema/Pokemon__c.Status__c';

export default class PokemonWindow extends LightningElement {
    @api recordId;

    @wire(getRecord, {
        recordId: '$recordId',
        fields: [NAME_FIELD, ID, SPRITE_URL, CURR_HP_FIELD, MAX_HP_FIELD, STATUS_FIELD]
    })
    pokemonRecord;

    get pkmnName(){
        return getFieldValue(this.pokemonRecord.data, NAME_FIELD);
    }
    get pkmnId(){
        return getFieldValue(this.pokemonRecord.data, ID);
    }

    get spriteUrl(){
        return getFieldValue(this.pokemonRecord.data, SPRITE_URL);
    }
    get currHp(){
        return getFieldValue(this.pokemonRecord.data, CURR_HP_FIELD)
    }
    get maxHp(){
        return getFieldValue(this.pokemonRecord.data, MAX_HP_FIELD)
    }
    get hpPercentage(){
        return getFieldValue(this.pokemonRecord.data, CURR_HP_FIELD) / getFieldValue(this.pokemonRecord.data, MAX_HP_FIELD) * 100
    }
    get status(){
        return getFieldValue(this.pokemonRecord.data, STATUS_FIELD)
    }

}