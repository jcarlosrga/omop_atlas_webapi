Class OMOP.Response.getPatientIdFromPostgreSQLBO Extends Ens.Response
{

Property personId As %String(MAXLEN = "", XMLNAME = "care_provider_id");

Storage Default
{
<Data name="getPatientIdFromPostgreSQLBODefaultData">
<Subscript>"getPatientIdFromPostgreSQLBO"</Subscript>
<Value name="1">
<Value>personId</Value>
</Value>
</Data>
<DefaultData>getPatientIdFromPostgreSQLBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
