@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service Request History Consumption'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_SRH_HISTORY
  as projection on ZI_SRH_HISTORY
{
  key HistoryUuid,
      RequestUuid,
      OldStatus,
      NewStatus,
      ActionCode,
      ChangedBy,
      ChangedAt,

      _Request : redirected to parent ZC_SRH_REQUEST
}
