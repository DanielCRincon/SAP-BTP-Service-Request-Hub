@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service Request Category Consumption'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

define view entity ZC_SRH_CATEGORY
  as select from ZI_SRH_CATEGORY
{
  key CategoryUUID,
      CategoryCode,
      CategoryName,
      Description,
      RequiresApproval,
      DefaultPriority,
      IsActive
}
