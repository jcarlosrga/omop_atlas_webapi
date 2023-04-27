Class OMOP.Response.createEventTable Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Storage Default
{
<Data name="createEventTableDefaultData">
<Subscript>"createEventTable"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
</Data>
<DefaultData>createEventTableDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
