/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.Observation Extends %Persistent
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
<Data name="ObservationDefaultData">
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
</Data>
<DataLocation>^HSAA.ObservationD</DataLocation>
<DefaultData>ObservationDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^HSAA.ObservationD</IdLocation>
<IndexLocation>^HSAA.ObservationI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="ClinicianCode">
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ClinicianSDACodingStandard">
<AverageFieldSize>5</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Encounter">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="EnteredOn">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ObservationCodeCode">
<AverageFieldSize>10</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ObservationCodeDescription">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ObservationCodeObservationValueUnitsCode">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ObservationCodeObservationValueUnitsDescription">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ObservationRawValue">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ObservationTime">
<AverageFieldSize>22</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="TagFacility">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="patient">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^HSAA.ObservationS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
