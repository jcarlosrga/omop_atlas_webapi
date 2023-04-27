Class OMOP.Response.SendSQL Extends Ens.Response
{

Property json As %Library.DynamicObject;

Storage Default
{
<Data name="SendSQLDefaultData">
<Subscript>"SendSQL"</Subscript>
<Value name="1">
<Value>SQL</Value>
</Value>
</Data>
<Data name="json">
<Attribute>json</Attribute>
<Structure>node</Structure>
<Subscript>"OMOP.Response.SendSQL.json"</Subscript>
</Data>
<DefaultData>SendSQLDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
