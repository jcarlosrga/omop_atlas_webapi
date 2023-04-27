Class OMOP.Request.getDrugExposureDataBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getDrugExposureBO";

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Storage Default
{
<Data name="getDrugExposureDataBODefaultData">
<Subscript>"getDrugExposureDataBO"</Subscript>
<Value name="1">
<Value>visitOccurrenceId</Value>
</Value>
</Data>
<DefaultData>getDrugExposureDataBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
