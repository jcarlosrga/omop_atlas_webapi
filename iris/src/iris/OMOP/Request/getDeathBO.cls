Class OMOP.Request.getDeathBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getDeathBO";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Storage Default
{
<Data name="getDeathBODefaultData">
<Subscript>"getDeathBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>getDeathBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
