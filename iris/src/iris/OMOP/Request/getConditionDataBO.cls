Class OMOP.Request.getConditionDataBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getConditionDataBO";

Property patientId As %String(MAXLEN = "", XMLNAME = "patientId");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Storage Default
{
<Data name="getConditionDataBODefaultData">
<Subscript>"getConditionDataBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>visitOccurrenceId</Value>
</Value>
</Data>
<DefaultData>getConditionDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
