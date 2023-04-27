Class OMOP.Proxy.visitOccurenceItem Extends (%Persistent, %XML.Adaptor)
{

Property id As %String(MAXLEN = "", XMLNAME = "id");

Property patient As %String(MAXLEN = "", XMLNAME = "patient");

Property encounterType As %String(MAXLEN = "", XMLNAME = "EncounterType");

Property startTime As %String(MAXLEN = "", XMLNAME = "StartTime");

Property fromTime As %String(MAXLEN = "", XMLNAME = "FromTime");

Property endTime As %String(MAXLEN = "", XMLNAME = "EndTime");

Property toTime As %String(MAXLEN = "", XMLNAME = "ToTime");

Property site As %String(MAXLEN = "", XMLNAME = "Site");

Property admittingClinicianDescription As %String(MAXLEN = "", XMLNAME = "AdmittingClinician_Description");

Property admissionSourceCode As %String(MAXLEN = "", XMLNAME = "AdmissionSource_Code");

Property dischargeDispositionCode As %String(MAXLEN = "", XMLNAME = "DischargeDisposition_Code");

Property lastUpdated As %String(MAXLEN = "", XMLNAME = "LastUpdated");

Property attendingClinicianCode As %String(MAXLEN = "", XMLNAME = "AttendingClinician_Code");

Property attendingClinicianSDACodingStandard As %String(MAXLEN = "", XMLNAME = "AttendingClinician_SDACodingStandard");

Property LOS As %String(MAXLEN = "", XMLNAME = "LOS");

Storage Default
{
<Data name="visitOccurenceItemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>occurencyId</Value>
</Value>
<Value name="3">
<Value>id</Value>
</Value>
<Value name="4">
<Value>patient</Value>
</Value>
<Value name="5">
<Value>encounterType</Value>
</Value>
<Value name="6">
<Value>startTime</Value>
</Value>
<Value name="7">
<Value>fromTime</Value>
</Value>
<Value name="8">
<Value>endTime</Value>
</Value>
<Value name="9">
<Value>toTime</Value>
</Value>
<Value name="10">
<Value>site</Value>
</Value>
<Value name="11">
<Value>admittingClinicianDescription</Value>
</Value>
<Value name="12">
<Value>admissionSourceCode</Value>
</Value>
<Value name="13">
<Value>dischargeDispositionCode</Value>
</Value>
<Value name="14">
<Value>lastUpdated</Value>
</Value>
<Value name="15">
<Value>attendingClinicianCode</Value>
</Value>
<Value name="16">
<Value>attendingClinicianSDACodingStandard</Value>
</Value>
<Value name="17">
<Value>LOS</Value>
</Value>
</Data>
<DataLocation>^OMOP.Proxy.visitOccurenceItemD</DataLocation>
<DefaultData>visitOccurenceItemDefaultData</DefaultData>
<IdLocation>^OMOP.Proxy.visitOccurenceItemD</IdLocation>
<IndexLocation>^OMOP.Proxy.visitOccurenceItemI</IndexLocation>
<StreamLocation>^OMOP.Proxy.visitOccurenceItemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
