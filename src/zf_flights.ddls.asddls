@AbapCatalog.sqlViewName: 'ZF_FLIGHT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flights'
@OData.publish: true
@Metadata.allowExtensions: true
@VDM.viewType: #CONSUMPTION
@ObjectModel: {
    updateEnabled: true,
    createEnabled: true,
    deleteEnabled: true,
    transactionalProcessingDelegated: true,
    semanticKey: ['Carrname', 'Connid']
}
define view ZF_FLIGHTS
  as select from ZF_I_FLIGHTTP
  association [*] to ZF_BOOKING    as _booking on  $projection.Carrid = _booking.Carrid
                                               and $projection.Connid = _booking.Connid
                                               and $projection.Fldate = _booking.Fldate
                                               and _booking.Cancelled = ''
  association [1] to ZF_CONNECTION as _con     on  $projection.Connid = _con.Connid
                                               and $projection.Carrid = _con.Carrid
  association [1] to scarr         as _carrier on  $projection.Carrid = _carrier.carrid
{

  key Carrid                                                                                                               as Carrid,
  key Connid                                                                                                               as Connid,
  key Fldate                                                                                                               as Fldate,

      @Semantics.amount.currencyCode: 'CURRENCY'
      Price                                                                                                                as Price,
      @Semantics.currencyCode: true
      Currency                                                                                                             as Currency,
      Planetype                                                                                                            as Planetype,
      Seatsmax                                                                                                             as Seatsmax,
      Seatsocc                                                                                                             as Seatsocc,
      Paymentsum                                                                                                           as Paymentsum,
      @ObjectModel.readOnly: true
      concat_with_space(concat_with_space(_con.Cityfrom, 'to', 1), _con.Cityto, 1)                                         as Title,
      @ObjectModel.readOnly: true
      cast((division((Seatsocc + Seatsocc_B + Seatsocc_F),( Seatsmax + Seatsmax_B + Seatsmax_F ) , 5) * 100) as abap.int4) as Occupancy,
      Seatsmax_B,
      Seatsocc_B,
      Seatsmax_F,
      Seatsocc_F,

      @ObjectModel.readOnly: true
      _carrier.carrname                                                                                                    as Carrname,
      @ObjectModel.readOnly: true
      _con.Airpfrom                                                                                                        as Airpfrom,
      @ObjectModel.readOnly: true
      _con.Airpto                                                                                                          as Airpto,
      @ObjectModel.readOnly: true
      _con.Deptime                                                                                                         as Deptime,
      @ObjectModel.readOnly: true
      _con.Arrtime                                                                                                         as Arrtime,
      @ObjectModel.readOnly: true
      _con.Distance                                                                                                        as FlightDistance,
      @ObjectModel.readOnly: true
      _con.Distid,
      _con, // Make association public

      _booking
}
where
  Fldate > $session.system_date
