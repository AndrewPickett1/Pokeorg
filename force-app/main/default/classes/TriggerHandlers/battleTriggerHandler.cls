public class battleTriggerHandler extends TriggerHandler {
        
    public override void handleBeforeUpdate(){
        updateVictorOnStatusChange();
        
    }

    public void updateVictorOnStatusChange(){
        List<Battle__c> newList = (List<Battle__c>) this.newList;
            for(Battle__c newBattle : newList){
                Battle__c oldBattle = (Battle__c) this.oldMap.get(newBattle.Id);

                if(newBattle.Status__c != oldBattle.Status__c){
                    if(newBattle.Pokemon_1__r.Current_HP__c > newBattle.Pokemon_2__r.Current_HP__c){
                        newBattle.Victor__c = newBattle.Pokemon_1__c;
                    } else {
                        newBattle.Victor__c = newBattle.Pokemon_2__c;
                    }
                }
            }
    }

}