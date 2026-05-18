// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SfdcPartnerSbscrOffer {
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
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global String PartnerOrg;
    global String PartnerCompanyName;
    global String CustomerName;
    global String OfferType;
    global String TermsAndConditions;
    global String Status;
    /* Term duration, with a max of 12 months.
    */
    global Integer ContractTerm;
    global Date ServiceStartDate;
    global Date ServiceEndDate;
    global String CustBillingStreet;
    global String CustBillingCity;
    global String CustBillingState;
    global String CustBillingPostalCode;
    global String CustBillingCountry;
    global Double CustBillingLatitude;
    global Double CustBillingLongitude;
    global String CustBillingGeocodeAccuracy;
    global Address CustBillingAddress;
    global String CustShippingStreet;
    global String CustShippingCity;
    global String CustShippingState;
    global String CustShippingPostalCode;
    global String CustShippingCountry;
    global Double CustShippingLatitude;
    global Double CustShippingLongitude;
    global String CustShippingGeocodeAccuracy;
    global Address CustShippingAddress;
    /* Recipient of the invoice and a copy of the offer. Typically, this person is in the finance department.
    */
    global String CustomerBillingEmailAddress;
    /* The subtotal of the offer, excluding applicable taxes.
    */
    global Decimal SubTotal;
    global String CustomerPurchaseOrderNumber;
    /* Offer Recipient who can approve or reject the offer.
    */
    global String CustomerEmailAddress;
    /* Represents the number of days before the service date that an invoice is sent to the customer.
    */
    global Integer OrderPrebillDays;
    global String BillingFrequency;
    global String PaymentMethod;
    global Date ExpirationDate;
    /* Indicates that the customer has 30 days from the invoice date to pay for services.
    */
    global String CustomerPaymentTerms;
    global Datetime SyncToPboLastUpdate;
    global String SyncToPboStatus;
    global String PartnerOffer;
    global User RespondingUser;
    global Id RespondingUserId;
    global Double ServiceTerm;
    global String SyncToPboError;
    global List<ApprovalSubmission> ApprovalSubmissions;
    global List<ApprovalWorkItem> ApprovalWorkItems;
    global List<FlowOrchestrationWorkItem> FlowOrchestrationWorkItems;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<SfdcPartnerSbscrOfferHistory> Histories;
    global List<SfdcPartnerSbscrOfferItem> PartnerSubscriberOfferItems;
    global List<SfdcPartnerSbscrOfferShare> Shares;
    global List<FlowExecutionErrorEvent> ContextRecord;
    global List<FlowRecordRelation> RelatedRecord;
    global List<ProcessInstanceChangeEvent> TargetObject;

    global SfdcPartnerSbscrOffer () 
    {
    }
}