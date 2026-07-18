import { createElement } from 'lwc';
import battleMoveSelectorComponent from 'c/battleMoveSelector';

describe('battleMoveSelector Test Suite', ()=>{

    beforeEach(()=>{
        const battleMoveSelector = createElement('c-battle-move-selector', {
            is: battleMoveSelectorComponent
        });
        document.body.appendChild(battleMoveSelector);
    })

    test('sets the pkmnName and moveList public properties', () => {
        const battleMoveSelector = document.querySelector('c-battle-move-selector')

        battleMoveSelector.pkmnName = 'Pikachu';
        battleMoveSelector.moveList = [{ Id: '001', Name__c: 'Thunderbolt' }];

        expect(battleMoveSelector.pkmnName).toBe('Pikachu');
        expect(battleMoveSelector.moveList).toEqual([
            { Id: '001', Name__c: 'Thunderbolt' }
        ]);
    });

})