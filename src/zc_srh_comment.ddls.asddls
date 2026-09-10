@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service Request Comment Consumption'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_SRH_COMMENT
  as projection on ZI_SRH_COMMENT
{
  key CommentUuid,
      RequestUuid,
      CommentText,
      CreatedBy,
      CreatedAt,

      _Request : redirected to parent ZC_SRH_REQUEST
}
