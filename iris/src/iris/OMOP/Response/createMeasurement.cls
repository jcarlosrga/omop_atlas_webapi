Class OMOP.Response.createMeasurement Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Storage Default
{
<Data name="createMeasurementDefaultData">
<Subscript>"createMeasurement"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
</Data>
<DefaultData>createMeasurementDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
