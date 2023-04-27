Class OMOP.Response.createDeviceExposure Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Storage Default
{
<Data name="createDeviceExposureDefaultData">
<Subscript>"createDeviceExposure"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
</Data>
<DefaultData>createDeviceExposureDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
