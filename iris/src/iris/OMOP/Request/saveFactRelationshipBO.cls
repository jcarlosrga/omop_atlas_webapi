Class OMOP.Request.saveFactRelationshipBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveDrugExposureBO";

Property domainConceptId1 As %String(MAXLEN = "", XMLNAME = "domain_concept_id_1");

Property factId1 As %String(MAXLEN = "", XMLNAME = "fact_id_1");

Property domainConceptId2 As %String(MAXLEN = "", XMLNAME = "domain_concept_id_2");

Property factId2 As %String(MAXLEN = "", XMLNAME = "fact_id_2");

Property relationshipConceptId As %String(MAXLEN = "", XMLNAME = "relationship_concept_id");

Storage Default
{
<Data name="saveFactRelationshipBODefaultData">
<Subscript>"saveFactRelationshipBO"</Subscript>
<Value name="1">
<Value>domainConceptId1</Value>
</Value>
<Value name="2">
<Value>factId1</Value>
</Value>
<Value name="3">
<Value>domainConceptId2</Value>
</Value>
<Value name="4">
<Value>factId2</Value>
</Value>
<Value name="5">
<Value>relationshipConceptId</Value>
</Value>
</Data>
<DefaultData>saveFactRelationshipBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
