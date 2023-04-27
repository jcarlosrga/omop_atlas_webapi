Class OMOP.Response.getCareSiteInfoBO Extends Ens.Response
{

Property ID As %String(MAXLEN = "", XMLNAME = "ID");

Property Description As %String(MAXLEN = "", XMLNAME = "Description");

Property AddressCityCode As %String(MAXLEN = "", XMLNAME = "Address_City_Code");

Property AddressStateCode As %String(MAXLEN = "", XMLNAME = "Address_State_Code");

Property AddressStreet As %String(MAXLEN = "", XMLNAME = "Address_Street");

Property AddressZipCode As %String(MAXLEN = "", XMLNAME = "Address_Zip_Code");

Property AddressCountryCode As %String(MAXLEN = "", XMLNAME = "Address_Country_Code");

/// special field to separate requests from different part of the production
Property src As %String(MAXLEN = "", XMLNAME = "source");

Storage Default
{
<Data name="getCareSiteInfoBODefaultData">
<Subscript>"getCareSiteInfoBO"</Subscript>
<Value name="1">
<Value>CareProvider</Value>
</Value>
<Value name="2">
<Value>ClinicianDescription</Value>
</Value>
<Value name="3">
<Value>NationalProviderID</Value>
</Value>
<Value name="4">
<Value>DEANumber</Value>
</Value>
<Value name="5">
<Value>Specialty</Value>
</Value>
<Value name="6">
<Value>ID</Value>
</Value>
<Value name="7">
<Value>Description</Value>
</Value>
<Value name="8">
<Value>AddressCityCode</Value>
</Value>
<Value name="9">
<Value>AddressStateCode</Value>
</Value>
<Value name="10">
<Value>AddressStreet</Value>
</Value>
<Value name="11">
<Value>AddressZipCode</Value>
</Value>
<Value name="12">
<Value>AddressCountryCode</Value>
</Value>
<Value name="13">
<Value>source</Value>
</Value>
<Value name="14">
<Value>src</Value>
</Value>
</Data>
<DefaultData>getCareSiteInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
