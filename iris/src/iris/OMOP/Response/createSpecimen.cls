Class OMOP.Response.createSpecimen Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Storage Default
{
<Data name="createSpecimenDefaultData">
<Subscript>"createSpecimen"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
</Data>
<DefaultData>createSpecimenDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
