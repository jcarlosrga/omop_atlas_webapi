Class OMOP.Request.saveMeasurementBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveConditionBO";

Property measurementId As %String(MAXLEN = "", XMLNAME = "measurement_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property measurementConceptId As %String(MAXLEN = "", XMLNAME = "measurement_concept_id");

Property measurementDate As %String(MAXLEN = "", XMLNAME = "measurement_date");

Property measurementDatetime As %String(MAXLEN = "", XMLNAME = "measurement_datetime");

Property measurementTime As %String(MAXLEN = "", XMLNAME = "measurement_time");

Property measurementTypeConceptId As %String(MAXLEN = "", XMLNAME = "measurement_type_concept_id");

Property valueAsNumber As %String(MAXLEN = "", XMLNAME = "value_as_number");

Property valueAsString As %String(MAXLEN = "", XMLNAME = "value_as_string");

Property valueAsConceptId As %String(MAXLEN = "", XMLNAME = "value_as_concept_id");

Property qualifierConceptId As %String(MAXLEN = "", XMLNAME = "qualifier_concept_id");

Property unitConceptId As %String(MAXLEN = "", XMLNAME = "unit_concept_id");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Property measurementSourceValue As %String(MAXLEN = "", XMLNAME = "measurement_source_value");

Property measurementSourceConceptId As %String(MAXLEN = "", XMLNAME = "measurement_source_concept_id");

Property unitSourceValue As %String(MAXLEN = "", XMLNAME = "unit_source_value");

Property qualifierSourceValue As %String(MAXLEN = "", XMLNAME = "qualifier_source_value");

Property operatorConceptId As %String(MAXLEN = "", XMLNAME = "operator_concept_id");

Property rangeLow As %String(MAXLEN = "", XMLNAME = "range_low");

Property rangeHigh As %String(MAXLEN = "", XMLNAME = "range_high");

Property valueSourceValue As %String(MAXLEN = "", XMLNAME = "value_source_value");

Storage Default
{
<Data name="saveMeasurementBODefaultData">
<Subscript>"saveMeasurementBO"</Subscript>
<Value name="1">
<Value>measurementId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
<Value name="3">
<Value>measurementConceptId</Value>
</Value>
<Value name="4">
<Value>measurementDate</Value>
</Value>
<Value name="5">
<Value>measurementDatetime</Value>
</Value>
<Value name="6">
<Value>measurementTime</Value>
</Value>
<Value name="7">
<Value>measurementTypeConceptId</Value>
</Value>
<Value name="8">
<Value>valueAsNumber</Value>
</Value>
<Value name="9">
<Value>valueAsString</Value>
</Value>
<Value name="10">
<Value>valueAsConceptId</Value>
</Value>
<Value name="11">
<Value>qualifierConceptId</Value>
</Value>
<Value name="12">
<Value>unitConceptId</Value>
</Value>
<Value name="13">
<Value>providerId</Value>
</Value>
<Value name="14">
<Value>visitOccurrenceId</Value>
</Value>
<Value name="15">
<Value>visitDetailId</Value>
</Value>
<Value name="16">
<Value>measurementSourceValue</Value>
</Value>
<Value name="17">
<Value>measurementSourceConceptId</Value>
</Value>
<Value name="18">
<Value>unitSourceValue</Value>
</Value>
<Value name="19">
<Value>qualifierSourceValue</Value>
</Value>
<Value name="20">
<Value>operatorConceptId</Value>
</Value>
<Value name="21">
<Value>rangeLow</Value>
</Value>
<Value name="22">
<Value>rangeHigh</Value>
</Value>
<Value name="23">
<Value>valueSourceValue</Value>
</Value>
</Data>
<DefaultData>saveMeasurementBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

