// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class LoginAnomalyEventStore {
    global Id Id;
    global String LoginAnomalyEventNumber;
    global Datetime CreatedDate;
    global Datetime LastModifiedDate;
    global Datetime SystemModstamp;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
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
    global String FeatureName;
    global Double FeatureValue;
    global Double FeatureContribution;
    global String SecurityEventData;
    global String Summary;
    global Double Score;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<LoginAnomalyEventStoreFeed> Feeds;
    global List<ThreatDetectionFeedback> Feedbacks;
    global List<ContentDocumentLinkChangeEvent> LinkedEntity;
    global List<ContentVersion> FirstPublishLocation;
    global List<FeedComment> Parent;
    global List<FlowExecutionErrorEvent> ContextRecord;
    global List<FlowRecordRelation> RelatedRecord;

    global LoginAnomalyEventStore () 
    {
    }
}