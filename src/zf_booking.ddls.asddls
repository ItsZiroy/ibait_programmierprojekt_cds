@AbapCatalog.sqlViewName: 'ZF_BOOKINGS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking'
@Metadata.allowExtensions: true
@VDM.viewType: #CONSUMPTION
@ObjectModel: {
    semanticKey: ['Bookid'],

    updateEnabled: true,
    createEnabled: true,
    deleteEnabled: true
}
define view ZF_BOOKING
  as select from ZF_I_BOOKINGTP
               association [1] to ZF_FLIGHTS as _flight on  $projection.Carrid = _flight.Carrid
                                              and $projection.Connid = _flight.Connid
                                              and $projection.Fldate = _flight.Fldate                           
{
  key ZF_I_BOOKINGTP.Carrid                                as Carrid,
  key ZF_I_BOOKINGTP.Connid                                as Connid,
  key ZF_I_BOOKINGTP.Fldate                                as Fldate,
  key ZF_I_BOOKINGTP.Bookid                                as Bookid,
      Customid                              as Customid,
      Custtype                              as Custtype,
      Smoker                                as Smoker,
      Invoice                               as Invoice,
      @ObjectModel.readOnly: true
      case Class
           when 'Y' then 'Economy'
           when 'C' then 'Business'
           when 'F' then 'First'
           else ''
           end                              as Class,
      @Semantics.amount.currencyCode: 'CURRENCY'
            @ObjectModel.readOnly: true
      currency_conversion(
         amount => Forcuram,
         source_currency => Forcurkey,
         target_currency => cast('USD' as abap.cuky),
         exchange_rate_type => 'M',
         exchange_rate_date => ZF_I_BOOKINGTP.Order_date ) as Price,
      @Semantics.currencyCode: true
       @ObjectModel.readOnly: true
      cast('USD' as abap.cuky)              as currency,
      @Semantics.quantity.unitOfMeasure: 'WUNIT'
      Luggweight                            as Luggweight,
      @Semantics.unitOfMeasure: true
      Wunit                                 as Wunit,
      Counter                               as Counter,
      Agencynum                             as Agencynum,
      @Semantics.booleanIndicator: true
      Cancelled                             as Cancelled,
      Reserved                              as Reserved,
      Passname                              as Passname,
      Passform                              as Passform,
      Passbirth                             as Passbirth,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _flight
}
