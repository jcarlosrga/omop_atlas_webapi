Class OMOP.Request.createEventTable Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createVisitOccurenceBP";

Property patientId As %String(MAXLEN = "", XMLNAME = "patient_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Storage Default
{
<Data name="createEventTableDefaultData">
<Subscript>"createEventTable"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>irisPatientId</Value>
</Value>
<Value name="3">
<Value>personId</Value>
</Value>
</Data>
<DefaultData>createEventTableDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
