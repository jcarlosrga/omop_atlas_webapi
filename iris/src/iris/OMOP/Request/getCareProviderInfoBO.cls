Class OMOP.Request.getCareProviderInfoBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getCareProviderInfoBO";

Property careProviderId As %String(MAXLEN = "");

Storage Default
{
<Data name="getCareProviderInfoBODefaultData">
<Subscript>"getCareProviderInfoBO"</Subscript>
<Value name="1">
<Value>careProvider</Value>
</Value>
<Value name="2">
<Value>careProviderId</Value>
</Value>
</Data>
<DefaultData>getCareProviderInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
