Class OMOP.Request.getCareSiteBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getCareSiteBO";

Property careProviderId As %String(MAXLEN = "", XMLNAME = "care_provider_id");

Storage Default
{
<Data name="getCareSiteBODefaultData">
<Subscript>"getCareSiteBO"</Subscript>
<Value name="1">
<Value>careProviderId</Value>
</Value>
</Data>
<DefaultData>getCareSiteBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
