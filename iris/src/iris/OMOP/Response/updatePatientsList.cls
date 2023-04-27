Class OMOP.Response.updatePatientsList Extends Ens.Response
{

Property patientsList As %Library.DynamicObject;

/// Property patientId As %ListOfDataTypes(ELEMENTTYPE = "%String");
Storage Default
{
<Data name="json">
<Attribute>json</Attribute>
<Structure>node</Structure>
<Subscript>"OMOP.Response.updatePatientsList.json"</Subscript>
</Data>
<Data name="patientsList">
<Attribute>patientsList</Attribute>
<Structure>node</Structure>
<Subscript>"OMOP.Response.updatePatientsList.patientsList"</Subscript>
</Data>
<Data name="updatePatientsListDefaultData">
<Subscript>"updatePatientsList"</Subscript>
<Value name="1">
<Value>patientId</Value>
</Value>
</Data>
<DefaultData>updatePatientsListDefaultData</DefaultData>
<Description>
<![CDATA[Property patientId As %ListOfDataTypes(ELEMENTTYPE = "%String");]]></Description>
<Type>%Storage.Persistent</Type>
}

}
