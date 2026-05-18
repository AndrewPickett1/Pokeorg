import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import worldMap from '@salesforce/resourceUrl/worldMap';
import wildPkmnCreator from '@salesforce/apex/wildPkmnCreator.generateWildPkmnBattle'

export default class WorldMap extends NavigationMixin(LightningElement) {

    background = worldMap;
    biomeList = ['Canyons', 'Ocean', 'Grasslands','Forest', 'Mountains', 'Beach']
    biome;
    battleId;
    battleUrl;

    
    get backgroundImage(){    
        return `background-image:url("${this.background}")`;
    }

    connectedCallback(){
        console.log('Background: '+ this.background)
        console.log('Background Img: '+ this.backgroundImage)

        document.getElementById("background").style.backgroundImage=`url(${background})`;
    }


    handleClick(event){
        this.biome = event.target.value
        console.log('Biome: ' + this.biome)
        
        wildPkmnCreator({
            biome: this.biome
        })
        .then((result) => {
            
            //navigate to battle page
            this.battleId = result
            console.log('Battle Id: ' + this.battleId)

            //navigates to newly created battle page
            this.navigateToBattlePage();
        })  
        .catch((error) => {
            console.log(error)
        })
    }

    //function for navigating to battle page
    navigateToBattlePage(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.battleId,
                objectApiName: 'Battle__c',
                actionName: 'view'
            }
        })
    }
}