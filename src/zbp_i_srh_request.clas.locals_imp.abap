CLASS lhc_ZI_SRH_REQUEST DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zi_srh_request RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR zi_srh_request RESULT result.

    METHODS Submit FOR MODIFY
      IMPORTING keys FOR ACTION ZI_SRH_REQUEST~SUBMIT RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      keys REQUEST requested_features FOR ZI_SRH_REQUEST
      RESULT result.

    METHODS SetInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZI_SRH_REQUEST~SetInitialStatus.

ENDCLASS.

CLASS lhc_ZI_SRH_REQUEST IMPLEMENTATION.

  METHOD get_instance_authorizations.

    result = VALUE #(
      FOR key IN keys
      (
        %tky    = key-%tky
        %update = if_abap_behv=>auth-allowed
        %delete = if_abap_behv=>auth-allowed
      )
    ).

  ENDMETHOD.

  METHOD get_global_authorizations.

    result-%create = if_abap_behv=>auth-allowed.

  ENDMETHOD.

  METHOD Submit.

    READ ENTITIES OF ZI_SRH_REQUEST IN LOCAL MODE
      ENTITY ZI_SRH_REQUEST
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(requests).

    DATA requests_to_update TYPE TABLE FOR UPDATE ZI_SRH_REQUEST.

    LOOP AT requests INTO DATA(request).

      IF request-Status = 'DRAFT'.

        APPEND VALUE #(
          %tky   = request-%tky
          Status = 'SUBMITTED'
        ) TO requests_to_update.

      ELSE.

        APPEND VALUE #(
          %tky = request-%tky
        ) TO failed-zi_srh_request.

        APPEND VALUE #(
          %tky = request-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Only requests in DRAFT status can be submitted'
          )
        ) TO reported-zi_srh_request.

      ENDIF.

    ENDLOOP.

    IF requests_to_update IS NOT INITIAL.

      MODIFY ENTITIES OF ZI_SRH_REQUEST IN LOCAL MODE
        ENTITY ZI_SRH_REQUEST
          UPDATE FIELDS ( Status )
          WITH requests_to_update
        FAILED DATA(failed_update)
        REPORTED DATA(reported_update).

      APPEND LINES OF failed_update-zi_srh_request
        TO failed-zi_srh_request.

      APPEND LINES OF reported_update-zi_srh_request
        TO reported-zi_srh_request.

    ENDIF.

    READ ENTITIES OF ZI_SRH_REQUEST IN LOCAL MODE
      ENTITY ZI_SRH_REQUEST
        ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(requests_result).

    result = VALUE #(
      FOR request_result IN requests_result
      (
        %tky   = request_result-%tky
        %param = request_result
      )
    ).

  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF ZI_SRH_REQUEST IN LOCAL MODE
      ENTITY ZI_SRH_REQUEST
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(requests).

    result = VALUE #(
      FOR request IN requests
      (
        %tky = request-%tky

        %action-Submit = COND #(
          WHEN request-Status = 'DRAFT'
          THEN if_abap_behv=>fc-o-enabled
          ELSE if_abap_behv=>fc-o-disabled
        )
      )
    ).

  ENDMETHOD.

  METHOD SetInitialStatus.

    MODIFY ENTITIES OF ZI_SRH_REQUEST IN LOCAL MODE
      ENTITY ZI_SRH_REQUEST
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          FOR key IN keys
          (
            %tky   = key-%tky
            Status = 'DRAFT'
          )
        ).

  ENDMETHOD.
ENDCLASS.
