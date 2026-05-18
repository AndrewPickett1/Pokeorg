import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import PKMN_NAME from '@salesforce/schema/Pokemon__c.Pokedex_Entry__r.Name';
import PKMN_OBJECT from '@salesforce/schema/Pokemon__c';

import MAXHP from '@salesforce/schema/Pokemon__c.Max_HP__c';
import CURRHP from '@salesforce/schema/Pokemon__c.Current_HP__c';
import STATUS from '@salesforce/schema/Pokemon__c.Status__c';

export default class PkmnHealthBar extends LightningElement {
    //pokemon Nameplate would be a better name
    @api pkmnId

    //wire that gets pokemon fields
    @wire(getRecord, {
        recordId: '$pkmnId',
        fields: [PKMN_NAME, MAXHP, CURRHP,STATUS]})
    pkmnRecord;

    get pkmnNameField(){ return getFieldValue(this.pkmnRecord.data, PKMN_NAME) }
    get pkmnMaxHp(){ return getFieldValue(this.pkmnRecord.data, MAXHP) }
    get pkmnCurrHp(){ return getFieldValue(this.pkmnRecord.data, CURRHP) }
    get pkmnHpPercent(){ return getFieldValue(this.pkmnRecord.data, CURRHP) / getFieldValue(this.pkmnRecord.data, MAXHP) * 100 }
    
    
    // we should have a constants class
    get status(){
            if(getFieldValue(this.pkmnRecord.data, STATUS) == 'Poison'){
                return 'PSN'
            } else if(getFieldValue(this.pkmnRecord.data, STATUS) == 'Sleep') {
                return 'SLP'            
            } else if(getFieldValue(this.pkmnRecord.data, STATUS) == 'Paralyzed') {
                return 'PRLZ'
            } else if(getFieldValue(this.pkmnRecord.data, STATUS) == 'Burn') {
                return 'BRN'
            } else if(getFieldValue(this.pkmnRecord.data, STATUS) == 'Frozen') {
                return 'FRZ'            
            } else {
                return null
            }
        }
    get isFainted(){
        if(getFieldValue(this.pkmnRecord.data, CURRHP) === 0){
            return true
        } else {
            return false
        }
    }

    //returns different class for each status condition
    get statusBadgeClass(){
        switch(this.status){
            case 'PSN':
                return 'status-badge-psn'
                break;
            case 'BRN':
                return 'status-badge-brn'
                break;
            case 'PRLZ':
                return 'status-badge-prlz'
                break;
            case 'FRZ':
                return 'status-badge-frz'
                break
        }
    }
       

    //wire get record of Pkmn and all their fields
    //front sprite or back sprite variable
}