Class OMOP.Response.checkCareProviderInIrisBO Extends Ens.Response
{

Property careProviderId As %String(MAXLEN = "", XMLNAME = "care_provider_id");

Storage Default
{
<Data name="checkCareProviderInIrisBODefaultData">
<Subscript>"checkCareProviderInIrisBO"</Subscript>
<Value name="1">
<Value>careProviderId</Value>
</Value>
</Data>
<DefaultData>checkCareProviderInIrisBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
