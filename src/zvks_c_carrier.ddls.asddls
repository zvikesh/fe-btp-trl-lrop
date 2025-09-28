@EndUserText.label: 'Airline Carriers'
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
@ObjectModel.semanticKey: ['AirlineID','AirlineName']
-- Enable Fuzzy Search
@Search.searchable: true
-- Header Info (List and Object Page)
@UI.headerInfo: { typeName: 'Airline Carrier',                              -- Object Page App Title
                  typeNamePlural: 'Airline Carriers',                       -- List Header
                  imageUrl: 'AirlineLogo',                                  -- Object Page Header
                  title:{ value: 'AirlineID', type: #STANDARD },            -- Object Page Header
                  description: { value: 'AirlineName', type: #STANDARD }    -- Object Page Header
}
define view entity ZVKS_C_Carrier
  as select from /DMO/I_Carrier
  /* Associations */
  association [0..*] to ZVKS_C_Connection     as _Connection     on  $projection.AirlineID = _Connection.AirlineID

  /* Auxiliary */
  association [0..1] to ZVKS_C_CarrierContact as _AirlineContact on  $projection.AirlineID = _AirlineContact.AirlineID
                                                                 and $projection.ContactID = _AirlineContact.ContactID
  association [0..1] to ZVKS_C_AboutCarrier   as _AboutAirline   on  $projection.AirlineID = _AboutAirline.AirlineID
{
      @UI.facet: [

      /* Object Page Header */

          -- Field Group Reference
        {
            label: 'Additional Detials (Cards)',
            purpose: #HEADER,
            type: #FIELDGROUP_REFERENCE,
            position: 10,
            targetQualifier: 'tqAdditionalDetailsCards'
        },
        {
            label: 'Rating',
            purpose: #HEADER,
            type: #DATAPOINT_REFERENCE,
            position: 20,
            targetQualifier: 'AirlineRating'   -- Mandatory to have this same as fieldname, or else ratings doesnot show up in lineitems
        },

      /* Object Page Content */

          -- Identification
        {
            label           : 'General Information',
            purpose         : #STANDARD,
            type            : #IDENTIFICATION_REFERENCE,
            position        : 10
        },

        -- Collection and Field Group Reference
        {
            label           : 'Additional Details',
            purpose         : #STANDARD,
            type            : #COLLECTION,
            position        : 20,
            id              : 'idAdditionalData'
        },
            {
                label           : 'Airline Contact',
                purpose         : #STANDARD,
                type            : #FIELDGROUP_REFERENCE,
                position        : 10,
                parentId        : 'idAdditionalData',
                targetElement   : '_AirlineContact',
                targetQualifier : 'tqAirlineContact'
            },
            {
                label           : 'About Airline',
                purpose         : #STANDARD,
                type            : #FIELDGROUP_REFERENCE,
                position        : 20,
                parentId        : 'idAdditionalData',
                targetElement   : '_AboutAirline',
                targetQualifier : 'tqAboutAirline'
            },

        -- Line Item
        {
            label           : 'Connections',
            purpose         : #STANDARD,
            type            : #LINEITEM_REFERENCE,
            position        : 30,
            targetElement   : '_Connection',
            id              : 'idItemFlight'
        }
      ]

      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      @UI:{ selectionField: [{ position: 10 }],
            lineItem: [{ position: 10, cssDefault.width: '10%' }],
            identification: [{ position: 10 }] }
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Carrier_StdVH', element: 'AirlineID' } } ]
  key AirlineID,

      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.7 }
      @UI:{ selectionField: [{ position: 20 }],
            lineItem: [{ position: 20, cssDefault.width: '50%' }],
            identification: [{ position: 20 }] }
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Carrier_StdVH', element: 'AirlineID' } } ]
      Name       as AirlineName,

      @UI:{ identification: [{ position: 30 }] }
      @ObjectModel.text.association: '_Currency'
      CurrencyCode,

      /* Dummy  Feilds */

      @Consumption.filter.hidden: true
      @UI:{ lineItem: [{ position: 30, importance: #LOW, type: #AS_CONTACT, value: '_AirlineContact', label: 'Airline Contact (Card)', cssDefault.width: '10%' }],
            fieldGroup: [{ qualifier: 'tqAdditionalDetailsCards', position: 10, type: #AS_CONTACT, value: '_AirlineContact' }] }
      @EndUserText:{ label: 'Airline Contact', quickInfo: 'Airline Contact' }
      '001'      as ContactID,

      @Consumption.filter.hidden: true
      @Consumption.semanticObject: 'SemanticObjectAboutAirline' -- To enable hyperlink
      @ObjectModel.foreignKey.association: '_AboutAirline'
      @UI:{ lineItem: [{ position: 40, importance: #LOW, label: 'Airline Overview (Card)', cssDefault.width: '10%' }],
            fieldGroup: [{ qualifier: 'tqAdditionalDetailsCards', position: 20, label: 'About Airline' }] }
      @EndUserText:{ label: 'About Airline', quickInfo: 'About Airline' }
      //'DUMMY002'
      AirlineID  as AboutAirline,

      @UI:{ lineItem: [{ position: 50, importance: #LOW, cssDefault.width: '10%', type: #AS_DATAPOINT, label: 'Rating' }],
            dataPoint:{ qualifier: 'AirlineRating', targetValue: 5, visualization: #RATING, title: 'Rating' } }
      case AirlineID
      when 'AA' then 4.3
      when 'AZ' then 4.5
      when 'LH' then 3.9
      when 'SQ' then 5
      when 'UA' then 4.1
      else 3.7 end as AirlineRating,

      /* Virtual Elements */

      -- Logo
      -- Star Ratings

      @Consumption.filter.hidden: true
      @UI:{ lineItem: [{ position: 01, cssDefault.width: '10%', importance: #LOW, label: 'Airline Logo' }] }
      @Semantics.imageUrl: true
      case AirlineID
      when 'AA' then 'https://img.icons8.com/?size=100&id=20997&format=png&color=000000'
      //when 'AC' then ''
      //when 'AF' then ''
      //when 'AZ' then ''
      when 'BA' then 'https://img.icons8.com/?size=100&id=20915&format=png&color=000000'
      //when 'CO' then ''
      when 'DL' then 'https://img.icons8.com/?size=100&id=2NxzV9OhaYiQ&format=png&color=000000'
      //when 'FJ' then ''
      //when 'JL' then ''
      //when 'LH' then ''
      //when 'NG' then ''
      when 'QF' then 'https://img.icons8.com/?size=100&id=pKLyBomqVBhA&format=png&color=000000'
      //when 'SA' then ''
      //when 'SQ' then ''
      //when 'SR' then ''
      when 'UA' then 'https://img.icons8.com/?size=100&id=OGuWAbtPXDre&format=png&color=000000'
      else 'sap-icon://paper-plane'
      end        as AirlineLogo,


      //      @UI.fieldGroup: [{ qualifier: 'tqAirlineOverview', position: 20, label: 'Call Sign' }]
      //      _AirlineQuickView.CallSign,

      /* Admin Data */

      @Semantics.user.createdBy: true
      LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      LocalCreatedAt,

      @Semantics.user.lastChangedBy: true
      LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true //local ETag field --> OData ETag
      LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      /* Associations */

      _Currency,
      _Connection,
      _AirlineContact,
      _AboutAirline
}
