Class OMOP.Response.getPatientsList Extends Ens.Response
{

Property patientsList As list Of %String(MAXLEN = "");

Storage Default
{
<Data name="patientsList">
<Attribute>patientsList</Attribute>
<Structure>node</Structure>
<Subscript>"OMOP.Response.getPatientsList.patientsList"</Subscript>
</Data>
<Type>%Storage.Persistent</Type>
}

}
