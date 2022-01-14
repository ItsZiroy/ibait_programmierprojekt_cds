@AbapCatalog.sqlViewName: 'ZFIBOOKTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking Business Object view'

@ObjectModel: {
    writeActivePersistence: 'sbook',
    semanticKey: ['Carrid', 'Connid', 'Fldate', 'Bookid'],
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZF_I_BOOKINGTP
  as select from ZF_I_BOOKING
  association [1] to ZF_I_FLIGHTTP as _flight on  $projection.Carrid = _flight.Carrid
                                              and $projection.Connid = _flight.Connid
                                              and $projection.Fldate = _flight.Fldate
{
  key Carrid,
  key Connid,
  key Fldate,
  key Bookid,
      Customid,
      Custtype,
      Smoker,
      Luggweight,
      Wunit,
      Invoice,
      Class,
      Forcuram,
      Forcurkey,
      Loccuram,
      Loccurkey,
      Counter,
      Order_date,
      Agencynum,
      Cancelled,
      Reserved,
      Passname,
      Passform,
      Passbirth,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      /* Associations */
      _flight
}
