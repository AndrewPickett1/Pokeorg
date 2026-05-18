// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ConvMessageSendRequest {
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
    global String MessageDefinition;
    global String MessageDefinitionParameters;
    global String RequestType;
    global String RequestStatus;
    global Datetime CompletedDate;
    global Boolean ShouldEnforceChannelConsent;
    global String AllowExistingSessionStatus;
    global Integer TotalMessageCount;
    global Integer PendingMessageCount;
    global String PendingMessageIdentifiers;
    global String PendingMessagingEndUserIds;
    global String PendingMeuPlatformKeys;
    global Integer InProgressMessageCount;
    global String InProgressMessageIdentifiers;
    global String InProgressMessagingEndUserIds;
    global String InProgressMessagingSessionIds;
    global String InProgressMeuPlatformKeys;
    global Integer SuccessMessageCount;
    global String SuccessMessageIdentifiers;
    global String SuccessMeuPlatformKeys;
    global Integer FailedMessageCount;
    global String FailedMessageIdentifiers;
    global String FailedMeuPlatformKeys;
    global String FailedMessageErrorReasons;
    global String RequestConsentType;
    global CommSubscription CommSubscription;
    global Id CommSubscriptionId;
    global String SessionLongevityPreference;
    global List<FlowExecutionErrorEvent> ContextRecord;
    global List<FlowRecordRelation> RelatedRecord;

    global ConvMessageSendRequest () 
    {
    }
}