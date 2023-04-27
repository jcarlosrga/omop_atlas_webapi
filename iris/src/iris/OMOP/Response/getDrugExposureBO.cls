Class OMOP.Response.getDrugExposureBO Extends Ens.Response
{

Property conditions As list Of OMOP.Proxy.conditionItem;

Storage Default
{
<Data name="getDrugExposureBODefaultData">
<Subscript>"getDrugExposureBO"</Subscript>
<Value name="1">
<Value>conditions</Value>
</Value>
</Data>
<DefaultData>getDrugExposureBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
