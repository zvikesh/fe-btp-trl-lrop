@EndUserText.label: 'Destination Airport'
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
define view entity ZVKS_C_DestinationAirport
  as select from /DMO/I_Airport
{
      @UI:{ fieldGroup: [{ qualifier: 'tqAirportTo', position: 10, label: 'Airport ID' }] }
  key AirportID,

      @Semantics.text: true
      @UI:{ fieldGroup: [{ qualifier: 'tqAirportTo', position: 20, label: 'Airport Name' }] }
      Name as AirportName,

      @UI:{ fieldGroup: [{ qualifier: 'tqAirportTo', position: 30, label: 'City' }] }
      City,

      @UI:{ fieldGroup: [{ qualifier: 'tqAirportTo', position: 40, label: 'Country Code' }] }
      CountryCode,

      /* Associations */
      _Country
}
