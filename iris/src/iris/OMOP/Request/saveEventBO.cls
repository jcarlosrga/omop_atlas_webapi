Class OMOP.Request.saveEventBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveEventBO";

Property encounter As %String(MAXLEN = "", XMLNAME = "Encounter");

Property eventConceptId As %String(MAXLEN = "", XMLNAME = "event_concept_id");

Property eventSourceValue As %String(MAXLEN = "", XMLNAME = "event_source_value");

Property eventStartTime As %String(MAXLEN = "", XMLNAME = "event_start_time");

Property eventEndTime As %String(MAXLEN = "", XMLNAME = "event_end_time");

Property providerName As %String(MAXLEN = "", XMLNAME = "provider_name");

Property qualifierConceptId As %String(MAXLEN = "", XMLNAME = "qualifier_concept_id");

Property qualifierSourceValue As %String(MAXLEN = "", XMLNAME = "qualifier_source_value");

Property unitSourceValue As %String(MAXLEN = "", XMLNAME = "unit_source_value");

Property unitConceptId As %String(MAXLEN = "", XMLNAME = "unit_concept_id");

Property modifierConceptId As %String(MAXLEN = "", XMLNAME = "modifier_concept_id");

Property modifierSourceValue As %String(MAXLEN = "", XMLNAME = "modifier_source_value");

Property routeConceptId As %String(MAXLEN = "", XMLNAME = "route_concept_id");

Property routeSourceValue As %String(MAXLEN = "", XMLNAME = "route_source_value");

Property valueAsConceptId As %String(MAXLEN = "", XMLNAME = "value_as_concept_id");

Property valueSourceValue As %String(MAXLEN = "", XMLNAME = "value_source_value");

Property sourceTable As %String(MAXLEN = "", XMLNAME = "source_table");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property note As %String(MAXLEN = "", XMLNAME = "note");

Property quantity As %String(MAXLEN = "", XMLNAME = "quantity");

Property sourceId As %String(MAXLEN = "", XMLNAME = "source_id");

Property valueAsNumber As %String(MAXLEN = "", XMLNAME = "value_as_number");

Property rangeLow As %String(MAXLEN = "", XMLNAME = "range_low");

Property rangeHigh As %String(MAXLEN = "", XMLNAME = "range_high");

Storage Default
{
<Data name="saveEventBODefaultData">
<Subscript>"saveEventBO"</Subscript>
<Value name="1">
<Value>encounter</Value>
</Value>
<Value name="2">
<Value>eventConceptId</Value>
</Value>
<Value name="3">
<Value>eventSourceValue</Value>
</Value>
<Value name="4">
<Value>eventStartTime</Value>
</Value>
<Value name="5">
<Value>eventEndTime</Value>
</Value>
<Value name="6">
<Value>providerName</Value>
</Value>
<Value name="7">
<Value>qualifierConceptId</Value>
</Value>
<Value name="8">
<Value>qualifierSourceValue</Value>
</Value>
<Value name="9">
<Value>unitSourceValue</Value>
</Value>
<Value name="10">
<Value>unitConceptId</Value>
</Value>
<Value name="11">
<Value>modifierConceptId</Value>
</Value>
<Value name="12">
<Value>modifierSourceValue</Value>
</Value>
<Value name="13">
<Value>routeConceptId</Value>
</Value>
<Value name="14">
<Value>routeSourceValue</Value>
</Value>
<Value name="15">
<Value>valueAsConceptId</Value>
</Value>
<Value name="16">
<Value>valueSourceValue</Value>
</Value>
<Value name="17">
<Value>sourceTable</Value>
</Value>
<Value name="18">
<Value>patientId</Value>
</Value>
<Value name="19">
<Value>personId</Value>
</Value>
<Value name="20">
<Value>note</Value>
</Value>
<Value name="21">
<Value>quantity</Value>
</Value>
<Value name="22">
<Value>sourceId</Value>
</Value>
<Value name="23">
<Value>valueAsNumber</Value>
</Value>
<Value name="24">
<Value>rangeLow</Value>
</Value>
<Value name="25">
<Value>rangeHigh</Value>
</Value>
</Data>
<DefaultData>saveEventBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

