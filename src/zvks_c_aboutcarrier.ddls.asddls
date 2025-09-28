@EndUserText.label: 'About Airline Carrier'
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
-- Quick View Header
@UI.headerInfo: {
  typeName: 'About Airline',
  typeNamePlural: 'About Airline',
  title.value: 'AirlineID',
  description.value: 'AirlineName',
  typeImageUrl: 'sap-icon://paper-plane'
}
-- Semantic Object (May be not needed!!!)
@Consumption.semanticObject: 'SemanticObjectAboutAirline'
define view entity ZVKS_C_AboutCarrier
  as select from ZVKS_R_AboutCarrier
{

      @UI.facet: [
        {
          label: 'Airline Quick View Card',
          purpose: #QUICK_VIEW,
          type: #FIELDGROUP_REFERENCE,
          targetQualifier: 'tqAboutAirlineCard'
        }
      ]

      @UI:{ fieldGroup: [{ qualifier: 'tqAboutAirlineCard', position: 10, label: 'Airline ID' },
                         { qualifier: 'tqAboutAirline', position: 10, label: 'Airline ID' }] }
      @ObjectModel.text.element: [ 'AirlineName' ]
      @UI.textArrangement: #TEXT_ONLY
  key AirlineID,
      _Airline.Name as AirlineName,

      @UI:{ fieldGroup: [{ qualifier: 'tqAboutAirlineCard', position: 20, label: 'Call Sign' },
                         { qualifier: 'tqAboutAirline', position: 20, label: 'Call Sign' }] }
      CallSign,

      @UI:{ fieldGroup: [{ qualifier: 'tqAboutAirlineCard', position: 30, label: 'Founded On' },
                         { qualifier: 'tqAboutAirline', position: 30, label: 'Founded On' }] }
      FoundedOn,

      @UI:{ fieldGroup: [{ qualifier: 'tqAboutAirlineCard', position: 40, label: 'Commenced On' },
                         { qualifier: 'tqAboutAirline', position: 40, label: 'Commenced On' }] }
      CommencedOn,

      @UI:{ fieldGroup: [{ qualifier: 'tqAboutAirlineCard', position: 50, label: 'Website', type: #WITH_URL, url: 'URL' },
                         { qualifier: 'tqAboutAirline', position: 50, label: 'Website', type: #WITH_URL, url: 'URL' }] }
      Website,

      URL,

      /* Admin */

      @Semantics.user.createdBy: true
      CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      CreatedAt,

      @Semantics.user.lastChangedBy: true
      LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true //local ETag field --> OData ETag
      LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      /* Associations */

      _Airline
}
