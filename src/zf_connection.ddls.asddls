@AbapCatalog.sqlViewName: 'ZF_CONNECTIONS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Connection'
@Metadata.allowExtensions: true
define view ZF_CONNECTION as select from spfli {
    key carrid as Carrid,
    key connid as Connid,
    countryfr as Countryfr,
    cityfrom as Cityfrom,
    airpfrom as Airpfrom,
    countryto as Countryto,
    cityto as Cityto,
    airpto as Airpto,
    fltime as Fltime,
    deptime as Deptime,
    arrtime as Arrtime,
    @Semantics.quantity.unitOfMeasure: 'DISTID'
    distance as Distance,
    @Semantics.unitOfMeasure: true
    distid as Distid,
    fltype as Fltype,
    period as Period
}
