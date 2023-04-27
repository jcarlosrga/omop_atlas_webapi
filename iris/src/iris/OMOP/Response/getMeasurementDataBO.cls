Class OMOP.Response.getMeasurementDataBO Extends Ens.Response
{

Property conditions As list Of OMOP.Proxy.conditionItem;

Storage Default
{
<Data name="getMeasurementDataBODefaultData">
<Subscript>"getMeasurementDataBO"</Subscript>
<Value name="1">
<Value>conditions</Value>
</Value>
</Data>
<DefaultData>getMeasurementDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
