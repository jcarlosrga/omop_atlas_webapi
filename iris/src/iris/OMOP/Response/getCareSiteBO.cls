Class OMOP.Response.getCareSiteBO Extends Ens.Response
{

Property CareSiteId As %String(MAXLEN = "", XMLNAME = "care_site_id");

Storage Default
{
<Data name="getCareSiteBODefaultData">
<Subscript>"getCareSiteBO"</Subscript>
<Value name="1">
<Value>CareProviderId</Value>
</Value>
<Value name="2">
<Value>CareSiteId</Value>
</Value>
</Data>
<DefaultData>getCareSiteBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
