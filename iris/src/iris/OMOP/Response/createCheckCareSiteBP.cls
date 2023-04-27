Class OMOP.Response.createCheckCareSiteBP Extends Ens.Response
{

Property careSiteId As %String(MAXLEN = "", XMLNAME = "care_site_id");

Property careLocationId As %String(MAXLEN = "", XMLNAME = "care_location_id");

Storage Default
{
<Data name="createCheckCareSiteBPDefaultData">
<Subscript>"createCheckCareSiteBP"</Subscript>
<Value name="1">
<Value>providerId</Value>
</Value>
<Value name="2">
<Value>careSiteId</Value>
</Value>
<Value name="3">
<Value>careLocationId</Value>
</Value>
</Data>
<DefaultData>createCheckCareSiteBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
