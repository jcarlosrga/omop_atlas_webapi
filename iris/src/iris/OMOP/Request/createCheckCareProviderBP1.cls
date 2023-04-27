Class OMOP.Request.createCheckCareProviderBP1 Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getPatientLocationBP";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Storage Default
{
<Data name="createCheckCareProviderBP1DefaultData">
<Subscript>"createCheckCareProviderBP1"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>createCheckCareProviderBP1DefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
