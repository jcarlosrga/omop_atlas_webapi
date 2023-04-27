Class OMOP.Proxy.factRelationshipConcepttem Extends (%Persistent, %XML.Adaptor)
{

Property factId1 As %String(MAXLEN = "", XMLNAME = "fact_id_1");

Property factId2 As %String(MAXLEN = "", XMLNAME = "fact_id_2");

Property domainConceptId1 As %String(MAXLEN = "", XMLNAME = "domain_concept_id_1");

Property domainConceptId2 As %String(MAXLEN = "", XMLNAME = "domain_concept_id_2");

Property relationshipConceptId As %String(MAXLEN = "", XMLNAME = "relationship_concept_id");

Storage Default
{
<Data name="factRelationshipConcepttemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>factId1</Value>
</Value>
<Value name="3">
<Value>factId2</Value>
</Value>
<Value name="4">
<Value>domainConceptId1</Value>
</Value>
<Value name="5">
<Value>domainConceptId2</Value>
</Value>
<Value name="6">
<Value>relationshipConceptId</Value>
</Value>
</Data>
<DataLocation>^OMOP.Proxy.factRelatioE1E5D</DataLocation>
<DefaultData>factRelationshipConcepttemDefaultData</DefaultData>
<IdLocation>^OMOP.Proxy.factRelatioE1E5D</IdLocation>
<IndexLocation>^OMOP.Proxy.factRelatioE1E5I</IndexLocation>
<StreamLocation>^OMOP.Proxy.factRelatioE1E5S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
