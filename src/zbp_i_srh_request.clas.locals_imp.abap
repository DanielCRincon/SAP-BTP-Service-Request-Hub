CLASS lhc_ZI_SRH_REQUEST DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zi_srh_request RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR zi_srh_request RESULT result.

    METHODS Submit FOR MODIFY
      IMPORTING keys FOR ACTION ZI_SRH_REQUEST~SUBMIT RESULT result.

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

    MODIFY ENTITIES OF ZI_SRH_REQUEST IN LOCAL MODE
      ENTITY ZI_SRH_REQUEST
        UPDATE FIELDS ( Status )
        WITH VALUE #(
          FOR key IN keys
          (
            %tky   = key-%tky
            Status = 'SUBMITTED'
          )
        )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF ZI_SRH_REQUEST IN LOCAL MODE
      ENTITY ZI_SRH_REQUEST
        ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(requests).

    result = VALUE #(
      FOR request IN requests
      (
        %tky   = request-%tky
        %param = request
      )
    ).

  ENDMETHOD.

ENDCLASS.
