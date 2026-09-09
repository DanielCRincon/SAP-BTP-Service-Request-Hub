@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service Request History Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_SRH_HISTORY as select from ZSRH_HISTORY

  association to parent ZI_SRH_REQUEST as _Request
    on $projection.RequestUUID = _Request.RequestUUID

{
	key history_uuid as HistoryUuid,
    request_uuid as RequestUuid,
    old_status as OldStatus,
    new_status as NewStatus,
    action_code as ActionCode,
    changed_by as ChangedBy,
    changed_at as ChangedAt,

    _Request
}
