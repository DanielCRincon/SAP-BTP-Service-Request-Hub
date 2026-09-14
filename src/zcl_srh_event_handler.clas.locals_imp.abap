CLASS lcl_srh_event_handler DEFINITION
  INHERITING FROM cl_abap_behavior_event_handler.

  PRIVATE SECTION.

    METHODS on_request_submitted
      FOR ENTITY EVENT
      IMPORTING submitted_requests
      FOR ZI_SRH_REQUEST~RequestSubmitted.

ENDCLASS.


CLASS lcl_srh_event_handler IMPLEMENTATION.

  METHOD on_request_submitted.

    MODIFY ENTITIES OF ZI_SRH_REQUEST
      ENTITY ZI_SRH_REQUEST
        CREATE BY \_History
        FIELDS ( OldStatus NewStatus ActionCode ChangedBy ChangedAt )
        WITH VALUE #(
          FOR submitted_request IN submitted_requests INDEX INTO idx
          (
            RequestUuid = submitted_request-%key-RequestUuid
            %is_draft   = if_abap_behv=>mk-off

            %target = VALUE #(
              (
                %cid       = |HIST{ idx }|
                OldStatus  = submitted_request-%param-OldStatus
                NewStatus  = submitted_request-%param-NewStatus
                ActionCode = submitted_request-%param-ActionCode
                ChangedBy  = submitted_request-%param-ChangedBy
                ChangedAt  = submitted_request-%param-ChangedAt
              )
            )
          )
        )
      FAILED DATA(failed)
      REPORTED DATA(reported).

  ENDMETHOD.

ENDCLASS.
