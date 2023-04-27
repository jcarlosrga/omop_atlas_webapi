Class OMOP.Request.clearPersonDataFromPostgreSQLBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.clearPersonDataFromPostgreSQLBO";

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Storage Default
{
<Data name="clearPersonDataFromPostgreSQLBODefaultData">
<Subscript>"clearPersonDataFromPostgreSQLBO"</Subscript>
<Value name="1">
<Value>personId</Value>
</Value>
</Data>
<DefaultData>clearPersonDataFromPostgreSQLBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
