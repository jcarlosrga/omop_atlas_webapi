Class OMOP.Response.createNote Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Storage Default
{
<Data name="createNoteDefaultData">
<Subscript>"createNote"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
</Data>
<DefaultData>createNoteDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
