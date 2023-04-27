Class OMOP.Request.createSpecimen Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createSpecimen";

Property patientId As %String(MAXLEN = "", XMLNAME = "patient_Id");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Storage Default
{
<Data name="createSpecimenDefaultData">
<Subscript>"createSpecimen"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>encounterId</Value>
</Value>
<Value name="3">
<Value>careProviderId</Value>
</Value>
<Value name="4">
<Value>providerId</Value>
</Value>
<Value name="5">
<Value>visitOccurrenceId</Value>
</Value>
<Value name="6">
<Value>visitDetailId</Value>
</Value>
</Data>
<DefaultData>createSpecimenDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
