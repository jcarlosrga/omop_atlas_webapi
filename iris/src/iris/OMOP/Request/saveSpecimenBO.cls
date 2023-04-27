Class OMOP.Request.saveSpecimenBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveDrugExposureBO";

Property specimenId As %String(MAXLEN = "", XMLNAME = "specimen_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property specimenConceptId As %String(MAXLEN = "", XMLNAME = "specimen_concept_id");

Property specimenTypeConceptId As %String(MAXLEN = "", XMLNAME = "specimen_type_concept_id");

Property specimenDate As %String(MAXLEN = "", XMLNAME = "specimen_date");

Property specimenDatetime As %String(MAXLEN = "", XMLNAME = "specimen_datetime");

Property quantity As %String(MAXLEN = "", XMLNAME = "quantity");

Property unitConceptId As %String(MAXLEN = "", XMLNAME = "unit_concept_id");

Property anatomicSiteConceptId As %String(MAXLEN = "", XMLNAME = "anatomic_site_concept_id");

Property diseaseStatusConceptId As %String(MAXLEN = "", XMLNAME = "disease_status_concept_id");

Property specimenSourceId As %String(MAXLEN = "", XMLNAME = "specimen_source_id");

Property specimenSourceValue As %String(MAXLEN = "", XMLNAME = "specimen_source_value");

Property unitSourceValue As %String(MAXLEN = "", XMLNAME = "unit_source_value");

Property anatomicSiteSourceValue As %String(MAXLEN = "", XMLNAME = "anatomic_site_source_value");

Property diseaseStatusSourceValue As %String(MAXLEN = "", XMLNAME = "disease_status_source_value");

Storage Default
{
<Data name="saveSpecimenBODefaultData">
<Subscript>"saveSpecimenBO"</Subscript>
<Value name="1">
<Value>specimenId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
<Value name="3">
<Value>specimenConceptId</Value>
</Value>
<Value name="4">
<Value>specimenTypeConceptId</Value>
</Value>
<Value name="5">
<Value>specimenDate</Value>
</Value>
<Value name="6">
<Value>specimenDatetime</Value>
</Value>
<Value name="7">
<Value>quantity</Value>
</Value>
<Value name="8">
<Value>unitConceptId</Value>
</Value>
<Value name="9">
<Value>anatomicSiteConceptId</Value>
</Value>
<Value name="10">
<Value>diseaseStatusConceptId</Value>
</Value>
<Value name="11">
<Value>specimenSourceId</Value>
</Value>
<Value name="12">
<Value>specimenSourceValue</Value>
</Value>
<Value name="13">
<Value>unitSourceValue</Value>
</Value>
<Value name="14">
<Value>anatomicSiteSourceValue</Value>
</Value>
<Value name="15">
<Value>diseaseStatusSourceValue</Value>
</Value>
</Data>
<DefaultData>saveSpecimenBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
