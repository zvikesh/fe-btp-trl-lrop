@EndUserText.label: 'Departure Airport'
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
define view entity ZVKS_C_DepartureAirport
  as select from /DMO/I_Airport
{
      @UI:{ fieldGroup: [{ qualifier: 'tqFromAirport', position: 10, label: 'Airport ID' }] }
  key AirportID,

      @Semantics.text: true
      @UI:{ fieldGroup: [{ qualifier: 'tqFromAirport', position: 20, label: 'Airport Name' }] }
      Name as AirportName,

      @UI:{ fieldGroup: [{ qualifier: 'tqFromAirport', position: 30, label: 'City' }] }
      City,

      @UI:{ fieldGroup: [{ qualifier: 'tqFromAirport', position: 40, label: 'Country Code' }] }
      CountryCode,

      /* Associations */
      _Country
}
