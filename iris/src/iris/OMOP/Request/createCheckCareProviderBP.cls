Class OMOP.Request.createCheckCareProviderBP Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createCheckCareProviderBP";

/// for search in BayState database
Property careProviderId As %String(MAXLEN = "", XMLNAME = "care_provider_id");

/// for saving in IRIS database
Property careSiteIdIRIS As %String(MAXLEN = "", XMLNAME = "care_site_id_iris");

Storage Default
{
<Data name="createCheckCareProviderBPDefaultData">
<Subscript>"createCheckCareProviderBP"</Subscript>
<Value name="1">
<Value>careProviderId</Value>
</Value>
<Value name="2">
<Value>careProviderIdIRIS</Value>
</Value>
<Value name="3">
<Value>careSiteIdIRIS</Value>
</Value>
</Data>
<DefaultData>createCheckCareProviderBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
