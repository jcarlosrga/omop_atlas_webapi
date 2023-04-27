Class OMOP.Request.createCheckCareSiteBP Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createCheckCareSiteBP";

Property careProviderId As %String(MAXLEN = "", XMLNAME = "care_provider_id");

/// special field to separate requests from different part of the production
Property source As %String(MAXLEN = "", XMLNAME = "source") [ InitialExpression = "0" ];

Storage Default
{
<Data name="createCheckCareSiteBPDefaultData">
<Subscript>"createCheckCareSiteBP"</Subscript>
<Value name="1">
<Value>careProviderId</Value>
</Value>
<Value name="2">
<Value>source</Value>
</Value>
</Data>
<DefaultData>createCheckCareSiteBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
