Class OMOP.Request.getPatientInfo Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getPatientInfo";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Storage Default
{
<Data name="getPatientInfoDefaultData">
<Subscript>"getPatientInfo"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>getPatientInfoDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
