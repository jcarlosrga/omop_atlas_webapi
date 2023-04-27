Class OMOP.Request.checkLocationInIrisBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.checkLocationInIrisBO";

Property sourceValue As %String(MAXLEN = "", XMLNAME = "source_value");

Storage Default
{
<Data name="checkLocationInIrisBODefaultData">
<Subscript>"checkLocationInIrisBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>sourceValue</Value>
</Value>
</Data>
<DefaultData>checkLocationInIrisBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
