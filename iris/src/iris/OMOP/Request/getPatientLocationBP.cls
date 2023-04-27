Class OMOP.Request.getPatientLocationBP Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getPatientLocationBP";

Property patientId As %String(MAXLEN = "", XMLNAME = "patient_id");

Storage Default
{
<Data name="getPatientLocationBPDefaultData">
<Subscript>"getPatientLocationBP"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>getPatientLocationBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
