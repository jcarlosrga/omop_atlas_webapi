/// 20220418 Denis Bulashev
/// Storage for update patients
/// Used by get patient list operation
Class HSAA.PatientList Extends %Persistent
{

Property patientId As %String(MAXLEN = "") [ SqlFieldName = patient_id ];

Index patientIdInd On patientId [ Unique ];

Storage Default
{
<Data name="PatientListDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>patientId</Value>
</Value>
</Data>
<DataLocation>^HSAA.PatientListD</DataLocation>
<DefaultData>PatientListDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^HSAA.PatientListD</IdLocation>
<IndexLocation>^HSAA.PatientListI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="patientId">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="patientIdInd">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^HSAA.PatientListS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
