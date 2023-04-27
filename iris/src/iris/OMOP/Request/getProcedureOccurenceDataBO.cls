Class OMOP.Request.getProcedureOccurenceDataBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getProcedureOccurenceBO";

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Storage Default
{
<Data name="getProcedureOccurenceDataBODefaultData">
<Subscript>"getProcedureOccurenceDataBO"</Subscript>
<Value name="1">
<Value>visitOccurrenceId</Value>
</Value>
</Data>
<DefaultData>getProcedureOccurenceDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
