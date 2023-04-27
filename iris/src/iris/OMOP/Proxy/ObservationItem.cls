Class OMOP.Proxy.ObservationItem Extends (%Persistent, %XML.Adaptor)
{

Property ID As %String(MAXLEN = "", XMLNAME = "ID");

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

Property personId As %String(MAXLEN = "", XMLNAME = "note");

Property modifierConceptId As %String(MAXLEN = "", XMLNAME = "modifier_concept_id");

Property modifierSourceValue As %String(MAXLEN = "", XMLNAME = "modifier_source_value");

Property routeConceptId As %String(MAXLEN = "", XMLNAME = "route_concept_id");

Storage Default
{
<Data name="ObservationItemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ID</Value>
</Value>
<Value name="3">
<Value>encounter</Value>
</Value>
<Value name="4">
<Value>eventConceptId</Value>
</Value>
<Value name="5">
<Value>eventEndTime</Value>
</Value>
<Value name="6">
<Value>eventSourceValue</Value>
</Value>
<Value name="7">
<Value>eventStartTime</Value>
</Value>
<Value name="8">
<Value>modifierConceptId</Value>
</Value>
<Value name="9">
<Value>modifierSourceValue</Value>
</Value>
<Value name="10">
<Value>providerName</Value>
</Value>
<Value name="11">
<Value>qualifierConceptId</Value>
</Value>
<Value name="12">
<Value>qualifierSourceValue</Value>
</Value>
<Value name="13">
<Value>routeConceptId</Value>
</Value>
<Value name="14">
<Value>routeSourceValue</Value>
</Value>
<Value name="15">
<Value>sourceTable</Value>
</Value>
<Value name="16">
<Value>unitConceptId</Value>
</Value>
<Value name="17">
<Value>unitSourceValue</Value>
</Value>
<Value name="18">
<Value>valueAsConceptId</Value>
</Value>
<Value name="19">
<Value>valueSourceValue</Value>
</Value>
<Value name="20">
<Value>eventEnteredonDate</Value>
</Value>
<Value name="21">
<Value>quantity</Value>
</Value>
<Value name="22">
<Value>sourceId</Value>
</Value>
<Value name="23">
<Value>note</Value>
</Value>
<Value name="24">
<Value>personId</Value>
</Value>
</Data>
<DataLocation>^OMOP.Proxy.ObservationItemD</DataLocation>
<DefaultData>ObservationItemDefaultData</DefaultData>
<IdLocation>^OMOP.Proxy.ObservationItemD</IdLocation>
<IndexLocation>^OMOP.Proxy.ObservationItemI</IndexLocation>
<StreamLocation>^OMOP.Proxy.ObservationItemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

