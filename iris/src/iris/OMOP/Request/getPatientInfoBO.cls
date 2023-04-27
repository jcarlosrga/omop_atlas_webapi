Class OMOP.Request.getPatientInfoBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getPatientInfoBO";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Storage Default
{
<Data name="getPatientInfoBODefaultData">
<Subscript>"getPatientInfoBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>getPatientInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
