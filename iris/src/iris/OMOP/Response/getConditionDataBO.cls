Class OMOP.Response.getConditionDataBO Extends Ens.Response
{

Property conditions As list Of OMOP.Proxy.conditionItem;

Storage Default
{
<Data name="getConditionDataBODefaultData">
<Subscript>"getConditionDataBO"</Subscript>
<Value name="1">
<Value>events</Value>
</Value>
<Value name="2">
<Value>conditions</Value>
</Value>
</Data>
<DefaultData>getConditionDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
