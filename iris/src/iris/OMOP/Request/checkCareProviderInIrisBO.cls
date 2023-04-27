Class OMOP.Request.checkCareProviderInIrisBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.checkCareProviderInIrisBO";

Property providerSourceValue As %String(MAXLEN = "", XMLNAME = "provider_source_value");

Storage Default
{
<Data name="checkCareProviderInIrisBODefaultData">
<Subscript>"checkCareProviderInIrisBO"</Subscript>
<Value name="1">
<Value>careProviderId</Value>
</Value>
<Value name="2">
<Value>providerSourceValue</Value>
</Value>
</Data>
<DefaultData>checkCareProviderInIrisBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
