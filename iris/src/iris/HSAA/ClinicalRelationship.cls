/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.ClinicalRelationship Extends %Persistent
{

Property patient As %String(MAXLEN = "") [ SqlFieldName = patient ];

Property CareProvider As %String(MAXLEN = "") [ SqlFieldName = CareProvider ];

Property ClinicianDescription As %String(MAXLEN = "") [ SqlFieldName = Clinician_Description ];

Property clinicianCareprovidertypeDescription As %String(MAXLEN = "") [ SqlFieldName = clinician_careprovidertype_description ];

Property facilitycode As %String(MAXLEN = "") [ SqlFieldName = facilitycode ];

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

/// /// Allow synchronization
/// /
/// /Parameter DSTIME = "AUTO";
/// /
/// /// a negative POPORDER skips the setting of this property
/// /
/// //// The patient who has the relationship<br><br>
/// /Relationship Patient As HSAA.Patient(POPORDER = -1) [ Cardinality = one, Inverse = ClinicalRelationshipRel ];
/// /
/// //// Encounter, if any, involved in this relationship<br><br>
/// /Relationship Encounter As HSAA.Encounter(POPORDER = -1) [ Cardinality = one, Inverse = ClinicalRelationshipRel, OnDelete = cascade ];
/// /
/// //// The care provider<br>
/// /Relationship CareProvider As HSAA.CareProvider [ Cardinality = one, Inverse = ClinicalRelationshipRel ];
/// /
/// //// SDATableName=Organization<br>
/// /Relationship EnteredAt As HSAA.EnteredAt(POPORDER = -1) [ Cardinality = one, Inverse = ClinicalRelationshipRel ];
/// /
/// /Index PatientIndex On Patient;
/// /
/// /Index EncounterIndex On Encounter;
/// /
/// /Index CareProviderIndex On CareProvider;
/// /
/// /Index EnteredAtIndex On EnteredAt;
/// /
/// /// bitmap extent index
/// /
/// /Index "$ClinicalRelationship" [ Extent, SqlName = "$ClinicalRelationship", Type = bitmap ];
Storage Default
{
<Data name="ClinicalRelationshipDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Clinician</Value>
</Value>
<Value name="3">
<Value>FacilityCode</Value>
</Value>
<Value name="4">
<Value>ClinicianGroup</Value>
</Value>
<Value name="5">
<Value>ExpirationDate</Value>
</Value>
<Value name="6">
<Value>StartDate</Value>
</Value>
<Value name="7">
<Value>EncounterNumber</Value>
</Value>
<Value name="8">
<Value>LastUpdated</Value>
</Value>
<Value name="9">
<Value>Patient</Value>
</Value>
<Value name="10">
<Value>CareProvider</Value>
</Value>
<Value name="11">
<Value>Encounter</Value>
</Value>
<Value name="12">
<Value>Tag</Value>
</Value>
<Value name="13">
<Value>EnteredBy</Value>
</Value>
<Value name="14">
<Value>EnteredAt</Value>
</Value>
<Value name="15">
<Value>EnteredOn</Value>
</Value>
<Value name="16">
<Value>UpdatedOn</Value>
</Value>
<Value name="17">
<Value>FromTime</Value>
</Value>
<Value name="18">
<Value>ToTime</Value>
</Value>
<Value name="19">
<Value>ExternalId</Value>
</Value>
<Value name="20">
<Value>CustomPairs</Value>
</Value>
<Value name="21">
<Value>TagFacility</Value>
</Value>
<Value name="22">
<Value>patient</Value>
</Value>
<Value name="23">
<Value>ClinicianDescription</Value>
</Value>
<Value name="24">
<Value>clinicianCareprovidertypeDescription</Value>
</Value>
<Value name="25">
<Value>ClinicalRelationship</Value>
</Value>
<Value name="26">
<Value>facilitycode</Value>
</Value>
</Data>
<DataLocation>^HSAA.ClinicalRelationshipD</DataLocation>
<DefaultData>ClinicalRelationshipDefaultData</DefaultData>
<Description>
<![CDATA[/// Allow synchronization
/
/Parameter DSTIME = "AUTO";
/
/// a negative POPORDER skips the setting of this property
/
//// The patient who has the relationship<br><br>
/Relationship Patient As HSAA.Patient(POPORDER = -1) [ Cardinality = one, Inverse = ClinicalRelationshipRel ];
/
//// Encounter, if any, involved in this relationship<br><br>
/Relationship Encounter As HSAA.Encounter(POPORDER = -1) [ Cardinality = one, Inverse = ClinicalRelationshipRel, OnDelete = cascade ];
/
//// The care provider<br>
/Relationship CareProvider As HSAA.CareProvider [ Cardinality = one, Inverse = ClinicalRelationshipRel ];
/
//// SDATableName=Organization<br>
/Relationship EnteredAt As HSAA.EnteredAt(POPORDER = -1) [ Cardinality = one, Inverse = ClinicalRelationshipRel ];
/
/Index PatientIndex On Patient;
/
/Index EncounterIndex On Encounter;
/
/Index CareProviderIndex On CareProvider;
/
/Index EnteredAtIndex On EnteredAt;
/
/// bitmap extent index
/
/Index "$ClinicalRelationship" [ Extent, SqlName = "$ClinicalRelationship", Type = bitmap ];]]></Description>
<ExtentSize>0</ExtentSize>
<IdLocation>^HSAA.ClinicalRelationshipD</IdLocation>
<IndexLocation>^HSAA.ClinicalRelationshipI</IndexLocation>
<Property name="%%CLASSNAME"/>
<Property name="%%ID"/>
<Property name="CareProvider"/>
<Property name="Clinician"/>
<Property name="ClinicianGroup"/>
<Property name="Encounter"/>
<Property name="EncounterNumber"/>
<Property name="EnteredAt"/>
<Property name="EnteredBy"/>
<Property name="EnteredOn"/>
<Property name="ExpirationDate"/>
<Property name="ExternalId"/>
<Property name="FacilityCode"/>
<Property name="FromTime"/>
<Property name="LastUpdated"/>
<Property name="Patient"/>
<Property name="StartDate"/>
<Property name="Tag"/>
<Property name="TagFacility"/>
<Property name="ToTime"/>
<Property name="UpdatedOn"/>
<SQLMap name="$ClinicalRelationship"/>
<SQLMap name="CareProviderIndex"/>
<SQLMap name="EncounterIndex"/>
<SQLMap name="EnteredAtIndex"/>
<SQLMap name="IDKEY"/>
<SQLMap name="LastUpdatedIndex"/>
<SQLMap name="PatientIndex"/>
<SQLMap name="TFIx"/>
<SQLMap name="TagIndex"/>
<StreamLocation>^HSAA.ClinicalRelationshipS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
