Class OMOP.Proxy.DeviceExposureItem Extends (%Persistent, %XML.Adaptor)
{

Property ID As %String(MAXLEN = "", XMLNAME = "ID");

Property encounter As %String(MAXLEN = "", XMLNAME = "encounter");

Property eventConceptId As %String(MAXLEN = "", XMLNAME = "eventConceptId");

Property eventEndTime As %String(MAXLEN = "", XMLNAME = "eventEndTime");

Property eventSourceValue As %String(MAXLEN = "", XMLNAME = "eventSourceValue");

Property eventStartTime As %String(MAXLEN = "", XMLNAME = "eventStartTime");

Property modifierConceptId As %String(MAXLEN = "", XMLNAME = "modifierConceptId");

Property modifierSourceValue As %String(MAXLEN = "", XMLNAME = "modifierSourceValue");

Property providerName As %String(MAXLEN = "", XMLNAME = "providerName");

Property qualifierConceptId As %String(MAXLEN = "", XMLNAME = "qualifierConceptId");

Property qualifierSourceValue As %String(MAXLEN = "", XMLNAME = "qualifierSourceValue");

Property routeConceptId As %String(MAXLEN = "", XMLNAME = "routeConceptId");

Property routeSourceValue As %String(MAXLEN = "", XMLNAME = "routeSourceValue");

Property sourceTable As %String(MAXLEN = "", XMLNAME = "sourceTable");

Property unitConceptId As %String(MAXLEN = "", XMLNAME = "unitConceptId");

Property unitSourceValue As %String(MAXLEN = "", XMLNAME = "unitSourceValue");

Property valueAsConceptId As %String(MAXLEN = "", XMLNAME = "valueAsConceptId");

Property valueSourceValue As %String(MAXLEN = "", XMLNAME = "valueSourceValue");

Storage Default
{
<Data name="DeviceExposureItemDefaultData">
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
</Data>
<DataLocation>^OMOP.Proxy.DeviceExposureItemD</DataLocation>
<DefaultData>DeviceExposureItemDefaultData</DefaultData>
<IdLocation>^OMOP.Proxy.DeviceExposureItemD</IdLocation>
<IndexLocation>^OMOP.Proxy.DeviceExposureItemI</IndexLocation>
<StreamLocation>^OMOP.Proxy.DeviceExposureItemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

