Class OMOP.Request.getSiteCareSiteBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getCareSiteBO";

Property careProviderId As %String(MAXLEN = "", XMLNAME = "care_provider_id");

Storage Default
{
<Data name="getSiteCareSiteBODefaultData">
<Subscript>"getSiteCareSiteBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>careProviderId</Value>
</Value>
</Data>
<DefaultData>getSiteCareSiteBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
