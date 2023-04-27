Class OMOP.Request.saveDrugExposureBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveDrugExposureBO";

Property drugExposureId As %String(MAXLEN = "", XMLNAME = "drug_exposure_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property drugConceptId As %String(MAXLEN = "", XMLNAME = "drug_concept_id");

Property drugExposureStartDate As %String(MAXLEN = "", XMLNAME = "drug_exposure_start_date");

Property drugExposureStartDatetime As %String(MAXLEN = "", XMLNAME = "drug_exposure_start_datetime");

Property drugExposureEndDate As %String(MAXLEN = "", XMLNAME = "drug_exposure_end_date");

Property drugExposureEndDatetime As %String(MAXLEN = "", XMLNAME = "drug_exposure_end_datetime");

Property verbatimEndDate As %String(MAXLEN = "", XMLNAME = "verbatim_end_date");

Property drugTypeConceptId As %String(MAXLEN = "", XMLNAME = "drug_type_concept_id");

Property stopReason As %String(MAXLEN = "", XMLNAME = "stop_reason");

Property refills As %String(MAXLEN = "", XMLNAME = "refills");

Property quantity As %String(MAXLEN = "", XMLNAME = "quantity");

Property daysSupply As %String(MAXLEN = "", XMLNAME = "days_supply");

Property sig As %String(MAXLEN = "", XMLNAME = "sig");

Property routeConceptId As %String(MAXLEN = "", XMLNAME = "route_concept_id");

Property lotNumber As %String(MAXLEN = "", XMLNAME = "lot_number");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Property drugSourceValue As %String(MAXLEN = "", XMLNAME = "drug_source_value");

Property drugSourceConceptId As %String(MAXLEN = "", XMLNAME = "drug_source_concept_id");

Property routeSourceValue As %String(MAXLEN = "", XMLNAME = "route_source_value");

Property doseUnitSourceValue As %String(MAXLEN = "", XMLNAME = "dose_unit_source_value");

Storage Default
{
<Data name="saveDrugExposureBODefaultData">
<Subscript>"saveDrugExposureBO"</Subscript>
<Value name="1">
<Value>drugOccurrenceId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
<Value name="3">
<Value>drugConceptId</Value>
</Value>
<Value name="4">
<Value>drugExposureStartDate</Value>
</Value>
<Value name="5">
<Value>drugExposureStartDatetime</Value>
</Value>
<Value name="6">
<Value>drugExposureEndDate</Value>
</Value>
<Value name="7">
<Value>drugExposureEndDatetime</Value>
</Value>
<Value name="8">
<Value>verbatimEndDate</Value>
</Value>
<Value name="9">
<Value>drugTypeConceptId</Value>
</Value>
<Value name="10">
<Value>stopReason</Value>
</Value>
<Value name="11">
<Value>refills</Value>
</Value>
<Value name="12">
<Value>quantity</Value>
</Value>
<Value name="13">
<Value>daysSupply</Value>
</Value>
<Value name="14">
<Value>sig</Value>
</Value>
<Value name="15">
<Value>routeConceptId</Value>
</Value>
<Value name="16">
<Value>lotNumber</Value>
</Value>
<Value name="17">
<Value>providerId</Value>
</Value>
<Value name="18">
<Value>visitOccurrenceId</Value>
</Value>
<Value name="19">
<Value>visitDetailId</Value>
</Value>
<Value name="20">
<Value>drugSourceValue</Value>
</Value>
<Value name="21">
<Value>drugSourceConceptId</Value>
</Value>
<Value name="22">
<Value>routeSourceValue</Value>
</Value>
<Value name="23">
<Value>doseUnitSourceValue</Value>
</Value>
<Value name="24">
<Value>drugExposureId</Value>
</Value>
</Data>
<DefaultData>saveDrugExposureBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
