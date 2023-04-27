Class OMOP.Storage.PatientId Extends %Persistent
{

Property pId As %Integer;

Property processed As %Integer;

Index patientId On pId [ Unique ];

Storage Default
{
<Data name="PatientIdDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>pId</Value>
</Value>
<Value name="3">
<Value>processed</Value>
</Value>
</Data>
<DataLocation>^OMOP.Storage.PatientIdD</DataLocation>
<DefaultData>PatientIdDefaultData</DefaultData>
<ExtentSize>0</ExtentSize>
<IdLocation>^OMOP.Storage.PatientIdD</IdLocation>
<IndexLocation>^OMOP.Storage.PatientIdI</IndexLocation>
<StreamLocation>^OMOP.Storage.PatientIdS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
