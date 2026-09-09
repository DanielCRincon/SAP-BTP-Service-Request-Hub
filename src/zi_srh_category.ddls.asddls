@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service Request Category Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_SRH_CATEGORY as select from zsrh_category
{
	key category_uuid     as CategoryUUID,
    category_code     as CategoryCode,
    category_name     as CategoryName,
    description       as Description,
    requires_approval as RequiresApproval,
    default_priority  as DefaultPriority,
    is_active         as IsActive
}
