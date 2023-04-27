Class OMOP.Request.clearPatientDataBP Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createPersonBP";

Property patientId As %String(MAXLEN = "", XMLNAME = "patient_id");

Storage Default
{
<Data name="clearPatientDataBPDefaultData">
<Subscript>"clearPatientDataBP"</Subscript>
<Value name="1">
<Value>personId</Value>
</Value>
<Value name="2">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>clearPatientDataBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
