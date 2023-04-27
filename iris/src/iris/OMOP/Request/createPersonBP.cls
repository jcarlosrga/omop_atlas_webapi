Class OMOP.Request.createPersonBP Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createPersonBP";

Property patinetId As %String(MAXLEN = "", XMLNAME = "patientId");

/// from previous steps
Property locationId As %String(MAXLEN = "", XMLNAME = "location_id");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property careSiteId As %String(MAXLEN = "", XMLNAME = "care_site_id");

Storage Default
{
<Data name="createPersonBPDefaultData">
<Subscript>"createPersonBP"</Subscript>
<Value name="1">
<Value>patinetId</Value>
</Value>
<Value name="2">
<Value>locationId</Value>
</Value>
<Value name="3">
<Value>providerId</Value>
</Value>
<Value name="4">
<Value>careSiteId</Value>
</Value>
</Data>
<DefaultData>createPersonBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
