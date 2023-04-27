Class OMOP.Response.getPatientInfo Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Property birthTime As %String(MAXLEN = "", XMLNAME = "BirthTime");

Property raceCode As %String(MAXLEN = "", XMLNAME = "Race_Code");

Property raceDescription As %String(MAXLEN = "", XMLNAME = "Race_Description");

Property ethnicGroupCode As %String(MAXLEN = "", XMLNAME = "EthnicGroup_Code");

Property ethnicGroupDescription As %String(MAXLEN = "", XMLNAME = "EthnicGroup_Description");

Property addressStreet As %String(MAXLEN = "", XMLNAME = "Address_Street");

Property addressCityDescription As %String(MAXLEN = "", XMLNAME = "Address_City_Description");

Property addressCountRyCode As %String(MAXLEN = "", XMLNAME = "Address_CountRy_Code");

Property addressStateCode As %String(MAXLEN = "", XMLNAME = "Address_State_Code");

Property addressZipCode As %String(MAXLEN = "", XMLNAME = "Address_Zip_Code");

Property genderCode As %String(MAXLEN = "", XMLNAME = "Gender_Code");

Property genderDescription As %String(MAXLEN = "", XMLNAME = "Gender_Description");

Property rawGenderCode As %String(MAXLEN = "", XMLNAME = "RawGender_Code");

Property rawGenderDescription As %String(MAXLEN = "", XMLNAME = "RawGender_Description");

Property birthGenderCode As %String(MAXLEN = "", XMLNAME = "BirthGender_Code");

Property birthGenderDescription As %String(MAXLEN = "", XMLNAME = "BirthGender_Description");

Property deceased As %String(MAXLEN = "", XMLNAME = "Deceased");

Property deathTime As %String(MAXLEN = "", XMLNAME = "DeathTime");

Storage Default
{
<Data name="getPatientInfoDefaultData">
<Subscript>"getPatientInfo"</Subscript>
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
</Data>
<DefaultData>getPatientInfoDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
