Class OMOP.Request.saveObservationPeriodBO Extends OMOP.Request.saveDataCommonBO
{

Property personId As %String;

Property startDate As %String;

Property endDate As %String;

Property periodTypeConceptId As %String;

Property observationPeriodId As %String;

Storage Default
{
<Data name="saveObservationPeriodBODefaultData">
<Subscript>"saveObservationPeriodBO"</Subscript>
<Value name="1">
<Value>personId</Value>
</Value>
<Value name="2">
<Value>startDate</Value>
</Value>
<Value name="3">
<Value>endDate</Value>
</Value>
<Value name="4">
<Value>periodTypeConceptId</Value>
</Value>
<Value name="5">
<Value>observationPeriodId</Value>
</Value>
</Data>
<DefaultData>saveObservationPeriodBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
