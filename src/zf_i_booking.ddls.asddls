@AbapCatalog.sqlViewName: 'ZF_I_BOOKINGS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking Interface View'
define view ZF_I_BOOKING
  as select from sbook
  association [1] to ZF_I_FLIGHT as _flight on  $projection.Carrid = _flight.Carrid
                                            and $projection.Connid = _flight.Connid
                                            and $projection.Fldate = _flight.Fldate
{
  key carrid     as Carrid,
  key connid     as Connid,
  key fldate     as Fldate,
  key bookid     as Bookid,
      customid   as Customid,
      custtype   as Custtype,
      smoker     as Smoker,
      luggweight as Luggweight,
      wunit      as Wunit,
      invoice    as Invoice,
      class      as Class,
      forcuram   as Forcuram,
      forcurkey  as Forcurkey,
      loccuram   as Loccuram,
      loccurkey  as Loccurkey,
      order_date as Order_date,
      counter    as Counter,
      agencynum  as Agencynum,
      cancelled  as Cancelled,
      reserved   as Reserved,
      passname   as Passname,
      passform   as Passform,
      passbirth  as Passbirth,

      _flight
}
