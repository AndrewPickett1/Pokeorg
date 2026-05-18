// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class UniversalAnomalyEvent {
    global String ReplayId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global String EventUuid;
    global String EventIdentifier;
    global User User;
    global Id UserId;
    global String Username;
    global Datetime EventDate;
    global String SessionKey;
    global String LoginKey;
    global String SourceIp;
    global TransactionSecurityPolicy Policy;
    global Id PolicyId;
    global String PolicyOutcome;
    global Double EvaluationTime;
    global String Summary;
    global Double Score;
    global String SecurityEventData;
    global String AnomalySubType;
    global List<AsyncOperationEvent> SourceEvent;

    global UniversalAnomalyEvent () 
    {
    }
}