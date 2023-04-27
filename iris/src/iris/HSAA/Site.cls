/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.Site Extends %Persistent
{

// Allow synchronization

Parameter DSTIME = "AUTO";

/// The site's healthcare facility<br>
// Relationship HealthCareFacility As HSAA.HealthCareFacility(POPORDER = -1) [ Cardinality = one, Inverse = SiteRel ];

// Index NameIndex On Name;

// Index HealthCareFacilityIndex On HealthCareFacility;

// Index RNHCFIx On (RawName, HealthCareFacility);

/// Relationship CareProviderSiteRel As HSAA.CareProviderSite [ Cardinality = many, Inverse = Site ];

// Relationship EncounterRel As HSAA.Encounter [ Cardinality = many, Inverse = Site ];

/// Relationship OrderRel As HSAA.Order [ Cardinality = many, Inverse = OrderingSite ];

/// Relationship ReceivingOrderRel As HSAA.Order [ Cardinality = many, Inverse = ReceivingOrderSite ];

// Relationship ReferralRel As HSAA.Referral [ Cardinality = many, Inverse = ReferringSite ];

// Relationship ReceivingReferralRel As HSAA.Referral [ Cardinality = many, Inverse = ReceivingReferralSite ];

// bitmap extent index

Index "$Site" [ Extent, SqlName = "$Site", Type = bitmap ];

Storage Default
{
<Data name="SiteDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>HealthCareFacility</Value>
</Value>
<Value name="4">
<Value>Address</Value>
</Value>
<Value name="5">
<Value>ContactInfo</Value>
</Value>
<Value name="6">
<Value>MappedName</Value>
</Value>
<Value name="7">
<Value>IsPractice</Value>
</Value>
<Value name="8">
<Value>RawName</Value>
</Value>
<Value name="9">
<Value>LastUpdated</Value>
</Value>
<Value name="10">
<Value>Extension</Value>
</Value>
</Data>
<DataLocation>^HSAA.SiteD</DataLocation>
<DefaultData>SiteDefaultData</DefaultData>
<IdLocation>^HSAA.SiteD</IdLocation>
<IndexLocation>^HSAA.SiteI</IndexLocation>
<Property name="%%CLASSNAME"/>
<Property name="%%ID"/>
<Property name="Address"/>
<Property name="ContactInfo"/>
<Property name="Extension"/>
<Property name="HealthCareFacility"/>
<Property name="IsPractice"/>
<Property name="LastUpdated"/>
<Property name="MappedName"/>
<Property name="Name"/>
<Property name="RawName"/>
<SQLMap name="$Site"/>
<SQLMap name="HealthCareFacilityIndex"/>
<SQLMap name="IDKEY"/>
<SQLMap name="LastUpdatedIndex"/>
<SQLMap name="NameIndex"/>
<SQLMap name="RNHCFIx"/>
<StreamLocation>^HSAA.SiteS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
