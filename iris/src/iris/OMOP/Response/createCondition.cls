Class OMOP.Response.createCondition Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Storage Default
{
<Data name="createConditionDefaultData">
<Subscript>"createCondition"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
</Data>
<DefaultData>createConditionDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
