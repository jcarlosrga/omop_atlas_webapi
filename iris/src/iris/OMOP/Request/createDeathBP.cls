Class OMOP.Request.createDeathBP Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createPersonBP";

Property patientId As %String(MAXLEN = "", XMLNAME = "patient_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Storage Default
{
<Data name="createDeathBPDefaultData">
<Subscript>"createDeathBP"</Subscript>
<Value name="1">
<Value>patinetId</Value>
</Value>
<Value name="2">
<Value>patientId</Value>
</Value>
<Value name="3">
<Value>personId</Value>
</Value>
</Data>
<DefaultData>createDeathBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
