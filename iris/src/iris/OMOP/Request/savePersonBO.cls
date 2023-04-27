Class OMOP.Request.savePersonBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.savePersonBO";

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property genderConceptId As %String(MAXLEN = "", XMLNAME = "gender_concept_id");

Property yearOfBirth As %String(MAXLEN = "", XMLNAME = "year_of_birth");

Property monthOfBirth As %String(MAXLEN = "", XMLNAME = "month_of_birth");

Property dayOfBirth As %String(MAXLEN = "", XMLNAME = "day_of_birth");

Property birthDatetime As %String(MAXLEN = "", XMLNAME = "birth_datetime");

Property deathDatetime As %String(MAXLEN = "", XMLNAME = "death_datetime");

Property raceConceptId As %String(MAXLEN = "", XMLNAME = "race_concept_id");

Property ethnicityConceptId As %String(MAXLEN = "", XMLNAME = "ethnicity_concept_id");

Property locationId As %String(MAXLEN = "", XMLNAME = "location_id");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property careSiteId As %String(MAXLEN = "", XMLNAME = "care_site_id");

Property personSourceValue As %String(MAXLEN = "", XMLNAME = "person_source_value");

Property genderSourceValue As %String(MAXLEN = "", XMLNAME = "gender_source_value");

Property genderSourceConceptId As %String(MAXLEN = "", XMLNAME = "gender_source_concept_id");

Property raceSourceValue As %String(MAXLEN = "", XMLNAME = "race_source_value");

Property raceSourceConceptId As %String(MAXLEN = "", XMLNAME = "race_source_concept_id");

Property ethnicitySourceValue As %String(MAXLEN = "", XMLNAME = "ethnicity_source_value");

Property ethnicitySourceConceptId As %String(MAXLEN = "", XMLNAME = "ethnicity_source_concept_id");

Storage Default
{
<Data name="savePersonBODefaultData">
<Subscript>"savePersonBO"</Subscript>
<Value name="1">
<Value>personId</Value>
</Value>
<Value name="2">
<Value>genderConceptId</Value>
</Value>
<Value name="3">
<Value>yearOfBirth</Value>
</Value>
<Value name="4">
<Value>monthOfBirth</Value>
</Value>
<Value name="5">
<Value>dayOfBirth</Value>
</Value>
<Value name="6">
<Value>birthDatetime</Value>
</Value>
<Value name="7">
<Value>raceConceptId</Value>
</Value>
<Value name="8">
<Value>ethnicityConceptId</Value>
</Value>
<Value name="9">
<Value>locationId</Value>
</Value>
<Value name="10">
<Value>providerId</Value>
</Value>
<Value name="11">
<Value>careSiteId</Value>
</Value>
<Value name="12">
<Value>personSourceValue</Value>
</Value>
<Value name="13">
<Value>genderSourceValue</Value>
</Value>
<Value name="14">
<Value>genderSourceConceptId</Value>
</Value>
<Value name="15">
<Value>raceSourceValue</Value>
</Value>
<Value name="16">
<Value>raceSourceConceptId</Value>
</Value>
<Value name="17">
<Value>ethnicitySourceValue</Value>
</Value>
<Value name="18">
<Value>ethnicitySourceConceptId</Value>
</Value>
<Value name="19">
<Value>deathDatetime</Value>
</Value>
</Data>
<DefaultData>savePersonBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
