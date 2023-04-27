Class OMOP.Request.createCondition Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createCondition";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Storage Default
{
<Data name="createConditionDefaultData">
<Subscript>"createCondition"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>encounterId</Value>
</Value>
<Value name="3">
<Value>visitOccurenceId</Value>
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
<DefaultData>createConditionDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
