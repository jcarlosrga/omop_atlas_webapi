Class OMOP.Response.createDrugExposure Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Storage Default
{
<Data name="createDrugExposureDefaultData">
<Subscript>"createDrugExposure"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
</Data>
<DefaultData>createDrugExposureDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
