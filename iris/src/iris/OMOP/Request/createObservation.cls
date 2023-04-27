Class OMOP.Request.createObservation Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createObservation";

Property patientId As %String(MAXLEN = "", XMLNAME = "patient_id");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Property saveRemains As %String(MAXLEN = "", XMLNAME = "save_remains");

Storage Default
{
<Data name="createObservationDefaultData">
<Subscript>"createObservation"</Subscript>
<Value name="1">
<Value>encounterId</Value>
</Value>
<Value name="2">
<Value>patientId</Value>
</Value>
<Value name="3">
<Value>visitOccurrenceId</Value>
</Value>
<Value name="4">
<Value>visitDetailId</Value>
</Value>
<Value name="5">
<Value>providerId</Value>
</Value>
<Value name="6">
<Value>saveRemains</Value>
</Value>
</Data>
<DefaultData>createObservationDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
