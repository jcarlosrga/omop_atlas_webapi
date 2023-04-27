Class OMOP.Response.getPatientInfoBO Extends Ens.Response
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
<Data name="getPatientInfoBODefaultData">
<Subscript>"getPatientInfoBO"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
<Value name="2">
<Value>birthTime</Value>
</Value>
<Value name="3">
<Value>raceCode</Value>
</Value>
<Value name="4">
<Value>raceDescription</Value>
</Value>
<Value name="5">
<Value>ethnicGroupCode</Value>
</Value>
<Value name="6">
<Value>ethnicGroupDescription</Value>
</Value>
<Value name="7">
<Value>addressStreet</Value>
</Value>
<Value name="8">
<Value>addressCityDescription</Value>
</Value>
<Value name="9">
<Value>addressCountRyCode</Value>
</Value>
<Value name="10">
<Value>addressStateCode</Value>
</Value>
<Value name="11">
<Value>addressZipCode</Value>
</Value>
<Value name="12">
<Value>genderCode</Value>
</Value>
<Value name="13">
<Value>genderDescription</Value>
</Value>
<Value name="14">
<Value>rawGenderCode</Value>
</Value>
<Value name="15">
<Value>rawGenderDescription</Value>
</Value>
<Value name="16">
<Value>birthGenderCode</Value>
</Value>
<Value name="17">
<Value>birthGenderDescription</Value>
</Value>
<Value name="18">
<Value>deceased</Value>
</Value>
<Value name="19">
<Value>deathTime</Value>
</Value>
<Value name="20">
<Value>addressCityCode</Value>
</Value>
</Data>
<DefaultData>getPatientInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
