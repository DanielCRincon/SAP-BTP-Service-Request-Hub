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
      Title,
      Description,
      CategoryUuid,
      Priority,
      Requester,
      Assignee,
      Status,
      SystemName,
      AccessType,
      BusinessJustification,
      TargetDate,
      Resolution,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      TotalLastChangedAt
}
