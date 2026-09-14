@EndUserText.label: 'Request Submitted Event Payload'
define abstract entity ZA_SRH_REQUEST_SUBMITTED
{
  OldStatus  : abap.char(20);
  NewStatus  : abap.char(20);
  ActionCode : abap.char(30);
  ChangedBy  : abp_locinst_lastchange_user;
  ChangedAt  : abp_locinst_lastchange_tstmpl;
}
