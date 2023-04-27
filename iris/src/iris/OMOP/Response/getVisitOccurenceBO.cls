Class OMOP.Response.getVisitOccurenceBO Extends Ens.Response
{

Property occurencies As list Of OMOP.Proxy.visitOccurenceItem(XMLNAME = "occurency_list");

Storage Default
{
<Data name="getVisitOccurenceBODefaultData">
<Subscript>"getVisitOccurenceBO"</Subscript>
<Value name="1">
<Value>occurencies</Value>
</Value>
<Value name="2">
<Value>test</Value>
</Value>
<Value name="3">
<Value>NewProperty1</Value>
</Value>
</Data>
<DefaultData>getVisitOccurenceBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
