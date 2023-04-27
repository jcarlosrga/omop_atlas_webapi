Class OMOP.Request.getPatientsList Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.getPatientsList";

Storage Default
{
<Data name="getPatientsListDefaultData">
<Subscript>"getPatientsList"</Subscript>
<Value name="1">
<Value>SQL</Value>
</Value>
</Data>
<DefaultData>getPatientsListDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
