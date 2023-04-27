Class OMOP.Request.getCareSiteInfoBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getCareSiteInfoBO";

Property careProviderId As %String(MAXLEN = "");

Property source As %String(MAXLEN = "");

Storage Default
{
<Data name="getCareSiteInfoBODefaultData">
<Subscript>"getCareSiteInfoBO"</Subscript>
<Value name="1">
<Value>careProviderId</Value>
</Value>
<Value name="2">
<Value>source</Value>
</Value>
</Data>
<DefaultData>getCareSiteInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
