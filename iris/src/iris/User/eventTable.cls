/// 
/// 20211025 Denis Bulashev
/// temporarly table for events
/// 
Class User.eventTable Extends %Persistent [ ClassType = persistent, DdlAllowed, Final, ProcedureBlock ]
{

Property encounter As %String(MAXLEN = "", XMLNAME = "encounter");

Property eventConceptId As %String(MAXLEN = "", XMLNAME = "event_concept_id");

Property eventSourceValue As %String(MAXLEN = "", XMLNAME = "event_source_value");

Property eventStartTime As %String(MAXLEN = "", XMLNAME = "event_start_time");

Property eventEndTime As %String(MAXLEN = "", XMLNAME = "event_end_time");

Property eventEnteredonDate As %String(MAXLEN = "", XMLNAME = "event_enteredon_date");

Property providerName As %String(MAXLEN = "", XMLNAME = "provider_name");

Property qualifierConceptId As %String(MAXLEN = "", XMLNAME = "qualifier_concept_id");

Property qualifierSourceValue As %String(MAXLEN = "", XMLNAME = "qualifier_source_value");

Property unitConceptId As %String(MAXLEN = "", XMLNAME = "unit_concept_id");

Property unitSourceValue As %String(MAXLEN = "", XMLNAME = "unit_source_value");

Property routeSourceValue As %String(MAXLEN = "", XMLNAME = "route_source_value");

Property valueAsConceptId As %String(MAXLEN = "", XMLNAME = "value_as_concept_id");

Property valueSourceValue As %String(MAXLEN = "", XMLNAME = "value_source_value");

Property quantity As %String(MAXLEN = "", XMLNAME = "quantity");

Property sourceTable As %String(MAXLEN = "", XMLNAME = "source_table");

Property sourceId As %String(MAXLEN = "", XMLNAME = "source_id");

Property note As %String(MAXLEN = "", XMLNAME = "note");

Property modifierConceptId As %String(MAXLEN = "", XMLNAME = "MODIFIERCONCEPTID");

Property modifierSourceValue As %String(MAXLEN = "", XMLNAME = "modifierSourceValue");

Property routeConceptId As %String(MAXLEN = "", XMLNAME = "ROUTECONCEPTID");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property valueAsNumber As %String(MAXLEN = "", XMLNAME = "value_as_number");

Property rangeLow As %String(MAXLEN = "", XMLNAME = "range_low");

Property rangeHigh As %String(MAXLEN = "", XMLNAME = "range_high");

Storage Default
{
<Data name="eventTableDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>encounter</Value>
</Value>
<Value name="3">
<Value>eventConceptId</Value>
</Value>
<Value name="4">
<Value>eventSourceValue</Value>
</Value>
<Value name="5">
<Value>eventStartTime</Value>
</Value>
<Value name="6">
<Value>eventEndTime</Value>
</Value>
<Value name="7">
<Value>eventEnteredonDate</Value>
</Value>
<Value name="8">
<Value>providerName</Value>
</Value>
<Value name="9">
<Value>qualifierConceptId</Value>
</Value>
<Value name="10">
<Value>qualifierSourceValue</Value>
</Value>
<Value name="11">
<Value>unitConceptId</Value>
</Value>
<Value name="12">
<Value>unitSourceValue</Value>
</Value>
<Value name="13">
<Value>routeSourceValue</Value>
</Value>
<Value name="14">
<Value>valueAsConceptId</Value>
</Value>
<Value name="15">
<Value>valueSourceValue</Value>
</Value>
<Value name="16">
<Value>quantity</Value>
</Value>
<Value name="17">
<Value>sourceTable</Value>
</Value>
<Value name="18">
<Value>sourceId</Value>
</Value>
<Value name="19">
<Value>note</Value>
</Value>
<Value name="20">
<Value>modifierConceptId</Value>
</Value>
<Value name="21">
<Value>modifierSourceValue</Value>
</Value>
<Value name="22">
<Value>modifierSourceValue</Value>
</Value>
<Value name="23">
<Value>routeConceptId</Value>
</Value>
<Value name="24">
<Value>personId</Value>
</Value>
<Value name="25">
<Value>valueAsNumber</Value>
</Value>
<Value name="26">
<Value>rangeLow</Value>
</Value>
<Value name="27">
<Value>rangeHigh</Value>
</Value>
</Data>
<DataLocation>^User.eventTableD</DataLocation>
<DefaultData>eventTableDefaultData</DefaultData>
<IdLocation>^User.eventTableD</IdLocation>
<IndexLocation>^User.eventTableI</IndexLocation>
<StreamLocation>^User.eventTableS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

Index encounterind On encounter [ SqlName = encounter_ind, Type = index ];

Index personIdind On personId [ SqlName = personId_ind, Type = index ];

Index personidindx On personId [ SqlName = person_id_indx, Type = index ];

Index sourceTableind On sourceTable [ SqlName = sourceTable_ind, Type = index ];

}

