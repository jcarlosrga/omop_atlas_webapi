Class OMOP.Request.saveVisitOccurence Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveVisitOccurenceBO";

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property visitConceptId As %String(MAXLEN = "", XMLNAME = "visit_concept_id");

Property visitStartDate As %String(MAXLEN = "", XMLNAME = "visit_start_date");

Property visitStartDatetime As %String(MAXLEN = "", XMLNAME = "visit_start_datetime");

Property visitEndDate As %String(MAXLEN = "", XMLNAME = "visit_end_date");

Property visitEndDatetime As %String(MAXLEN = "", XMLNAME = "visit_end_datetime");

Property visitTypeConceptId As %String(MAXLEN = "", XMLNAME = "visit_type_concept_id");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property careSiteId As %String(MAXLEN = "", XMLNAME = "care_site_id");

Property visitSourceValue As %String(MAXLEN = "", XMLNAME = "visit_source_value");

Property visitSourceConceptId As %String(MAXLEN = "", XMLNAME = "visit_source_concept_id");

Property admittingSourceConceptId As %String(MAXLEN = "", XMLNAME = "admitting_source_concept_id");

Property admittingSourceValue As %String(MAXLEN = "", XMLNAME = "admitting_source_value");

Property dischargeToConceptId As %String(MAXLEN = "", XMLNAME = "discharge_to_concept_id");

Property dischargeToSourceValue As %String(MAXLEN = "", XMLNAME = "discharge_to_source_value");

Property visitDetailParentId As %String(MAXLEN = "", XMLNAME = "visit_detail_parent_id");

Property precedingVisitOccurrenceId As %String(MAXLEN = "", XMLNAME = "preceding_visit_occurrence_id");

Storage Default
{
<Data name="saveVisitOccurenceDefaultData">
<Subscript>"saveVisitOccurence"</Subscript>
<Value name="1">
<Value>visitOccurrenceId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
<Value name="3">
<Value>visitConceptId</Value>
</Value>
<Value name="4">
<Value>visitStartDate</Value>
</Value>
<Value name="5">
<Value>visitStartDatetime</Value>
</Value>
<Value name="6">
<Value>visitEndDate</Value>
</Value>
<Value name="7">
<Value>visitEndDatetime</Value>
</Value>
<Value name="8">
<Value>visitTypeConceptId</Value>
</Value>
<Value name="9">
<Value>providerId</Value>
</Value>
<Value name="10">
<Value>careSiteId</Value>
</Value>
<Value name="11">
<Value>visitSourceValue</Value>
</Value>
<Value name="12">
<Value>visitSourceConceptId</Value>
</Value>
<Value name="13">
<Value>admittingSourceConceptId</Value>
</Value>
<Value name="14">
<Value>admittingSourceValue</Value>
</Value>
<Value name="15">
<Value>dischargeToConceptId</Value>
</Value>
<Value name="16">
<Value>dischargeToSourceValue</Value>
</Value>
<Value name="17">
<Value>precedingVisitOccurrenceId</Value>
</Value>
<Value name="18">
<Value>visitDetailId</Value>
</Value>
<Value name="19">
<Value>visitDetailParentId</Value>
</Value>
<Value name="20">
<Value>admittingSourceCode</Value>
</Value>
</Data>
<DefaultData>saveVisitOccurenceDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
