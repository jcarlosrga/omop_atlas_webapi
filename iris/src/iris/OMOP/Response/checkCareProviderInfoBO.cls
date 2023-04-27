Class OMOP.Response.checkCareProviderInfoBO Extends Ens.Response
{

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Storage Default
{
<Data name="checkCareProviderInfoBODefaultData">
<Subscript>"checkCareProviderInfoBO"</Subscript>
<Value name="1">
<Value>providerId</Value>
</Value>
</Data>
<DefaultData>checkCareProviderInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
