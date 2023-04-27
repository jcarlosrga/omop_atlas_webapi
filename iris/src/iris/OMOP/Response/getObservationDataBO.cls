Class OMOP.Response.getObservationDataBO Extends Ens.Response
{

Property conditions As list Of OMOP.Proxy.conditionItem;

Storage Default
{
<Data name="getObservationDataBODefaultData">
<Subscript>"getObservationDataBO"</Subscript>
<Value name="1">
<Value>conditions</Value>
</Value>
</Data>
<DefaultData>getObservationDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
