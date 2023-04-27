Class OMOP.Request.createObservationPeriod Extends Ens.Request
{

// Parameter RESPONSECLASSNAME = "OMOP.Response.createObservationPeriod";

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Storage Default
{
<Data name="createObservationPeriodDefaultData">
<Subscript>"createObservationPeriod"</Subscript>
<Value name="1">
<Value>personId</Value>
</Value>
</Data>
<DefaultData>createObservationPeriodDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
