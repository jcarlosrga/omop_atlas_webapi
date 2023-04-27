Class OMOP.Request.saveCareLocationInfoBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveCareLocationInfoBO";

Property locationId As %String(MAXLEN = "", XMLNAME = "location_id");

Property address1 As %String(MAXLEN = "", XMLNAME = "address_1");

Property address2 As %String(MAXLEN = "", XMLNAME = "address_2");

Property city As %String(MAXLEN = "", XMLNAME = "city");

Property state As %String(MAXLEN = "", XMLNAME = "state");

Property zip As %String(MAXLEN = "", XMLNAME = "zip");

Property county As %String(MAXLEN = "", XMLNAME = "county");

Property locationSourceValue As %String(MAXLEN = "", XMLNAME = "location_source_value");

Storage Default
{
<Data name="saveCareLocationInfoBODefaultData">
<Subscript>"saveCareLocationInfoBO"</Subscript>
<Value name="1">
<Value>providerId</Value>
</Value>
<Value name="2">
<Value>providerName</Value>
</Value>
<Value name="3">
<Value>npi</Value>
</Value>
<Value name="4">
<Value>dea</Value>
</Value>
<Value name="5">
<Value>specialtyConceptId</Value>
</Value>
<Value name="6">
<Value>careSiteId</Value>
</Value>
<Value name="7">
<Value>yearOfBirth</Value>
</Value>
<Value name="8">
<Value>genderConceptId</Value>
</Value>
<Value name="9">
<Value>providerSourceValue</Value>
</Value>
<Value name="10">
<Value>specialtySourceValue</Value>
</Value>
<Value name="11">
<Value>specialtySourceConceptId</Value>
</Value>
<Value name="12">
<Value>genderSourceValue</Value>
</Value>
<Value name="13">
<Value>genderSourceConceptId</Value>
</Value>
<Value name="14">
<Value>ID</Value>
</Value>
<Value name="15">
<Value>Description</Value>
</Value>
<Value name="16">
<Value>AddressCityCode</Value>
</Value>
<Value name="17">
<Value>AddressStateCode</Value>
</Value>
<Value name="18">
<Value>AddressStreet</Value>
</Value>
<Value name="19">
<Value>AddressZipCode</Value>
</Value>
<Value name="20">
<Value>AddressCountryCode</Value>
</Value>
<Value name="21">
<Value>locationId</Value>
</Value>
<Value name="22">
<Value>address1</Value>
</Value>
<Value name="23">
<Value>address2</Value>
</Value>
<Value name="24">
<Value>city</Value>
</Value>
<Value name="25">
<Value>state</Value>
</Value>
<Value name="26">
<Value>zip</Value>
</Value>
<Value name="27">
<Value>county</Value>
</Value>
<Value name="28">
<Value>locationSourceValue</Value>
</Value>
</Data>
<DefaultData>saveCareLocationInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
