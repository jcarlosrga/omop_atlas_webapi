Class OMOP.Response.createProcedureOccurence Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Storage Default
{
<Data name="createProcedureOccurenceDefaultData">
<Subscript>"createProcedureOccurence"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
</Data>
<DefaultData>createProcedureOccurenceDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
