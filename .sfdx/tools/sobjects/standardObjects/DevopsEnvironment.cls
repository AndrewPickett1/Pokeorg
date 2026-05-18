// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class DevopsEnvironment {
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
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global Boolean CanTrackChanges;
    global Boolean IsExpired;
    global Integer LastRevisionCounter;
    global String NamedCredential;
    global String OrgIdentifier;
    global Datetime RefreshDate;
    global DevopsEnvironment RefreshSource;
    global Id RefreshSourceId;
    global Boolean IsTestEnvironment;
    global Boolean IsDevEnvironment;
    global String OrgType;
    global String OrgUrl;
    global DevopsEnvironment Replaces;
    global Id ReplacesId;
    global String DoceHubType;
    global Boolean IsVibeEnvironment;
    global List<ActivityHistory> ActivityHistories;
    global List<ApprovalSubmission> ApprovalSubmissions;
    global List<ApprovalWorkItem> ApprovalWorkItems;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<Attachment> Attachments;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DevopsEnvironment> RefreshSources;
    global List<DevopsEnvironment> Replaces;
    global List<DevopsEnvironmentFeed> Feeds;
    global List<DevopsEnvironmentHistory> Histories;
    global List<DevopsEnvironmentShare> Shares;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<FlowOrchestrationWorkItem> FlowOrchestrationWorkItems;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<Task> Tasks;
    global List<ContentDocumentLinkChangeEvent> LinkedEntity;
    global List<ContentVersion> FirstPublishLocation;
    global List<EmailMessageChangeEvent> RelatedTo;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowExecutionErrorEvent> ContextRecord;
    global List<FlowRecordRelation> RelatedRecord;
    global List<OutgoingEmail> RelatedTo;
    global List<ProcessInstanceChangeEvent> TargetObject;
    global List<TaskChangeEvent> What;

    global DevopsEnvironment () 
    {
    }
}