import { LightningElement, wire, track } from 'lwc';
import {getRelatedListRecords} from 'lightning/uiRelatedListApi'
import TMDiscImg from '@salesforce/resourceUrl/TMDisc';
import Id from "@salesforce/user/Id";
import getAvailableMoves from '@salesforce/apex/pokeAPIMoveService.makeCallout'
import createMoves from '@salesforce/apex/moveTrainerController.createMoves'
import deleteMoves from '@salesforce/apex/moveTrainerController.deleteMoves'
import getCurrentMoves from '@salesforce/apex/moveTrainerController.getMoves'
import { RefreshEvent } from 'lightning/refresh'
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//Can only teach moves to pokemon in your party
const pkmnFilter = {
    criteria: [
        {
            fieldPath: 'Owner__c',
            operator: 'eq',
            value: Id
        }
    ]
}
const displayInfo = {additionalFields: ['Pokemon_Name__c']}
const matchingInfo = {primaryField: {fieldPath: 'Pokemon_Name__c'}}
const currentMoveTableColumns = [
    {label: 'Move', fieldName: 'Move__c'},
    {label: 'Type', fieldName: 'Type__c'},
    {label: 'Power', fieldName: 'Power__c'},
]
const availableMoveTableColumns = [
    {label: 'Move', fieldName: 'Name'},
    {label: 'Type', fieldName: 'Type__c'},
    {label: 'Category', fieldName: 'Category__c'},
    {label: 'Accuracy', fieldName: 'Accuracy__c'},
    {label: 'PP', fieldName: 'PP__c'},
    {label: 'Power', fieldName: 'Power__c'},
]

export default class MoveTrainer extends LightningElement {
    TMDiscImg = TMDiscImg
    pkmnId;
    //'a023t00000iQlb1AAC'
    
    //datatable information
    currentMoves;
    currentMoveTableColumns = currentMoveTableColumns;
    availableMoveTableColumns = availableMoveTableColumns
    displayInfo = displayInfo
    matchingInfo = matchingInfo
    
    selectedCurrentMoves;
    selectedAvailableMoves;
    availableMovesToDisplay;
    availableMoves;
    currentPage = 1;

    //used for pagination
    availMoveStartIdx = 0
    availMoveEndIdx = 15
    recordsPerPage = 15
    maxPages;

    isLoading = false;
    
    //API call to get all available moves
    @wire(getAvailableMoves, {pokemonId: '$pkmnId'})
    handleAvailableMoves({error, data}){
        if(data){
            this.availableMoves = data;
            this.availableMovesToDisplay = data.slice(0,15);
            this.maxPages = Math.ceil(this.availableMoves.length/this.recordsPerPage);
            console.log("Max Pages: ",this.maxPages);
        } else if (error){
            console.error(error);
        }
    }
        

    // Handle lookup field change
    handleLookupChange(event){
        this.isLoading = true;
        
        this.pkmnId = event.detail.recordId
        this.currentPage = 1
        this.handleGetCurrentMoves()

        if(this.pkmnId === null){
            this.availableMovesToDisplay = null
        }
    }

    handleCurrentMoveSelection(event){
        this.selectedCurrentMoves = this.template.querySelector('.currentMoves').getSelectedRows().map(move => move.Id);
        console.log(this.selectedCurrentMoves);
    }

    handleAvailableMoveSelection(event){
        this.selectedAvailableMoves = this.template.querySelector('.availableMoves').getSelectedRows().map(move => move.Id);
        
        console.log(this.selectedAvailableMoves);
    }

    handleMoveDelete(){
        this.isLoading = true;
        
        //might need to do something here to prevent action if selected rows is empty
        deleteMoves({ids: this.selectedCurrentMoves})
            .then(result => {
                
                console.log('Moves Deleted');
                const deleteMessage = new ShowToastEvent({
                    title: 'Move(s) successfully deleted!',
                    variant: 'success',
                })
                this.dispatchEvent(deleteMessage);
                this.handleGetCurrentMoves()
            })
            .catch(error => {
                console.log('Error Occurred Deleting Moves');
                const moveDeleteErrorMessage = new ShowToastEvent({
                    title: 'Error Occurred Deleting Moves',
                    variant: 'error'
                })
                this.dispatchEvent(moveDeleteErrorMessage)
            })
            .finally(()=>{
                this.isLoading = false;
            })
        
    }

    handleMoveCreate(){
        this.isLoading = true;
        
        createMoves({ids: this.selectedAvailableMoves, pkmnId: this.pkmnId})
            .then(result => {
                console.log('Moves Created');
                //this.dispatchEvent(new RefreshEvent());
                const createMessage = new ShowToastEvent({
                    title: 'Move(s) successfully created!',
                    variant: 'success',
                })
                this.dispatchEvent(createMessage);
                this.handleGetCurrentMoves()
            })
            .catch(error => {
                console.log('Error Occurred Creating Moves');
                const moveCreateErrorMessage = new ShowToastEvent ({
                    title: 'Error Occurred Creating Moves',
                    variant: 'error'
                })
                this.dispatchEvent(moveCreateErrorMessage)
            })
            .finally(()=>{
                this.isLoading = false;
            })
    }

    handlePageUp(){
        if(this.currentPage < this.maxPages){
            this.currentPage += 1
            this.availMoveStartIdx += this.recordsPerPage
            this.availMoveEndIdx += this.recordsPerPage
            this.availableMovesToDisplay = this.availableMoves.slice(this.availMoveStartIdx, this.availMoveEndIdx)
        }
        
    }

    handlePageDown(){
        if(this.currentPage > 1){
            this.currentPage -= 1
            this.availMoveStartIdx -= this.recordsPerPage
            this.availMoveEndIdx -= this.recordsPerPage
            this.availableMovesToDisplay = this.availableMoves.slice(this.availMoveStartIdx, this.availMoveEndIdx)
        }

        
    }

    handleGetCurrentMoves(){
        getCurrentMoves({pkmnId: this.pkmnId})
            .then(result => {
                console.log('Got Current Moves: ', result);
                this.currentMoves = result.map(move => {
                    return {
                        Id: move.Id,
                        Move__c: move.Move__c,
                        Type__c: move.Type__c,
                        Power__c: move.TM__r.Power__c
                    }
                })
                
                //this.currentMoves = result
            })
            .catch(error => {
                console.log('Error getting current moves: ', error);
            })
            .finally(()=>{
                this.isLoading = false;
            })
        
    }
}