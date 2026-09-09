@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service Request Comment Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_SRH_COMMENT as select from ZSRH_COMMENT

  association to parent ZI_SRH_REQUEST as _Request
    on $projection.RequestUUID = _Request.RequestUUID

{
	key comment_uuid as CommentUuid,
    request_uuid as RequestUuid,
    comment_text as CommentText,
    created_by as CreatedBy,
    created_at as CreatedAt,

    _Request
}
