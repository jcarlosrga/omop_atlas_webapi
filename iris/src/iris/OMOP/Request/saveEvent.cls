Class OMOP.Request.saveEvent Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveVisitOccurenceBO";

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

Property precedingVisitOccurrenceId As %String(MAXLEN = "", XMLNAME = "preceding_visit_occurrence_id");

}
