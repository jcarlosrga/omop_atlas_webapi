/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.HSAAProcedure Extends %Persistent
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

Property ORDERCODECODE As %String(MAXLEN = "") [ SqlFieldName = ORDERCODE_CODE ];

Property ORDERCODEDESCRIPTION As %String(MAXLEN = "") [ SqlFieldName = ORDERCODE_DESCRIPTION ];

Property ORDEREDBYCODE As %String(MAXLEN = "") [ SqlFieldName = ORDEREDBY_CODE ];

Property ORDEREDBYSDACODINGSTANDARD As %String(MAXLEN = "") [ SqlFieldName = ORDEREDBY_SDACODINGSTANDARD ];

Property TEXTINSTRUCTION As %String(MAXLEN = "") [ SqlFieldName = TEXTINSTRUCTION ];

Property HSAAPROCEDURECODE As %String(MAXLEN = "") [ SqlFieldName = HSAAPROCEDURE_CODE ];

Property HSAAPROCEDUREDESCRIPTION As %String(MAXLEN = "") [ SqlFieldName = HSAAPROCEDURE_DESCRIPTION ];

Property PROCEDURETIME As %String(MAXLEN = "") [ SqlFieldName = PROCEDURETIME ];

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
<Data name="HSAAProcedureDefaultData">
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
<Value>ORDERCODECODE</Value>
</Value>
<Value name="16">
<Value>ORDERCODEDESCRIPTION</Value>
</Value>
<Value name="17">
<Value>ORDEREDBYCODE</Value>
</Value>
<Value name="18">
<Value>ORDEREDBYSDACODINGSTANDARD</Value>
</Value>
<Value name="19">
<Value>TEXTINSTRUCTION</Value>
</Value>
<Value name="20">
<Value>HSAAPROCEDURECODE</Value>
</Value>
<Value name="21">
<Value>HSAAPROCEDUREDESCRIPTION</Value>
</Value>
<Value name="22">
<Value>PROCEDURETIME</Value>
</Value>
</Data>
<DataLocation>^HSAA.HSAAProcedureD</DataLocation>
<DefaultData>HSAAProcedureDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^HSAA.HSAAProcedureD</IdLocation>
<IndexLocation>^HSAA.HSAAProcedureI</IndexLocation>
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
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="EnteredOn">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="HSAAPROCEDURECODE">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="HSAAPROCEDUREDESCRIPTION">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ORDERCODECODE">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ORDERCODEDESCRIPTION">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ORDEREDBYCODE">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="ORDEREDBYSDACODINGSTANDARD">
<AverageFieldSize>2</AverageFieldSize>
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
<AverageFieldSize>21</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="PROCEDURETIME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="TEXTINSTRUCTION">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="TagFacility">
<AverageFieldSize>10</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="patient">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="sourceTable">
<AverageFieldSize>17</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^HSAA.HSAAProcedureS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
