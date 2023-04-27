/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.SOCIALHISTORY Extends %Persistent
{

Property Encounter As %String(MAXLEN = "") [ SqlFieldName = Encounter ];

Property CLINICIANCODE As %String(MAXLEN = "") [ SqlFieldName = CLINICIAN_CODE ];

Property CLINICIANSDACODINGSTANDARD As %String(MAXLEN = "") [ SqlFieldName = CLINICIAN_SDACODINGSTANDARD ];

Property PATIENT As %String(MAXLEN = "") [ SqlFieldName = PATIENT ];

Property TAGFACILITY As %String(MAXLEN = "") [ SqlFieldName = TAGFACILITY ];

Property FROMTIME As %String(MAXLEN = "") [ SqlFieldName = FROMTIME ];

Property TOTIME As %String(MAXLEN = "") [ SqlFieldName = TOTIME ];

Property ENTEREDON As %String(MAXLEN = "") [ SqlFieldName = ENTEREDON ];

Property SOCIALHABITCODE As %String(MAXLEN = "") [ SqlFieldName = SOCIALHABIT_CODE ];

Property SOCIALHABITDESCRIPTION As %String(MAXLEN = "") [ SqlFieldName = SOCIALHABIT_DESCRIPTION ];

Property ENTEREDBYCODE As %String(MAXLEN = "") [ SqlFieldName = ENTEREDBY_CODE ];

Property ENTEREDBYSDACODINGSTANDARD As %String(MAXLEN = "") [ SqlFieldName = ENTEREDBY_SDACODINGSTANDARD ];

Property SOCIALHABITQTYCODE As %String(MAXLEN = "") [ SqlFieldName = SOCIALHABITQTY_CODE ];

Property SOCIALHABITQTYDESCRIPTION As %String(MAXLEN = "") [ SqlFieldName = SOCIALHABITQTY_DESCRIPTION ];

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
<Data name="SOCIALHISTORYDefaultData">
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
<Value>SOCIALHABITCODE</Value>
</Value>
<Value name="11">
<Value>SOCIALHABITDESCRIPTION</Value>
</Value>
<Value name="12">
<Value>ENTEREDBYCODE</Value>
</Value>
<Value name="13">
<Value>ENTEREDBYSDACODINGSTANDARD</Value>
</Value>
<Value name="14">
<Value>SOCIALHABITQTYCODE</Value>
</Value>
<Value name="15">
<Value>SOCIALHABITQTYDESCRIPTION</Value>
</Value>
</Data>
<DataLocation>^HSAA.SOCIALHISTORYD</DataLocation>
<DefaultData>SOCIALHISTORYDefaultData</DefaultData>
<ExtentSize>0</ExtentSize>
<IdLocation>^HSAA.SOCIALHISTORYD</IdLocation>
<IndexLocation>^HSAA.SOCIALHISTORYI</IndexLocation>
<StreamLocation>^HSAA.SOCIALHISTORYS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
