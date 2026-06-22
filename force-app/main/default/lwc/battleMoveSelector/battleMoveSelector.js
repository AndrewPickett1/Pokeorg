import { LightningElement, api } from 'lwc';

export default class BattleMoveSelector extends LightningElement {

    @api pkmnName;
    @api moveList;

    @api selectedRecordId;

    get displayedMoves(){
        return this.moveList?.map(move => ({
            ...move,
            isChecked: move.Id == this.selectedRecordId,
            moveCardClass: move.Id == this.selectedRecordId ? 'move-card is-selected' : 'move-card'
        }))
    }

    handleSelection(event){
        this.selectedRecordId = event.target.value;

        console.log('move list: ' + JSON.stringify(this.moveList));

        const moveSelectedEvent = new CustomEvent('moveselected', {detail: {moveId: event.target.value}});
        this.dispatchEvent(moveSelectedEvent);
        
    }

    


}