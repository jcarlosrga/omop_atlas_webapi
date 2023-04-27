Class OMOP.Request.saveDataCommonBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveDataCommonBP";

Property target As %String(MAXLEN = "", XMLNAME = "Target");

Property type As %String(MAXLEN = "", XMLNAME = "Type");

Storage Default
{
<Data name="saveDataCommonBODefaultData">
<Subscript>"saveDataCommonBO"</Subscript>
<Value name="1">
<Value>Target</Value>
</Value>
<Value name="2">
<Value>target</Value>
</Value>
<Value name="3">
<Value>type</Value>
</Value>
</Data>
<DefaultData>saveDataCommonBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
