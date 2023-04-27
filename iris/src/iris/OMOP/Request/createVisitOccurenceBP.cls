Class OMOP.Request.createVisitOccurenceBP Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.createVisitOccurenceBP";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Property personId As %String(MAXLEN = "", XMLNAME = "personId");

Property providerId As %String(MAXLEN = "", XMLNAME = "providerId");

Property careSiteId As %String(MAXLEN = "", XMLNAME = "careSiteId");

Storage Default
{
<Data name="createVisitOccurenceBPDefaultData">
<Subscript>"createVisitOccurenceBP"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
<Value name="3">
<Value>providerId</Value>
</Value>
<Value name="4">
<Value>careSiteId</Value>
</Value>
</Data>
<DefaultData>createVisitOccurenceBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
