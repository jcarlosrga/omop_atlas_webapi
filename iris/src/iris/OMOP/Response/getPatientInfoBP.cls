Class OMOP.Response.getPatientInfoBP Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Property addressCityCode As %String(MAXLEN = "", XMLNAME = "Address_City_Code");

Property addressCityDescription As %String(MAXLEN = "", XMLNAME = "Address_City_Description");

Property addressStateCode As %String(MAXLEN = "", XMLNAME = "Address_State_Code");

Property addressStreet As %String(MAXLEN = "", XMLNAME = "Address_Street");

Property addressZipCode As %String(MAXLEN = "", XMLNAME = "Address_Zip_Code");

Property addressCountRyCode As %String(MAXLEN = "", XMLNAME = "Address_CountRy_Code");

Storage Default
{
<Data name="getPatientInfoBPDefaultData">
<Subscript>"getPatientInfoBP"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
<Value name="2">
<Value>addressCityCode</Value>
</Value>
<Value name="3">
<Value>addressCityDescription</Value>
</Value>
<Value name="4">
<Value>addressStateCode</Value>
</Value>
<Value name="5">
<Value>addressStreet</Value>
</Value>
<Value name="6">
<Value>addressZipCode</Value>
</Value>
<Value name="7">
<Value>addressCountRyCode</Value>
</Value>
</Data>
<DefaultData>getPatientInfoBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
