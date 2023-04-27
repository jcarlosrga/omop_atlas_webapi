Class OMOP.Request.getPatientIdFromPostgreSQLBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getCareProviderBO";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Storage Default
{
<Data name="getPatientIdFromPostgreSQLBODefaultData">
<Subscript>"getPatientIdFromPostgreSQLBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>getPatientIdFromPostgreSQLBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
