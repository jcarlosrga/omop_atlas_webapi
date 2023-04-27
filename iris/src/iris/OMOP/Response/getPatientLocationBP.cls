Class OMOP.Response.getPatientLocationBP Extends Ens.Response
{

Property locationId As %String(MAXLEN = "", XMLNAME = "id");

Storage Default
{
<Data name="getPatientLocationBPDefaultData">
<Subscript>"getPatientLocationBP"</Subscript>
<Value name="1">
<Value>locationId</Value>
</Value>
</Data>
<DefaultData>getPatientLocationBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
