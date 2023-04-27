Class OMOP.Request.getCareProviderBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getCareProviderBO";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Storage Default
{
<Data name="getCareProviderBODefaultData">
<Subscript>"getCareProviderBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>getCareProviderBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
