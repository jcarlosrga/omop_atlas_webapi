/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.ALLERGY Extends %Persistent
{

Property Encounter As %String(MAXLEN = "") [ SqlFieldName = Encounter ];

Property ALLERGYCODE As %String(MAXLEN = "") [ SqlFieldName = ALLERGY_CODE ];

Property ALLERGYDESCRIPTION As %String(MAXLEN = "") [ SqlFieldName = ALLERGY_DESCRIPTION ];

Property FROMTIME As %String(MAXLEN = "") [ SqlFieldName = FROMTIME ];

Property TOTIME As %String(MAXLEN = "") [ SqlFieldName = TOTIME ];

Property ENTEREDON As %String(MAXLEN = "") [ SqlFieldName = ENTEREDON ];

Property CLINICIANCODE As %String(MAXLEN = "") [ SqlFieldName = CLINICIAN_CODE ];

Property CLINICIANSDACODINGSTANDARD As %String(MAXLEN = "") [ SqlFieldName = CLINICIAN_SDACODINGSTANDARD ];

Property SEVERITYCODE As %String(MAXLEN = "") [ SqlFieldName = SEVERITY_CODE ];

Property SEVERITYDESCRIPTION As %String(MAXLEN = "") [ SqlFieldName = SEVERITY_DESCRIPTION ];

Property PATIENT As %String(MAXLEN = "") [ SqlFieldName = PATIENT ];

Property TAGFACILITY As %String(MAXLEN = "") [ SqlFieldName = TAGFACILITY ];

Property REACTIONCODE As %String(MAXLEN = "") [ SqlFieldName = REACTION_CODE ];

Property REACTIONDESCRIPTION As %String(MAXLEN = "") [ SqlFieldName = REACTION_DESCRIPTION ];

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
<Data name="ALLERGYDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Encounter</Value>
</Value>
<Value name="3">
<Value>ALLERGYCODE</Value>
</Value>
<Value name="4">
<Value>ALLERGYDESCRIPTION</Value>
</Value>
<Value name="5">
<Value>FROMTIME</Value>
</Value>
<Value name="6">
<Value>TOTIME</Value>
</Value>
<Value name="7">
<Value>ENTEREDON</Value>
</Value>
<Value name="8">
<Value>CLINICIANCODE</Value>
</Value>
<Value name="9">
<Value>CLINICIANSDACODINGSTANDARD</Value>
</Value>
<Value name="10">
<Value>SEVERITYCODE</Value>
</Value>
<Value name="11">
<Value>SEVERITYDESCRIPTION</Value>
</Value>
<Value name="12">
<Value>PATIENT</Value>
</Value>
<Value name="13">
<Value>TAGFACILITY</Value>
</Value>
<Value name="14">
<Value>REACTIONCODE</Value>
</Value>
<Value name="15">
<Value>REACTIONDESCRIPTION</Value>
</Value>
</Data>
<DataLocation>^HSAA.ALLERGYD</DataLocation>
<DefaultData>ALLERGYDefaultData</DefaultData>
<ExtentSize>0</ExtentSize>
<IdLocation>^HSAA.ALLERGYD</IdLocation>
<IndexLocation>^HSAA.ALLERGYI</IndexLocation>
<StreamLocation>^HSAA.ALLERGYS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
