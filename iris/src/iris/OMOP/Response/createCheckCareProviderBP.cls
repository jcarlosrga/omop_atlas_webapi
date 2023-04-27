Class OMOP.Response.createCheckCareProviderBP Extends Ens.Response
{

Property providerId As %String(MAXLEN = "", XMLNAME = "care_provider_id");

Storage Default
{
<Data name="createCheckCareProviderBPDefaultData">
<Subscript>"createCheckCareProviderBP"</Subscript>
<Value name="1">
<Value>locationId</Value>
</Value>
<Value name="2">
<Value>careProviderId</Value>
</Value>
<Value name="3">
<Value>providerId</Value>
</Value>
</Data>
<DefaultData>createCheckCareProviderBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
