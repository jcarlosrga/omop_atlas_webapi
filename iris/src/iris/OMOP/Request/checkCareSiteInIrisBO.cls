Class OMOP.Request.checkCareSiteInIrisBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.checkCareSiteInIrisBO";

Property sourceValue As %String(MAXLEN = "", XMLNAME = "source_value");

Storage Default
{
<Data name="checkCareSiteInIrisBODefaultData">
<Subscript>"checkCareSiteInIrisBO"</Subscript>
<Value name="1">
<Value>locationId</Value>
</Value>
<Value name="2">
<Value>address1</Value>
</Value>
<Value name="3">
<Value>address2</Value>
</Value>
<Value name="4">
<Value>city</Value>
</Value>
<Value name="5">
<Value>state</Value>
</Value>
<Value name="6">
<Value>zip</Value>
</Value>
<Value name="7">
<Value>county</Value>
</Value>
<Value name="8">
<Value>locationSourceValue</Value>
</Value>
<Value name="9">
<Value>sourceValue</Value>
</Value>
</Data>
<DefaultData>checkCareSiteInIrisBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
