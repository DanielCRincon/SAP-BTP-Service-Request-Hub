@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service Request Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SRH_REQUEST as select from ZSRH_REQUEST
  association [0..1] to ZI_SRH_CATEGORY as _Category
    on $projection.CategoryUUID = _Category.CategoryUUID

    composition [0..*] of ZI_SRH_COMMENT as _Comments
    composition [0..*] of ZI_SRH_HISTORY as _History
{
	key request_uuid as RequestUuid,
    title as Title,
    description as Description,
    category_uuid as CategoryUuid,
    priority as Priority,
    requester as Requester,
    assignee as Assignee,
    status as Status,
    system_name as SystemName,
    access_type as AccessType,
    business_justification as BusinessJustification,
    target_date as TargetDate,
    resolution as Resolution,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    total_last_changed_at as TotalLastChangedAt,

    _Category,
    _Comments,
    _History
}
