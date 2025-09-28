@EndUserText.label: 'Flight Connections'
-- DCL
@AccessControl.authorizationCheck: #NOT_REQUIRED
-- Metadata
@Metadata:{
 allowExtensions: true,
 ignorePropagatedAnnotations: true
}
-- Data Model
//@VDM.viewType: #CONSUMPTION
-- Performance
@ObjectModel.usageType:{
    serviceQuality: #C,
    dataClass: #MASTER,
    sizeCategory: #L
}
-- Visual Key
@ObjectModel.semanticKey: ['ConnectionID','DepartureAirport','DestinationAirport']
-- Enable Fuzzy Search
@Search.searchable: true
-- Header Info (List and Object Page)
@UI.headerInfo: { typeName: 'Flight Connection',
                  typeNamePlural: 'Flight Connections',
                  imageUrl: 'ImageUrl',
                  title:{ value: 'ConnectionID', type: #STANDARD }
                  //description: { value: '_Airline.Name', type: #STANDARD }
                  }
define view entity ZVKS_C_Connection
  as select from /DMO/I_Connection
  association [0..*] to ZVKS_C_Flight             as _Flight             on  $projection.AirlineID    = _Flight.AirlineID
                                                                         and $projection.ConnectionID = _Flight.ConnectionID

  association [1..1] to ZVKS_C_DepartureAirport   as _DepartureAirport   on  $projection.DepartureAirport = _DepartureAirport.AirportID
  association [1..1] to ZVKS_C_DestinationAirport as _DestinationAirport on  $projection.DestinationAirport = _DestinationAirport.AirportID

  //      _DepartureAirport,
  //      _DestinationAirport
{
      //Airport Addresses in Header using  TYPE #ADDRESS...
      @UI.facet: [

      /* Object Page Header */

          -- Field Group Reference
        {
            label           : 'Airport Details',
            purpose         : #HEADER,
            type            : #FIELDGROUP_REFERENCE,
            position        : 10,
            targetQualifier : 'tqAirportDetailsHeader'
        },

        -- Data Points
        {
            purpose         : #HEADER,
            type            : #DATAPOINT_REFERENCE,
            targetQualifier : 'tqDepartureTime',
            position        : 20
        },
        {
            purpose         : #HEADER,
            type            : #DATAPOINT_REFERENCE,
            targetQualifier : 'tqArrivalTime',
            position        : 30
        },
        {
            purpose         : #HEADER,
            type            : #DATAPOINT_REFERENCE,
            targetQualifier : 'tqDistance',
            position        : 40
        },

      /* Object Page Content */

        -- Collection and Field Group Reference
        {
            label: 'Airport Details',
            purpose: #STANDARD,
            type: #COLLECTION,
            position: 10,
            id: 'idAdditionalData'
        },
            {
                label: 'From Airport',
                purpose: #STANDARD,
                type: #COLLECTION,
                position: 10,
                parentId: 'idAdditionalData',
                id: 'idFromAirport'
            },
                {
                    purpose: #STANDARD,
                    position: 10,
                    type: #FIELDGROUP_REFERENCE,
                    parentId: 'idFromAirport',
                    targetQualifier: 'tqFromAirport',
                    targetElement: '_DepartureAirport'
                },
            {
                label: 'Airport To',
                purpose: #STANDARD,
                type: #COLLECTION,
                position: 20,
                parentId: 'idAdditionalData',
                id: 'idAirportTo'
            },
                {
                    purpose: #STANDARD,
                    position: 10,
                    type: #FIELDGROUP_REFERENCE,
                    parentId: 'idAirportTo',
                    targetQualifier: 'tqAirportTo',
                    targetElement: '_DestinationAirport'
                },

      /* Object Page Facets */

        -- Line Item
        {
            label           : 'Flights',
            purpose         : #STANDARD,
            type            : #LINEITEM_REFERENCE,
            position        : 20,
            targetElement   : '_Flight',
            id              : 'idFlight'
        }

          -- Identification Facet

        -- Line Item Facet
      //        {
      //            id              : 'idItemFlight',
      //            purpose         : #STANDARD,
      //            type            : #LINEITEM_REFERENCE,
      //            label           : 'Connections',
      //            position        : 30,
      //            targetElement   : '_Connection'
      //        }

      ]

      //      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.7}
      //      @UI:{ lineItem: [ { position: 10 }],
      //            identification:[ { position: 10 }],
      //            fieldGroup: [{ qualifier: 'tqHeaderFacetWithoutSubGroups', position: 10 },
      //                         { qualifier: 'tqHeaderKey', position: 10 }]}
      @ObjectModel.text.association: '_Airline'
  key AirlineID,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.7}
      @UI:{ lineItem: [ { position: 20 }],
            identification:[ { position: 20 }]
      //            dataPoint: { qualifier: 'tqConnection', title: 'Connection ID' },
      //            fieldGroup: [{ qualifier: 'tqHeaderFacetWithoutSubGroups', position: 20 },
      //                         { qualifier: 'tqHeaderKey', position: 20 }]
                         }
      @EndUserText:{ label: 'Connection ID', quickInfo: 'Connection ID' }
  key ConnectionID,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.7}
      @UI:{ lineItem: [ { position: 30, importance: #LOW }],
            selectionField: [{ position: 10 }],
            identification:[ { position: 30 }],
            fieldGroup: [{ qualifier: 'tqAirportDetailsHeader', position: 10 },
                         { qualifier: 'tqHeaderFacetWithoutSubGroups', position: 30 }
                         //{ qualifier: 'tqAirportDetails', position: 10 }
                         ]}
      @Consumption.valueHelpDefinition: [
      { entity: {name: '/DMO/I_Airport_StdVH', element: 'AirportID' }, useForValidation: true }]
      @EndUserText:{ label: 'From Airport', quickInfo: 'From Airport' }
      @ObjectModel.text.association: '_DepartureAirport'
      DepartureAirport,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.7}
      @UI:{ lineItem: [ { position: 40, importance: #LOW }],
            selectionField: [{ position: 20 }],
            identification:[ { position: 40 }],
            fieldGroup: [{ qualifier: 'tqAirportDetailsHeader', position: 20 },
                         { qualifier: 'tqHeaderFacetWithoutSubGroups', position: 40 }
                         //{ qualifier: 'tqAirportDetails', position: 20 }
                         ]}
      @Consumption.valueHelpDefinition: [
      { entity: {name: '/DMO/I_Airport_StdVH', element: 'AirportID' }, useForValidation: true }]
      @EndUserText:{ label: 'Airport To', quickInfo: 'Airport To' }
      @ObjectModel.text.association: '_DestinationAirport'
      DestinationAirport,

      @UI:{ lineItem: [{ position: 50, criticality: 'DepartureTimeCriticality', criticalityRepresentation: #WITHOUT_ICON }],
            dataPoint: { qualifier: 'tqDepartureTime', title: 'Departure Time', criticality: 'DepartureTimeCriticality' },
            identification:[ { position: 50 }],
            fieldGroup: [{ qualifier: 'tqHeaderFacetWithoutSubGroups', position: 50 },
                         { qualifier: 'tqTimingDetails', position: 10 }]}
      @EndUserText:{ label: 'Departure Time', quickInfo: 'Departure Time' }
      DepartureTime,

      @UI:{ lineItem: [ { position: 60, criticality: 'ArrivalTimeCriticality', criticalityRepresentation: #WITHOUT_ICON }],
            dataPoint: { qualifier: 'tqArrivalTime', title: 'Arrival Time', criticality: 'ArrivalTimeCriticality' },
            identification:[ { position: 60 }],
            fieldGroup: [{ qualifier: 'tqHeaderFacetWithoutSubGroups', position: 60 },
                         { qualifier: 'tqTimingDetails', position: 20 }]}
      @EndUserText:{ label: 'Arrival Time', quickInfo: 'Arrival Time' }
      ArrivalTime,

      @UI:{ dataPoint: { qualifier: 'tqDistance', title: 'Distance'},
            lineItem: [ { position: 70 }],
            identification:[ { position: 70 }],
            fieldGroup: [{ qualifier: 'tqHeaderFacetWithoutSubGroups', position: 70 }]}
      @EndUserText:{ label: 'Distance', quickInfo: 'Distance' }
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      cast( Distance as abap.quan(14,2) ) as Distance, -- Fixing data element issue (missing decimal values)

      @UI:{ lineItem: [{ position: 01, importance: #LOW, label: 'Connection' }] }
      @Semantics.imageUrl: true
      'sap-icon://journey-change'         as ImageUrl,

      1                                   as DepartureTimeCriticality, //Red
      3                                   as ArrivalTimeCriticality,   //Green

      /* UoM or Currency Codes */
      DistanceUnit,

      /* Associations */
      _Airline,
      _Flight,
      _DepartureAirport,
      _DestinationAirport
}
