Class OMOP.Request.getPatientLocationBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getPatientLocationBO";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Storage Default
{
<Data name="getPatientLocationBODefaultData">
<Subscript>"getPatientLocationBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>getPatientLocationBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
