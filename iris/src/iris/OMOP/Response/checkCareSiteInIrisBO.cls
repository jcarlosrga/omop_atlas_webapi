Class OMOP.Response.checkCareSiteInIrisBO Extends Ens.Response
{

Property careSiteId As %String(MAXLEN = "", XMLNAME = "care_site_id");

Storage Default
{
<Data name="checkCareSiteInIrisBODefaultData">
<Subscript>"checkCareSiteInIrisBO"</Subscript>
<Value name="1">
<Value>careSiteId</Value>
</Value>
</Data>
<DefaultData>checkCareSiteInIrisBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
