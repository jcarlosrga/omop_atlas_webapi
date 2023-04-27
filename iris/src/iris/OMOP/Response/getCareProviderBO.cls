Class OMOP.Response.getCareProviderBO Extends Ens.Response
{

Property CareProviderId As %String(MAXLEN = "", XMLNAME = "care_provider_id");

Storage Default
{
<Data name="getCareProviderBODefaultData">
<Subscript>"getCareProviderBO"</Subscript>
<Value name="1">
<Value>CareProviderId</Value>
</Value>
</Data>
<DefaultData>getCareProviderBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
