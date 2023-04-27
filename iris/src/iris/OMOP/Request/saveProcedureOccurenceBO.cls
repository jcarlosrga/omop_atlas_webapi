Class OMOP.Request.saveProcedureOccurenceBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveProcedureOccurenceBO";

Property procedureOccurrenceId As %String(MAXLEN = "", XMLNAME = "procedure_occurrence_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property procedureConceptId As %String(MAXLEN = "", XMLNAME = "procedure_concept_id");

Property procedureDate As %String(MAXLEN = "", XMLNAME = "procedure_date");

Property procedureDatetime As %String(MAXLEN = "", XMLNAME = "procedure_datetime");

Property procedureTypeConceptId As %String(MAXLEN = "", XMLNAME = "procedure_type_concept_id");

Property modifierConceptId As %String(MAXLEN = "", XMLNAME = "modifier_concept_id");

Property quantity As %String(MAXLEN = "", XMLNAME = "quantity");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Property procedureSourceValue As %String(MAXLEN = "", XMLNAME = "procedure_source_value");

Property procedureSourceConceptId As %String(MAXLEN = "", XMLNAME = "procedure_source_concept_id");

Property modifierSourceValue As %String(MAXLEN = "", XMLNAME = "modifier_source_value");

Storage Default
{
<Data name="saveProcedureOccurenceBODefaultData">
<Subscript>"saveProcedureOccurenceBO"</Subscript>
<Value name="1">
<Value>procedureOccurrenceId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
<Value name="3">
<Value>procedureConceptId</Value>
</Value>
<Value name="4">
<Value>procedureDate</Value>
</Value>
<Value name="5">
<Value>procedureDatetime</Value>
</Value>
<Value name="6">
<Value>procedureTypeConceptId</Value>
</Value>
<Value name="7">
<Value>modifierConceptId</Value>
</Value>
<Value name="8">
<Value>quantity</Value>
</Value>
<Value name="9">
<Value>providerId</Value>
</Value>
<Value name="10">
<Value>visitOccurrenceId</Value>
</Value>
<Value name="11">
<Value>visitDetailId</Value>
</Value>
<Value name="12">
<Value>procedureSourceValue</Value>
</Value>
<Value name="13">
<Value>procedureSourceСonceptId</Value>
</Value>
<Value name="14">
<Value>modifierSourceValue</Value>
</Value>
<Value name="15">
<Value>procedureSourceConceptId</Value>
</Value>
</Data>
<DefaultData>saveProcedureOccurenceBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

