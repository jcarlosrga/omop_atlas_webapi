Class OMOP.Response.getProcedureOccurenceBO Extends Ens.Response
{

Property conditions As list Of OMOP.Proxy.conditionItem;

Storage Default
{
<Data name="getProcedureOccurenceBODefaultData">
<Subscript>"getProcedureOccurenceBO"</Subscript>
<Value name="1">
<Value>conditions</Value>
</Value>
</Data>
<DefaultData>getProcedureOccurenceBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
