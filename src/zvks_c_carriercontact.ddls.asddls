@EndUserText.label: 'Airline Carrier Contact'
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
define view entity ZVKS_C_CarrierContact
  as select from ZVKS_R_CarrierContact
{
  key AirlineID,
  key ContactID,

      @Semantics.name.fullName: true
      @UI: { fieldGroup: [{ qualifier: 'tqAirlineContact', position: 10, label: 'Airline Name'},
      { qualifier: 'tqAirlineOverview', position: 10, label: 'Airline ID' }] }
      cast( concat_with_space(FirstName,LastName,1) as abap.char(100) ) as FullName,

      @Semantics.address.street: true
      @UI: { fieldGroup: [{ qualifier: 'tqAirlineContact', position: 20, label: 'Street'}] }
      Street,

      @Semantics.address.zipCode: true
      @UI: { fieldGroup: [{ qualifier: 'tqAirlineContact', position: 30, label: 'Postal Code'}] }
      PostalCode,

      @Semantics.address.city: true
      @UI: { fieldGroup: [{ qualifier: 'tqAirlineContact', position: 40, label: 'City'}] }
      City,

      @Semantics.address.country: true
      @EndUserText.label: 'Country'
      @UI: { fieldGroup: [{ qualifier: 'tqAirlineContact', position: 50, label: 'Country Code'}] }
      CountryCode,

      @Semantics.telephone.type: [ #CELL,#WORK ]
      @UI: { fieldGroup: [{ qualifier: 'tqAirlineContact', position: 60, label: 'Phone Number'}] }
      PhoneNumber,

      @Semantics.eMail.address: true
      @Semantics.eMail.type: [ #WORK ]
      @UI: { fieldGroup: [{ qualifier: 'tqAirlineContact', position: 70, label: 'Email Address'}] }
      EmailAddress,

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
      LastChangedAt
}
