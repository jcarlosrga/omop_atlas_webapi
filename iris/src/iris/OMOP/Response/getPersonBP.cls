Class OMOP.Response.getPersonBP Extends Ens.Response
{

Property genderCode As %String(MAXLEN = "", XMLNAME = "Gender_Code");

Property rawGenderCode As %String(MAXLEN = "", XMLNAME = "RawGender_Code");

Property birthGenderCode As %String(MAXLEN = "", XMLNAME = "BirthGender_Code");

Property ethnicGroupCode As %String(MAXLEN = "", XMLNAME = "EthnicGroup_Code");

Property id As %String(MAXLEN = "", XMLNAME = "ID");

Property raceDescription As %String(MAXLEN = "", XMLNAME = "Race_Description");

Property raceCode As %String(MAXLEN = "", XMLNAME = "race_code");

Property birthTime As %String(MAXLEN = "", XMLNAME = "BirthTime");

Property ethnicGroupDescription As %String(MAXLEN = "", XMLNAME = "EthnicGroup_Description");

Property createdOn As %String(MAXLEN = "", XMLNAME = "createdOn");

Storage Default
{
<Data name="getPersonBPDefaultData">
<Subscript>"getPersonBP"</Subscript>
<Value name="1">
<Value>genderCode</Value>
</Value>
<Value name="2">
<Value>rawGenderCode</Value>
</Value>
<Value name="3">
<Value>birthGenderCode</Value>
</Value>
<Value name="4">
<Value>ethnicGroupCode</Value>
</Value>
<Value name="5">
<Value>id</Value>
</Value>
<Value name="6">
<Value>raceDescription</Value>
</Value>
<Value name="7">
<Value>raceCode</Value>
</Value>
<Value name="8">
<Value>birthTime</Value>
</Value>
<Value name="9">
<Value>ethnicGroupDescription</Value>
</Value>
<Value name="10">
<Value>locationId</Value>
</Value>
<Value name="11">
<Value>providerId</Value>
</Value>
<Value name="12">
<Value>careSiteId</Value>
</Value>
<Value name="13">
<Value>createdOn</Value>
</Value>
</Data>
<DefaultData>getPersonBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
