//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Chart'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
@UI.chart: [
    {   qualifier: 'tqDemoChart',
        chartType: #COLUMN, // Example: #COLUMN, #LINE, #DONUT, etc.
        title: 'Sales by Product',
        description: 'Total sales volume per product',
        dimensions: ['FlightDate'],
        measures: ['MaximumSeats']
    }
]
define view entity ZVKS_C_FlightChart
  as select from ZVKS_C_Flight
{
  key AirlineID,
  key ConnectionID,
  key FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      PlaneType,
      @Aggregation.default: #SUM
      MaximumSeats,
      @Aggregation.default: #SUM
      OccupiedSeats,
      ImageUrl,
      OccupiedSeatsCriticality,
      CurrencyCode,
      /* Associations */
      _Airline,
      _Connection,
      _Currency
}
