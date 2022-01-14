@AbapCatalog.sqlViewName: 'ZFIFLITP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Business Object View'
@ObjectModel: {
    modelCategory: #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'sflight',
    semanticKey: ['Carrid', 'Connid', 'Fldate'],
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZF_I_FLIGHTTP as select from ZF_I_FLIGHT 
  association [*] to ZF_I_BOOKINGTP as _booking on  $projection.Carrid = _booking.Carrid
                                              and $projection.Connid = _booking.Connid
                                              and $projection.Fldate = _booking.Fldate
{
    key Carrid,
    key Connid,
    key Fldate,
    Price,
    Currency,
    Planetype,
    Seatsmax,
    Seatsocc,
    ZF_I_FLIGHT.Seatsmax_B,
    ZF_I_FLIGHT.Seatsocc_B,
    ZF_I_FLIGHT.Seatsmax_F,
    ZF_I_FLIGHT.Seatsocc_F,
    Paymentsum,
    /* Associations */
    @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
    _booking
}
