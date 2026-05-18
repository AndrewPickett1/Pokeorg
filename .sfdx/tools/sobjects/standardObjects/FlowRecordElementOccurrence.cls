// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class FlowRecordElementOccurrence {
    global Id Id;
    global Boolean IsDeleted;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global FlowRecordVersionOccurrence FlowRecordVersionOccurrence;
    global Id FlowRecordVersionOccurrenceId;
    global FlowRecord FlowRecord;
    global Id FlowRecordId;
    global FlowRecordVersion FlowRecordVersion;
    global Id FlowRecordVersionId;
    global FlowRecordElement FlowRecordElement;
    global Id FlowRecordElementId;
    global List<FlowExecutionErrorEvent> ContextRecord;
    global List<FlowRecordRelation> RelatedRecord;

    global FlowRecordElementOccurrence () 
    {
    }
}