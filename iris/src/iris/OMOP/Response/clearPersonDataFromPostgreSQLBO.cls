Class OMOP.Response.clearPersonDataFromPostgreSQLBO Extends Ens.Response
{

Property personId As list Of %String(MAXLEN = "", XMLNAME = "person_id");

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
