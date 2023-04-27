Class OMOP.Response.createObservation Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Storage Default
{
<Data name="createObservationDefaultData">
<Subscript>"createObservation"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
</Data>
<DefaultData>createObservationDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
