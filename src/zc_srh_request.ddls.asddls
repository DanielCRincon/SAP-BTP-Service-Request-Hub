@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service Request Consumption'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZC_SRH_REQUEST
  provider contract transactional_query
  as projection on ZI_SRH_REQUEST
{
  key RequestUuid,

      @EndUserText.label: 'Request Title'
      Title,

      @EndUserText.label: 'Description'
      Description,

      @EndUserText.label: 'Category'
      CategoryUuid,

      @EndUserText.label: 'Priority'
      Priority,

      @EndUserText.label: 'Requester'
      Requester,

      @EndUserText.label: 'Assignee'
      Assignee,

      @EndUserText.label: 'Status'
      Status,

      @EndUserText.label: 'System'
      SystemName,

      @EndUserText.label: 'Access Type'
      AccessType,

      @EndUserText.label: 'Business Justification'
      BusinessJustification,

      @EndUserText.label: 'Target Date'
      TargetDate,

      @EndUserText.label: 'Resolution'
      Resolution,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      TotalLastChangedAt,

      _Category,
      _Comments : redirected to composition child ZC_SRH_COMMENT,
      _History  : redirected to composition child ZC_SRH_HISTORY
}
