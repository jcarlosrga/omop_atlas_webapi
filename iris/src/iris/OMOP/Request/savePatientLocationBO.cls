Class OMOP.Request.savePatientLocationBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getPatientInfoBP";

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
<Data name="savePatientLocationBODefaultData">
<Subscript>"savePatientLocationBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>id</Value>
</Value>
<Value name="3">
<Value>addressCityCode</Value>
</Value>
<Value name="4">
<Value>addressCityDescription</Value>
</Value>
<Value name="5">
<Value>addressStateCode</Value>
</Value>
<Value name="6">
<Value>addressStreet</Value>
</Value>
<Value name="7">
<Value>addressZipCode</Value>
</Value>
<Value name="8">
<Value>addressCountRyCode</Value>
</Value>
<Value name="9">
<Value>address1</Value>
</Value>
<Value name="10">
<Value>address2</Value>
</Value>
<Value name="11">
<Value>city</Value>
</Value>
<Value name="12">
<Value>state</Value>
</Value>
<Value name="13">
<Value>zip</Value>
</Value>
<Value name="14">
<Value>county</Value>
</Value>
<Value name="15">
<Value>locationSourceValue</Value>
</Value>
<Value name="16">
<Value>locationId</Value>
</Value>
</Data>
<DefaultData>savePatientLocationBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
