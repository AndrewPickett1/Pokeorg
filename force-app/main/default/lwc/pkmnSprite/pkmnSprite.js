import { LightningElement, api, wire } from 'lwc';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';

import FRONT_SPRITE from '@salesforce/schema/Pokemon__c.Sprite_Front_URL__c';
import BACK_SPRITE from '@salesforce/schema/Pokemon__c.Sprite_Back_URL__c'

export default class PkmnSprite extends LightningElement {
    
    @api pkmnId
    @api backSprite = false
    @api height = 80
    @api width = 80

    @wire(getRecord, {
        recordId: '$pkmnId',
        fields: [FRONT_SPRITE, BACK_SPRITE]
    })
    pkmnRecord

    get spriteUrl(){
        if(this.backSprite === true){
            return getFieldValue(this.pkmnRecord.data, BACK_SPRITE)
        } else {
            return getFieldValue(this.pkmnRecord.data, FRONT_SPRITE)
        }        
    }



}