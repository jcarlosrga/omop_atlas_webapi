Class OMOP.Request.getMeasurementDataBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getMeasurementDataBO";

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Storage Default
{
<Data name="getMeasurementDataBODefaultData">
<Subscript>"getMeasurementDataBO"</Subscript>
<Value name="1">
<Value>visitOccurrenceId</Value>
</Value>
</Data>
<DefaultData>getMeasurementDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
