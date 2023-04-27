/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.OTHERRESULT Extends %Persistent
{

Property Encounter As %String(MAXLEN = "") [ SqlFieldName = Encounter ];

Property CLINICIANCODE As %String(MAXLEN = "") [ SqlFieldName = CLINICIAN_CODE ];

Property CLINICIANSDACODINGSTANDARD As %String(MAXLEN = "") [ SqlFieldName = CLINICIAN_SDACODINGSTANDARD ];

Property PATIENT As %String(MAXLEN = "") [ SqlFieldName = PATIENT ];

Property TAGFACILITY As %String(MAXLEN = "") [ SqlFieldName = TAGFACILITY ];

Property FROMTIME As %String(MAXLEN = "") [ SqlFieldName = FROMTIME ];

Property TOTIME As %String(MAXLEN = "") [ SqlFieldName = TOTIME ];

Property ENTEREDON As %String(MAXLEN = "") [ SqlFieldName = ENTEREDON ];

Property HSAAOrder As %String(MAXLEN = "") [ SqlFieldName = HSAAOrder ];

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
<Data name="OTHERRESULTDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Encounter</Value>
</Value>
<Value name="3">
<Value>CLINICIANCODE</Value>
</Value>
<Value name="4">
<Value>CLINICIANSDACODINGSTANDARD</Value>
</Value>
<Value name="5">
<Value>PATIENT</Value>
</Value>
<Value name="6">
<Value>TAGFACILITY</Value>
</Value>
<Value name="7">
<Value>FROMTIME</Value>
</Value>
<Value name="8">
<Value>TOTIME</Value>
</Value>
<Value name="9">
<Value>ENTEREDON</Value>
</Value>
<Value name="10">
<Value>HSAAOrder</Value>
</Value>
</Data>
<DataLocation>^HSAA.OTHERRESULTD</DataLocation>
<DefaultData>OTHERRESULTDefaultData</DefaultData>
<ExtentSize>0</ExtentSize>
<IdLocation>^HSAA.OTHERRESULTD</IdLocation>
<IndexLocation>^HSAA.OTHERRESULTI</IndexLocation>
<StreamLocation>^HSAA.OTHERRESULTS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
