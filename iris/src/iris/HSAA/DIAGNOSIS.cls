/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.DIAGNOSIS Extends %Persistent
{

Property Encounter As %String(MAXLEN = "") [ SqlFieldName = Encounter ];

Property DIAGNOSISCODE As %String(MAXLEN = "") [ SqlFieldName = DIAGNOSIS_CODE ];

Property DIAGNOSISDESCRIPTION As %String(MAXLEN = "") [ SqlFieldName = DIAGNOSIS_DESCRIPTION ];

Property DIAGNOSISTIME As %String(MAXLEN = "") [ SqlFieldName = DIAGNOSISTIME ];

Property ENTEREDON As %String(MAXLEN = "") [ SqlFieldName = ENTEREDON ];

Property DIAGNOSINGCLINICIANCODE As %String(MAXLEN = "") [ SqlFieldName = DIAGNOSINGCLINICIAN_CODE ];

Property DIAGNOSINGCLINICIANSDACODINGSTANDARD As %String(MAXLEN = "") [ SqlFieldName = DIAGNOSINGCLINICIAN_SDACODINGSTANDARD ];

Property PATIENT As %String(MAXLEN = "") [ SqlFieldName = PATIENT ];

Property TAGFACILITY As %String(MAXLEN = "") [ SqlFieldName = TAGFACILITY ];

Trigger OnUpdate [ Event = INSERT/UPDATE, Time = AFTER ]
{
	set patientId = {patient}
	
	// add patient to the list for future processing
	set patientRecord = ##class(HSAA.PatientList).patientIdIndOpen(id,2,.sc)

	if $$$ISERR(sc) {	// record not found
		set patientRecord = ##class(HSAA.PatientList).%New()
	}
	
	set patientRecord.patientId = patientId
	set sc = patientRecord.%Save()
}

Storage Default
{
<Data name="DIAGNOSISDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Encounter</Value>
</Value>
<Value name="3">
<Value>DIAGNOSISCODE</Value>
</Value>
<Value name="4">
<Value>DIAGNOSISDESCRIPTION</Value>
</Value>
<Value name="5">
<Value>DIAGNOSISTIME</Value>
</Value>
<Value name="6">
<Value>ENTEREDON</Value>
</Value>
<Value name="7">
<Value>DIAGNOSINGCLINICIANCODE</Value>
</Value>
<Value name="8">
<Value>DIAGNOSINGCLINICIANSDACODINGSTANDARD</Value>
</Value>
<Value name="9">
<Value>PATIENT</Value>
</Value>
<Value name="10">
<Value>TAGFACILITY</Value>
</Value>
</Data>
<DataLocation>^HSAA.DIAGNOSISD</DataLocation>
<DefaultData>DIAGNOSISDefaultData</DefaultData>
<ExtentSize>0</ExtentSize>
<IdLocation>^HSAA.DIAGNOSISD</IdLocation>
<IndexLocation>^HSAA.DIAGNOSISI</IndexLocation>
<StreamLocation>^HSAA.DIAGNOSISS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
