Class OMOP.Response.saveCareLocationInfoBO Extends Ens.Response
{

Property ID As %String(MAXLEN = "", XMLNAME = "ID");

Property Description As %String(MAXLEN = "", XMLNAME = "Description");

Property AddressCityCode As %String(MAXLEN = "", XMLNAME = "Address_City_Code");

Property AddressStateCode As %String(MAXLEN = "", XMLNAME = "Address_State_Code");

Property AddressStreet As %String(MAXLEN = "", XMLNAME = "Address_Street");

Property AddressZipCode As %String(MAXLEN = "", XMLNAME = "Address_Zip_Code");

Property AddressCountryCode As %String(MAXLEN = "", XMLNAME = "Address_Country_Code");

Storage Default
{
<Data name="saveCareLocationInfoBODefaultData">
<Subscript>"saveCareLocationInfoBO"</Subscript>
<Value name="1">
<Value>ID</Value>
</Value>
<Value name="2">
<Value>Description</Value>
</Value>
<Value name="3">
<Value>AddressCityCode</Value>
</Value>
<Value name="4">
<Value>AddressStateCode</Value>
</Value>
<Value name="5">
<Value>AddressStreet</Value>
</Value>
<Value name="6">
<Value>AddressZipCode</Value>
</Value>
<Value name="7">
<Value>AddressCountryCode</Value>
</Value>
</Data>
<DefaultData>saveCareLocationInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
