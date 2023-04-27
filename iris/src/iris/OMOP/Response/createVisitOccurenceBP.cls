Class OMOP.Response.createVisitOccurenceBP Extends Ens.Response
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Storage Default
{
<Data name="createVisitOccurenceBPDefaultData">
<Subscript>"createVisitOccurenceBP"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
<Value name="2">
<Value>addressCityCode</Value>
</Value>
<Value name="3">
<Value>addressCityDescription</Value>
</Value>
<Value name="4">
<Value>addressStateCode</Value>
</Value>
<Value name="5">
<Value>addressStreet</Value>
</Value>
<Value name="6">
<Value>addressZipCode</Value>
</Value>
<Value name="7">
<Value>addressCountRyCode</Value>
</Value>
<Value name="8">
<Value>visitOccurrenceId</Value>
</Value>
<Value name="9">
<Value>visitDetailId</Value>
</Value>
</Data>
<DefaultData>createVisitOccurenceBPDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
