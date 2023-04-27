Class OMOP.Request.createFactRelationshipConceptId Extends Ens.Request
{

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Storage Default
{
<Data name="createFactRelationshipConceptIdDefaultData">
<Subscript>"createFactRelationshipConceptId"</Subscript>
<Value name="1">
<Value>personId</Value>
</Value>
</Data>
<DefaultData>createFactRelationshipConceptIdDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
