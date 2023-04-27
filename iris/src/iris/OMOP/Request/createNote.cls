/// 
/// request for the create note business process from the getPatient info process
/// 
Class OMOP.Request.createNote Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createNote";

Property patientId As %String(MAXLEN = "", XMLNAME = "patient_Id");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Storage Default
{
<Data name="createNoteDefaultData">
<Subscript>"createNote"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>providerId</Value>
</Value>
<Value name="3">
<Value>visitOccurrenceId</Value>
</Value>
<Value name="4">
<Value>visitDetailId</Value>
</Value>
</Data>
<DefaultData>createNoteDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
