Class OMOP.Request.getPersonBP Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getPersonBP";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Storage Default
{
<Data name="getPersonBPDefaultData">
<Subscript>"getPersonBP"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>getPersonBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
