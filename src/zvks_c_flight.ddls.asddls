@EndUserText.label: 'Flights'
-- DCL
@AccessControl.authorizationCheck: #NOT_REQUIRED
-- Metadata
@Metadata:{
 allowExtensions: true,
 ignorePropagatedAnnotations: true
}
-- Data Model
@VDM.viewType: #CONSUMPTION
-- Performance
@ObjectModel.usageType:{
    serviceQuality: #C,
    dataClass: #MASTER,
    sizeCategory: #L
}
-- Visual Key
@ObjectModel.semanticKey: ['FlightDate']
-- Enable Fuzzy Search
@Search.searchable: true
-- Header Info (List and Object Page)
@UI.headerInfo: { typeName: 'Flight',
                  typeNamePlural: 'Flights',
                  imageUrl: 'ImageUrl',
                  title:{ value: 'ConnectionID', type: #STANDARD },
                  description: { value: 'FlightDate', type: #STANDARD }
                  }
-- Chart
//@UI.chart: [
//  //Radial Micro Chart
//  {
//    qualifier: 'tqRadialChart',
//    title: 'Radial Micro Chart',
//    chartType: #DONUT,
//    measures: ['RadialChartValue'],
//    measureAttributes: [
//      {
//        measure: 'RadialChartValue',
//        role: #AXIS_1,
//        asDataPoint: true
//      }
//    ]
//  },
//  //Harvey Micro Chart
//  {
//    qualifier: 'tqHarveyChart',
//    title: 'Harvey Micro Chart',
//    chartType: #PIE,
//    measures: ['HarveyChartValue'],
//    measureAttributes: [
//      {
//        measure: 'HarveyChartValue',
//        role: #AXIS_1,
//        asDataPoint: true
//      }
//    ]
//  }
//]
define view entity ZVKS_C_Flight
  as select from /DMO/I_Flight
  //[0..*] is mandatory for chart to work
  association [0..*] to ZVKS_C_FlightChart as _FlightChart on  $projection.AirlineID    = _FlightChart.AirlineID
                                                           and $projection.ConnectionID = _FlightChart.ConnectionID
                                                           and $projection.FlightDate   = _FlightChart.FlightDate

{
      @UI.facet: [

      /* Object Page Header */

          -- Field Group Reference
        {
            purpose         : #HEADER,
            type            : #DATAPOINT_REFERENCE,
            targetQualifier : 'OccupiedSeats', --Should be same as the field name to enable in list item
            position        : 10
        },

      /* Object Page Content */

          -- Identification
        {
            label           : 'General Information',
            purpose         : #STANDARD,
            type            : #IDENTIFICATION_REFERENCE,
            position        : 10
        },
        {
            label: 'Demo Chart', -- {@i18n>@SalesData}
            type: #CHART_REFERENCE,
            purpose: #STANDARD,
            position        : 20,
            targetElement: '_FlightChart',
            id : 'idChart',
            targetQualifier: 'tqDemoChart'
        }
      ]

      @ObjectModel.text.association: '_Airline'
  key AirlineID,

      @ObjectModel.text.association: '_Connection'
  key ConnectionID,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.7}
      @UI:{ lineItem: [{ position: 10 }] }
  key FlightDate,

      @UI:{ lineItem: [{ position: 20 }],
            identification: [{ position: 10 }] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,

      @UI:{ lineItem: [{ position: 30 }],
            identification: [{ position: 20 }] }
      PlaneType,

      @UI:{ identification: [{ position: 30 }] }
      MaximumSeats,

      @UI:{ dataPoint:{ title: 'Booking Progress', qualifier: 'OccupiedSeats', targetValueElement: 'MaximumSeats', visualization: #PROGRESS, criticality: 'OccupiedSeatsCriticality' },
            lineItem: [ { position: 60, type: #AS_DATAPOINT, label: 'Booking Progress', cssDefault.width: '30em' }],
            identification: [{ position: 40 }] }
      OccupiedSeats,

      @UI:{ lineItem: [{ position: 01, importance: #LOW, label: 'Flight' }] }
      @Semantics.imageUrl: true
      'sap-icon://flight' as ImageUrl,

      3                   as OccupiedSeatsCriticality, //Green

      /* UoM or Currency Codes */
      CurrencyCode,

      /* Associations */
      _Airline,
      _Connection,
      _Currency,
      _FlightChart
}
