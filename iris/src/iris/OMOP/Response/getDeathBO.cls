Class OMOP.Response.getDeathBO Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "ID");

Property deathTime As %String(MAXLEN = "", XMLNAME = "DeathTime");

Property deceased As %String(MAXLEN = "", XMLNAME = "Deceased");

Storage Default
{
<Data name="getDeathBODefaultData">
<Subscript>"getDeathBO"</Subscript>
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
<Value>deathTime</Value>
</Value>
<Value name="11">
<Value>deceased</Value>
</Value>
</Data>
<DefaultData>getDeathBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
