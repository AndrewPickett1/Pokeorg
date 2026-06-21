import { LightningElement, api } from 'lwc';

export default class BattleMoveSelector extends LightningElement {

    @api pkmnName = 'test';
    @api moveList = [
        {Name: 'move1', Id: 1, PP: 5, Type: 'Normal'},
        {Name: 'move2', Id: 2, PP: 5, Type: 'Normal'},
        {Name: 'move3', Id: 3, PP: 5, Type: 'Normal'}
    ];

    @api selectedRecordId;

    get displayedMoves(){
        return this.moveList.map(move => ({
            ...move,
            isChecked: move.Id == this.selectedRecordId,
            moveCardClass: move.Id == this.selectedRecordId ? 'move-card is-selected' : 'move-card'
        }))
    }

    handleSelection(event){
        console.log('Selected Value: ' + event.target.value)
        this.selectedRecordId = event.target.value;
    }

    


}