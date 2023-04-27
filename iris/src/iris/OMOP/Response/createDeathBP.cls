Class OMOP.Response.createDeathBP Extends Ens.Response
{

Property deathId As %String(MAXLEN = "", XMLNAME = "deathId");

Storage Default
{
<Data name="createDeathBPDefaultData">
<Subscript>"createDeathBP"</Subscript>
<Value name="1">
<Value>deathId</Value>
</Value>
</Data>
<DefaultData>createDeathBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
