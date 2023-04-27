Class OMOP.Request.checkCareLocationInfoBO Extends Ens.Response
{

Property locationId As %String(MAXLEN = "", XMLNAME = "location_id");

Storage Default
{
<Data name="checkCareLocationInfoBODefaultData">
<Subscript>"checkCareLocationInfoBO"</Subscript>
<Value name="1">
<Value>locationId</Value>
</Value>
</Data>
<DefaultData>checkCareLocationInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
