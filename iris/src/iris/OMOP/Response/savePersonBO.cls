Class OMOP.Response.savePersonBO Extends Ens.Response
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

Storage Default
{
<Data name="savePersonBODefaultData">
<Subscript>"savePersonBO"</Subscript>
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
</Data>
<DefaultData>savePersonBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
