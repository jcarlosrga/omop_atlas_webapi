/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.Medication Extends %Persistent
{

Property Encounter As %String(MAXLEN = "") [ SqlFieldName = Encounter ];

Property ObservationCodeCode As %String(MAXLEN = "") [ SqlFieldName = ObservationCode_Code ];

Property ObservationCodeDescription As %String(MAXLEN = "") [ SqlFieldName = ObservationCode_Description ];

Property ObservationTime As %String(MAXLEN = "") [ SqlFieldName = ObservationTime ];

Property EnteredOn As %String(MAXLEN = "") [ SqlFieldName = EnteredOn ];

Property ClinicianCode As %String(MAXLEN = "") [ SqlFieldName = Clinician_Code ];

Property ClinicianSDACodingStandard As %String(MAXLEN = "") [ SqlFieldName = Clinician_SDACodingStandard ];

Property ObservationCodeObservationValueUnitsCode As %String(MAXLEN = "") [ SqlFieldName = ObservationCode_ObservationValueUnits_Code ];

Property ObservationCodeObservationValueUnitsDescription As %String(MAXLEN = "") [ SqlFieldName = ObservationCode_ObservationValueUnits_Description ];

Property ObservationRawValue As %String(MAXLEN = "") [ SqlFieldName = ObservationRawValue ];

Property TagFacility As %String(MAXLEN = "") [ SqlFieldName = TagFacility ];

Property patient As %String(MAXLEN = "") [ SqlFieldName = patient ];

Property sourceTable As %String(MAXLEN = "") [ SqlFieldName = source_table ];

Property HSAAORDER As %String(MAXLEN = "") [ SqlFieldName = HSAAORDER ];

Property FROMTIME As %String(MAXLEN = "") [ SqlFieldName = FROMTIME ];

Property TOTIME As %String(MAXLEN = "") [ SqlFieldName = TOTIME ];

Property DOSEUOMCODE As %String(MAXLEN = "") [ SqlFieldName = DOSEUOM_CODE ];

Property DOSEUOMDESCRIPTION As %String(MAXLEN = "") [ SqlFieldName = DOSEUOM_DESCRIPTION ];

Property ROUTEDESCRIPTION As %String(MAXLEN = "") [ SqlFieldName = ROUTE_DESCRIPTION ];

Property DOSEQUANTITY As %String(MAXLEN = "") [ SqlFieldName = DOSEQUANTITY ];

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
<Data name="MedicationDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Encounter</Value>
</Value>
<Value name="3">
<Value>ObservationCodeCode</Value>
</Value>
<Value name="4">
<Value>ObservationCodeDescription</Value>
</Value>
<Value name="5">
<Value>ObservationTime</Value>
</Value>
<Value name="6">
<Value>EnteredOn</Value>
</Value>
<Value name="7">
<Value>ClinicianCode</Value>
</Value>
<Value name="8">
<Value>ClinicianSDACodingStandard</Value>
</Value>
<Value name="9">
<Value>ObservationCodeObservationValueUnitsCode</Value>
</Value>
<Value name="10">
<Value>ObservationCodeObservationValueUnitsDescription</Value>
</Value>
<Value name="11">
<Value>ObservationRawValue</Value>
</Value>
<Value name="12">
<Value>TagFacility</Value>
</Value>
<Value name="13">
<Value>patient</Value>
</Value>
<Value name="14">
<Value>sourceTable</Value>
</Value>
<Value name="15">
<Value>HSAAORDER</Value>
</Value>
<Value name="16">
<Value>FROMTIME</Value>
</Value>
<Value name="17">
<Value>TOTIME</Value>
</Value>
<Value name="18">
<Value>DOSEUOMCODE</Value>
</Value>
<Value name="19">
<Value>DOSEUOMDESCRIPTION</Value>
</Value>
<Value name="20">
<Value>ROUTEDESCRIPTION</Value>
</Value>
<Value name="21">
<Value>DOSEQUANTITY</Value>
</Value>
</Data>
<DataLocation>^HSAA.MedicationD</DataLocation>
<DefaultData>MedicationDefaultData</DefaultData>
<ExtentSize>0</ExtentSize>
<IdLocation>^HSAA.MedicationD</IdLocation>
<IndexLocation>^HSAA.MedicationI</IndexLocation>
<StreamLocation>^HSAA.MedicationS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
