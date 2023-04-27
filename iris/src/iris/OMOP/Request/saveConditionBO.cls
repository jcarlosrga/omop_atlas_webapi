Class OMOP.Request.saveConditionBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveConditionBO";

Property conditionOccurrenceId As %String(MAXLEN = "", XMLNAME = "condition_occurrence_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property conditionConceptId As %String(MAXLEN = "", XMLNAME = "condition_concept_id");

Property conditionStartDate As %String(MAXLEN = "", XMLNAME = "condition_start_date");

Property conditionStartDatetime As %String(MAXLEN = "", XMLNAME = "condition_start_datetime");

Property conditionEndDate As %String(MAXLEN = "", XMLNAME = "condition_end_date");

Property conditionEndDatetime As %String(MAXLEN = "", XMLNAME = "condition_end_datetime");

Property conditionTypeConceptId As %String(MAXLEN = "", XMLNAME = "condition_type_concept_id");

Property conditionStatusConceptId As %String(MAXLEN = "", XMLNAME = "condition_status_concept_id");

Property stopReason As %String(MAXLEN = "", XMLNAME = "stop_reason");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Property conditionSourceValue As %String(MAXLEN = "", XMLNAME = "condition_source_value");

Property conditionSourceConceptId As %String(MAXLEN = "", XMLNAME = "condition_source_concept_id");

Property conditionStatusSourceValue As %String(MAXLEN = "", XMLNAME = "condition_status_source_value");

Storage Default
{
<Data name="saveConditionBODefaultData">
<Subscript>"saveConditionBO"</Subscript>
<Value name="1">
<Value>conditionOccurrenceId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
<Value name="3">
<Value>conditionConceptId</Value>
</Value>
<Value name="4">
<Value>conditionStartDate</Value>
</Value>
<Value name="5">
<Value>conditionStartDatetime</Value>
</Value>
<Value name="6">
<Value>conditionEndDate</Value>
</Value>
<Value name="7">
<Value>conditionEndDatetime</Value>
</Value>
<Value name="8">
<Value>conditionTypeConceptId</Value>
</Value>
<Value name="9">
<Value>conditionStatusConceptId</Value>
</Value>
<Value name="10">
<Value>stopReason</Value>
</Value>
<Value name="11">
<Value>providerId</Value>
</Value>
<Value name="12">
<Value>visitOccurrenceId</Value>
</Value>
<Value name="13">
<Value>visitDetailId</Value>
</Value>
<Value name="14">
<Value>conditionSourceValue</Value>
</Value>
<Value name="15">
<Value>conditionSourceConceptId</Value>
</Value>
<Value name="16">
<Value>conditionStatusSourceValue</Value>
</Value>
</Data>
<DefaultData>saveConditionBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

