Class OMOP.Response.getDeviceExposureBO Extends Ens.Response
{

Property conditions As list Of OMOP.Proxy.conditionItem;

Storage Default
{
<Data name="getDeviceExposureBODefaultData">
<Subscript>"getDeviceExposureBO"</Subscript>
<Value name="1">
<Value>conditions</Value>
</Value>
</Data>
<DefaultData>getDeviceExposureBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
