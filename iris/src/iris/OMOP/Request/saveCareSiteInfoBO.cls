Class OMOP.Request.saveCareSiteInfoBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveCareSiteInfoBO";

Property careSiteId As %String(MAXLEN = "", XMLNAME = "care_site_id");

Property careSiteName As %String(MAXLEN = "", XMLNAME = "care_site_name");

Property placeOfServiceConceptId As %String(MAXLEN = "", XMLNAME = "place_of_service_concept_id");

Property locationId As %String(MAXLEN = "", XMLNAME = "location_id");

Property careSiteSourceValue As %String(MAXLEN = "", XMLNAME = "care_site_source_value");

Property placeOfServiceSourceValue As %String(MAXLEN = "", XMLNAME = "place_of_service_source_value");

Storage Default
{
<Data name="saveCareSiteInfoBODefaultData">
<Subscript>"saveCareSiteInfoBO"</Subscript>
<Value name="1">
<Value>providerId</Value>
</Value>
<Value name="2">
<Value>providerName</Value>
</Value>
<Value name="3">
<Value>npi</Value>
</Value>
<Value name="4">
<Value>dea</Value>
</Value>
<Value name="5">
<Value>specialtyConceptId</Value>
</Value>
<Value name="6">
<Value>careSiteId</Value>
</Value>
<Value name="7">
<Value>yearOfBirth</Value>
</Value>
<Value name="8">
<Value>genderConceptId</Value>
</Value>
<Value name="9">
<Value>providerSourceValue</Value>
</Value>
<Value name="10">
<Value>specialtySourceValue</Value>
</Value>
<Value name="11">
<Value>specialtySourceConceptId</Value>
</Value>
<Value name="12">
<Value>genderSourceValue</Value>
</Value>
<Value name="13">
<Value>genderSourceConceptId</Value>
</Value>
<Value name="14">
<Value>careSiteName</Value>
</Value>
<Value name="15">
<Value>placeOfServiceConceptId</Value>
</Value>
<Value name="16">
<Value>locationId</Value>
</Value>
<Value name="17">
<Value>careSiteSourceValue</Value>
</Value>
<Value name="18">
<Value>placeOfServiceSourceValue</Value>
</Value>
</Data>
<DefaultData>saveCareSiteInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
