Class OMOP.Request.getPatientInfoBP Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getPatientInfoBP";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Storage Default
{
<Data name="getPatientInfoBPDefaultData">
<Subscript>"getPatientInfoBP"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>getPatientInfoBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
