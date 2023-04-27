Class OMOP.Response.getPersonIdFromPostgreSQLBO Extends Ens.Response
{

Property personId As list Of %String(MAXLEN = "", XMLNAME = "person_id");

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
