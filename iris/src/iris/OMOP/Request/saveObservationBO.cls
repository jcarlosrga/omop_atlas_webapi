Class OMOP.Request.saveObservationBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveConditionBO";

Property observationId As %String(MAXLEN = "", XMLNAME = "observation_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property observationConceptId As %String(MAXLEN = "", XMLNAME = "observation_concept_id");

Property observationDate As %String(MAXLEN = "", XMLNAME = "observation_date");

Property observationDatetime As %String(MAXLEN = "", XMLNAME = "observation_datetime");

Property observationTypeConceptId As %String(MAXLEN = "", XMLNAME = "observation_type_concept_id");

Property valueAsNumber As %String(MAXLEN = "", XMLNAME = "value_as_number");

Property valueAsString As %String(MAXLEN = "", XMLNAME = "value_as_string");

Property valueAsConceptId As %String(MAXLEN = "", XMLNAME = "value_as_concept_id");

Property qualifierConceptId As %String(MAXLEN = "", XMLNAME = "qualifier_concept_id");

Property unitConceptId As %String(MAXLEN = "", XMLNAME = "unit_concept_id");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Property observationSourceValue As %String(MAXLEN = "", XMLNAME = "observation_source_value");

Property observationSourceConceptId As %String(MAXLEN = "", XMLNAME = "observation_source_concept_id");

Property unitSourceValue As %String(MAXLEN = "", XMLNAME = "unit_source_value");

Property qualifierSourceValue As %String(MAXLEN = "", XMLNAME = "qualifier_source_value");

Storage Default
{
<Data name="saveObservationBODefaultData">
<Subscript>"saveObservationBO"</Subscript>
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
<Value name="17">
<Value>observationId</Value>
</Value>
<Value name="18">
<Value>observationConceptId</Value>
</Value>
<Value name="19">
<Value>observationDate</Value>
</Value>
<Value name="20">
<Value>observationDatetime</Value>
</Value>
<Value name="21">
<Value>observationTypeConceptId</Value>
</Value>
<Value name="22">
<Value>valueAsNumber</Value>
</Value>
<Value name="23">
<Value>valueAsString</Value>
</Value>
<Value name="24">
<Value>valueAsConceptId</Value>
</Value>
<Value name="25">
<Value>qualifierConceptId</Value>
</Value>
<Value name="26">
<Value>unitConceptId</Value>
</Value>
<Value name="27">
<Value>observationSourceValue</Value>
</Value>
<Value name="28">
<Value>observationSourceConceptId</Value>
</Value>
<Value name="29">
<Value>unitSourceValue</Value>
</Value>
<Value name="30">
<Value>qualifierSourceValue</Value>
</Value>
<Value name="31">
<Value>sourceId</Value>
</Value>
</Data>
<DefaultData>saveObservationBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
