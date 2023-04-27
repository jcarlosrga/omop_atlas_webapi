Class OMOP.Request.clearEventDataBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "Ens.Response";

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Storage Default
{
<Data name="clearEventDataBODefaultData">
<Subscript>"clearEventDataBO"</Subscript>
<Value name="1">
<Value>personId</Value>
</Value>
</Data>
<DefaultData>clearEventDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
