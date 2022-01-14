@AbapCatalog.sqlViewName: 'ZFIFLIGHTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight interface View'
define view ZF_I_FLIGHT
  as select from sflight
  association [*] to ZF_I_BOOKING as _booking on  $projection.Carrid = _booking.Carrid
                                              and $projection.Connid = _booking.Connid
                                              and $projection.Fldate = _booking.Fldate

{
      key sflight.carrid as Carrid,
      key sflight.connid as Connid,
      key sflight.fldate as Fldate,
      sflight.price as Price,
      sflight.currency as Currency,
      sflight.planetype as Planetype,
      sflight.seatsmax as Seatsmax,
      sflight.seatsocc as Seatsocc,
      sflight.paymentsum as Paymentsum,
      sflight.seatsmax_b as Seatsmax_B,
      sflight.seatsocc_b as Seatsocc_B,
      sflight.seatsmax_f as Seatsmax_F,
      sflight.seatsocc_f as Seatsocc_F,
      _booking
}
