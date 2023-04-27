Class OMOP.Request.getVisitOccurenceBO Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getVisitOccurenceBO";

Property patientId As %String(MAXLEN = "", XMLNAME = "patient_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Storage Default
{
<Data name="getVisitOccurenceBODefaultData">
<Subscript>"getVisitOccurenceBO"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
</Data>
<DefaultData>getVisitOccurenceBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
