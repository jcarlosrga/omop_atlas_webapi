Class OMOP.Request.updatePatientsList Extends Ens.Request
{

Parameter RESPONSECLASSNAME = "OMOP.Response.updatePatientsList";

Property SQL As %String(MAXLEN = "", XMLNAME = "SQL");

Storage Default
{
<Data name="updatePatientsListDefaultData">
<Subscript>"updatePatientsList"</Subscript>
<Value name="1">
<Value>SQL</Value>
</Value>
</Data>
<DefaultData>updatePatientsListDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
