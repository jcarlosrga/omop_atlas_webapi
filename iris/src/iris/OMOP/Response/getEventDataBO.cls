Class OMOP.Response.getEventDataBO Extends Ens.Response
{

Property events As list Of OMOP.Proxy.eventItem;

Storage Default
{
<Data name="getEventDataBODefaultData">
<Subscript>"getEventDataBO"</Subscript>
<Value name="1">
<Value>occurencies</Value>
</Value>
<Value name="2">
<Value>events</Value>
</Value>
</Data>
<DefaultData>getEventDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
