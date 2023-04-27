Class OMOP.Request.getPersonIdFromPostgreSQLBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getPersonIdFromPostgreSQLBO";

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Storage Default
{
<Data name="getPersonIdFromPostgreSQLBODefaultData">
<Subscript>"getPersonIdFromPostgreSQLBO"</Subscript>
<Value name="1">
<Value>personId</Value>
</Value>
</Data>
<DefaultData>getPersonIdFromPostgreSQLBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
