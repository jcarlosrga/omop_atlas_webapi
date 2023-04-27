Class OMOP.Response.checkLocationInIrisBO Extends Ens.Response
{

Property locationExists As %String(MAXLEN = "", XMLNAME = "location_exists");

Storage Default
{
<Data name="checkLocationInIrisBODefaultData">
<Subscript>"checkLocationInIrisBO"</Subscript>
<Value name="1">
<Value>locationExists</Value>
</Value>
</Data>
<DefaultData>checkLocationInIrisBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
