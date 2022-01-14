class ZCL_F_A_CANCEL_BOOKING definition
  public
  inheriting from /BOBF/CL_LIB_A_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_ACTION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_F_A_CANCEL_BOOKING IMPLEMENTATION.


  method /BOBF/IF_FRW_ACTION~EXECUTE.

  DATA g_bookings TYPE ztfibookingtp1.

	io_read->retrieve(
    EXPORTING
      iv_node        = zif_f_i_flighttp_c=>sc_node-zf_i_bookingtp
      it_key         = it_key
    IMPORTING
      et_data = g_bookings ).

    LOOP AT g_bookings REFERENCE INTO data(g_booking).
        IF g_booking->fldate > sy-datum.
            g_booking->cancelled = abap_true.

            io_modify->update(
              EXPORTING
                iv_node = zif_f_i_flighttp_c=>sc_node-zf_i_bookingtp
                iv_key  = g_booking->key
                is_data = g_booking
            ).
        ENDIF.
    ENDLOOP.
  endmethod.
ENDCLASS.
