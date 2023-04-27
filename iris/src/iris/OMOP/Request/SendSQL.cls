Class OMOP.Request.SendSQL Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.SendSQL";

Property SQL As %String(MAXLEN = "", XMLNAME = "SQL");

Storage Default
{
<Data name="SendSQLDefaultData">
<Subscript>"SendSQL"</Subscript>
<Value name="1">
<Value>SQL</Value>
</Value>
</Data>
<DefaultData>SendSQLDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
