// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ConversationApiLog {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
    global Boolean IsDeleted;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global User RequestedBy;
    global Id RequestedById;
    global Datetime RequestedDate;
    global String RequestedEntityType;
    global String RequestedEntityIdentifier;
    global String Action;
    global String Operation;
    global String Status;
    global String Parameter;
    global String StatusHistory;
    global String Context;
    global List<ApprovalSubmission> ApprovalSubmissions;
    global List<ApprovalWorkItem> ApprovalWorkItems;
    global List<ConversationApiLogShare> Shares;
    global List<FlowOrchestrationWorkItem> FlowOrchestrationWorkItems;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<ConversationApiLogObjSum> ConversationApiLog;
    global List<FlowExecutionErrorEvent> ContextRecord;
    global List<FlowRecordRelation> RelatedRecord;
    global List<ProcessInstanceChangeEvent> TargetObject;

    global ConversationApiLog () 
    {
    }
}