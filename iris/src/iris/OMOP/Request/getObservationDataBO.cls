Class OMOP.Request.getObservationDataBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getObservationDataBO";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Storage Default
{
<Data name="getObservationDataBODefaultData">
<Subscript>"getObservationDataBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>visitOccurrenceId</Value>
</Value>
</Data>
<DefaultData>getObservationDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
