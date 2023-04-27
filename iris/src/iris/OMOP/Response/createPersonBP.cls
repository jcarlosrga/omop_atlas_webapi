Class OMOP.Response.createPersonBP Extends Ens.Response
{

Property personId As %String(MAXLEN = "", XMLNAME = "personId");

Storage Default
{
<Data name="createPersonBPDefaultData">
<Subscript>"createPersonBP"</Subscript>
<Value name="1">
<Value>providerId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
</Data>
<DefaultData>createPersonBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
