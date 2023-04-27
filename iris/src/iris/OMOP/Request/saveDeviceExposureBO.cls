Class OMOP.Request.saveDeviceExposureBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveDrugExposureBO";

Property deviceExposureId As %String(MAXLEN = "", XMLNAME = "device_exposure_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property deviceConceptId As %String(MAXLEN = "", XMLNAME = "device_concept_id");

Property deviceExposureStartDate As %String(MAXLEN = "", XMLNAME = "device_exposure_start_date");

Property deviceExposureStartDatetime As %String(MAXLEN = "", XMLNAME = "device_exposure_start_datetime");

Property deviceExposureEndDate As %String(MAXLEN = "", XMLNAME = "device_exposure_end_date");

Property deviceExposureEndDatetime As %String(MAXLEN = "", XMLNAME = "device_exposure_end_datetime");

Property deviceTypeConceptId As %String(MAXLEN = "", XMLNAME = "device_type_concept_id");

Property uniqueDeviceId As %String(MAXLEN = "", XMLNAME = "unique_device_id");

Property quantity As %String(MAXLEN = "", XMLNAME = "quantity");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Property deviceSourceValue As %String(MAXLEN = "", XMLNAME = "device_source_value");

Property deviceSourceConceptId As %String(MAXLEN = "", XMLNAME = "device_source_concept_id");

Storage Default
{
<Data name="saveDeviceExposureBODefaultData">
<Subscript>"saveDeviceExposureBO"</Subscript>
<Value name="1">
<Value>deviceExposureId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
<Value name="3">
<Value>deviceConceptId</Value>
</Value>
<Value name="4">
<Value>deviceExposureStartDate</Value>
</Value>
<Value name="5">
<Value>deviceExposureStartDatetime</Value>
</Value>
<Value name="6">
<Value>deviceExposureEndDate</Value>
</Value>
<Value name="7">
<Value>deviceExposureEndDatetime</Value>
</Value>
<Value name="8">
<Value>deviceTypeConceptId</Value>
</Value>
<Value name="9">
<Value>uniqueDeviceId</Value>
</Value>
<Value name="10">
<Value>quantity</Value>
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
<Value>deviceSourceValue</Value>
</Value>
<Value name="15">
<Value>deviceSourceConceptId</Value>
</Value>
</Data>
<DefaultData>saveDeviceExposureBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
