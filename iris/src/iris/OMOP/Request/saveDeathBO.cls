Class OMOP.Request.saveDeathBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.savePersonBO";

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property deathDate As %String(MAXLEN = "", XMLNAME = "death_date");

Property deathDatetime As %String(MAXLEN = "", XMLNAME = "death_datetime");

Property deathTypeConceptId As %String(MAXLEN = "", XMLNAME = "death_type_concept_id");

Property causeConceptId As %String(MAXLEN = "", XMLNAME = "cause_concept_id");

Property causeSourceValue As %String(MAXLEN = "", XMLNAME = "cause_source_value");

Property causeSourceConceptId As %String(MAXLEN = "", XMLNAME = "cause_source_concept_id");

Storage Default
{
<Data name="saveDeathBODefaultData">
<Subscript>"saveDeathBO"</Subscript>
<Value name="1">
<Value>personId</Value>
</Value>
<Value name="2">
<Value>deathDate</Value>
</Value>
<Value name="3">
<Value>deathDatetime</Value>
</Value>
<Value name="4">
<Value>deathTypeConceptId</Value>
</Value>
<Value name="5">
<Value>causeConceptId</Value>
</Value>
<Value name="6">
<Value>causeSourceValue</Value>
</Value>
<Value name="7">
<Value>causeSourceConceptId</Value>
</Value>
</Data>
<DefaultData>saveDeathBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
