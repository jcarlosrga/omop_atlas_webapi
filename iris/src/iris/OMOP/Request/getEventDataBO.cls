Class OMOP.Request.getEventDataBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getEventDataBO";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Storage Default
{
<Data name="getEventDataBODefaultData">
<Subscript>"getEventDataBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>getEventDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
