Class OMOP.Request.getDeviceExposureDataBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getDrugExposureBO";

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Storage Default
{
<Data name="getDeviceExposureDataBODefaultData">
<Subscript>"getDeviceExposureDataBO"</Subscript>
<Value name="1">
<Value>visitOccurrenceId</Value>
</Value>
</Data>
<DefaultData>getDeviceExposureDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
