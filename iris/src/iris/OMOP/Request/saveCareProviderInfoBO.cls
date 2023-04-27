Class OMOP.Request.saveCareProviderInfoBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveCareProviderInfoBO";

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property providerName As %String(MAXLEN = "", XMLNAME = "provider_name");

Property npi As %String(MAXLEN = "", XMLNAME = "npi");

Property dea As %String(MAXLEN = "", XMLNAME = "dea");

Property specialtyConceptId As %String(MAXLEN = "", XMLNAME = "specialty_concept_id");

Property careSiteId As %String(MAXLEN = "", XMLNAME = "care_site_id");

Property yearOfBirth As %String(MAXLEN = "", XMLNAME = "year_of_birth");

Property genderConceptId As %String(MAXLEN = "", XMLNAME = "gender_concept_id");

Property providerSourceValue As %String(MAXLEN = "", XMLNAME = "provider_source_value");

Property specialtySourceValue As %String(MAXLEN = "", XMLNAME = "specialty_source_value");

Property specialtySourceConceptId As %String(MAXLEN = "", XMLNAME = "specialty_source_concept_id");

Property genderSourceValue As %String(MAXLEN = "", XMLNAME = "gender_source_value");

Property genderSourceConceptId As %String(MAXLEN = "", XMLNAME = "gender_source_concept_id");

Storage Default
{
<Data name="saveCareProviderInfoBODefaultData">
<Subscript>"saveCareProviderInfoBO"</Subscript>
<Value name="1">
<Value>locationId</Value>
</Value>
<Value name="2">
<Value>address1</Value>
</Value>
<Value name="3">
<Value>address2</Value>
</Value>
<Value name="4">
<Value>city</Value>
</Value>
<Value name="5">
<Value>state</Value>
</Value>
<Value name="6">
<Value>zip</Value>
</Value>
<Value name="7">
<Value>county</Value>
</Value>
<Value name="8">
<Value>locationSourceValue</Value>
</Value>
<Value name="9">
<Value>CareProvider</Value>
</Value>
<Value name="10">
<Value>ClinicianDescription</Value>
</Value>
<Value name="11">
<Value>NationalProviderID</Value>
</Value>
<Value name="12">
<Value>DEANumber</Value>
</Value>
<Value name="13">
<Value>Specialty</Value>
</Value>
<Value name="14">
<Value>providerId</Value>
</Value>
<Value name="15">
<Value>providerName</Value>
</Value>
<Value name="16">
<Value>npi</Value>
</Value>
<Value name="17">
<Value>dea</Value>
</Value>
<Value name="18">
<Value>specialtyConceptId</Value>
</Value>
<Value name="19">
<Value>careSiteId</Value>
</Value>
<Value name="20">
<Value>yearOfBirth</Value>
</Value>
<Value name="21">
<Value>genderConceptId</Value>
</Value>
<Value name="22">
<Value>providerSourceValue</Value>
</Value>
<Value name="23">
<Value>specialtySourceConceptId</Value>
</Value>
<Value name="24">
<Value>genderSourceValue</Value>
</Value>
<Value name="25">
<Value>genderSourceConceptId</Value>
</Value>
<Value name="26">
<Value>specialtySourceValue</Value>
</Value>
</Data>
<DefaultData>saveCareProviderInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
