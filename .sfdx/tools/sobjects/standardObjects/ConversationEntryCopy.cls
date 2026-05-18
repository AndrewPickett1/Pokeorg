// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ConversationEntryCopy {
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
    global String ConversationEntryIdentifier;
    global Conversation Conversation;
    global Id ConversationId;
    global ConversationParticipant ConversationParticipant;
    global Id ConversationParticipantId;
    global Datetime ClientTimestamp;
    global Long ClientDuration;
    global Datetime TranscriptedTimestamp;
    global String EntryType;
    global String EntryPayload;
    global String Language;
    global Integer Version;
    global String VisibilityStrategy;
    global List<ApprovalSubmission> ApprovalSubmissions;
    global List<ApprovalWorkItem> ApprovalWorkItems;
    global List<ConversationEntryCopyShare> Shares;
    global List<FlowOrchestrationWorkItem> FlowOrchestrationWorkItems;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<AIInsightValue> SobjectLookupValue;
    global List<AIRecordInsight> Target;
    global List<ConvEntryRelatedRecordCopy> ConversationEntryCopy;
    global List<FlowExecutionErrorEvent> ContextRecord;
    global List<FlowRecordRelation> RelatedRecord;
    global List<ProcessInstanceChangeEvent> TargetObject;

    global ConversationEntryCopy () 
    {
    }
}