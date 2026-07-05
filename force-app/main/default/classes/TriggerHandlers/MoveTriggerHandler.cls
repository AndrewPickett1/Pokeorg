public class MoveTriggerHandler extends TriggerHandler {
    
    public override void handleBeforeInsert(){
        setDefaultPP();
    }

    public void setDefaultPP(){
        Set<Id> tmIds = new Set<Id>();
        
        for(Move__c move : (List<Move__c>) this.newList){
            tmIds.add(move.TM__c);
        }

        Map<Id, TM__c> tmMap = new Map<Id, TM__c>();
        if(!tmIds.isEmpty()){
            tmMap = new Map<Id, TM__c>([
                SELECT Id, PP__c
                FROM TM__c
                WHERE ID in :tmIds
            ]);
        }

        for(Move__c move : (List<Move__c>) this.newList){
            if(move.PP__c == null && move.TM__c != null){
                move.PP__c = tmMap.get(move.TM__c).PP__c;
                move.Max_PP__c = tmMap.get(move.TM__c).PP__c;
            }
        }
    }
    
    
}