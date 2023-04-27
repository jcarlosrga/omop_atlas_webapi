/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.Encounter Extends %Persistent
{

Property patient As %String(MAXLEN = "") [ SqlFieldName = patient ];

Property EncounterType As %String(MAXLEN = "") [ SqlFieldName = EncounterType ];

Property StartTime As %String(MAXLEN = "") [ SqlFieldName = StartTime ];

Property FromTime As %String(MAXLEN = "") [ SqlFieldName = FromTime ];

Property EndTime As %String(MAXLEN = "") [ SqlFieldName = EndTime ];

Property ToTime As %String(MAXLEN = "") [ SqlFieldName = ToTime ];

Property Site As %String(MAXLEN = "") [ SqlFieldName = Site ];

Property LastUpdated As %String(MAXLEN = "") [ SqlFieldName = LastUpdated ];

Property AttendingClinicianCode As %String(MAXLEN = "") [ SqlFieldName = AttendingClinician_Code ];

Property AttendingClinicianDescription As %String(MAXLEN = "") [ SqlFieldName = AttendingClinician_Description ];

Property AttendingClinicianSDACodingStandard As %String(MAXLEN = "") [ SqlFieldName = AttendingClinician_SDACodingStandard ];

Property LOS As %String(MAXLEN = "") [ SqlFieldName = LOS ];

Property AdmissionSourceCode As %String(MAXLEN = "") [ SqlFieldName = AdmissionSource_Code ];

Property DischargeDispositionCode As %String(MAXLEN = "") [ SqlFieldName = DischargeDisposition_Code ];

Property TagFacility As %String(MAXLEN = "") [ SqlFieldName = TagFacility ];

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
/// //// The patient who had the encounter<br>
/// /Relationship Patient As HSAA.Patient(POPORDER = -1) [ Cardinality = one, Inverse = EncounterRel ];
/// /
/// //// HL7ToSDA3:<br>
/// //// MSH-4.1 is parsed as the EnteredAt Code. HL7ToSDA3 does not set the<br>
/// //// Description.<br><br>
/// //// HL7:  MSH-4.1 : SendingFacility.NamespaceID<br>
/// //// SDATableName=Organization<br>
/// /Relationship EnteredAt As HSAA.EnteredAt(POPORDER = -1) [ Cardinality = one, Inverse = EncounterRel ];
/// /
/// //// The healthcare facility at which the encounter occurred<br>
/// /Relationship HealthCareFacility As HSAA.HealthCareFacility(POPORDER = -1) [ Cardinality = one, Inverse = EncounterRel ];
/// /
/// //// The site at which the encounter occurred<br>
/// /Relationship Site As HSAA.Site(POPORDER = -1) [ Cardinality = one, Inverse = EncounterRel ];
/// /
/// /// for readmission
/// /
/// /Relationship ReadmitForEncounter As HSAA.Encounter(POPORDER = -1) [ Cardinality = one, Inverse = ReadmitForEncounterRel, OnDelete = cascade ];
/// /
/// /Index StartTimeIndex On StartTime;
/// /
/// /Index EndTimeIndex On EndTime;
/// /
/// /Index VisitNumberIndex On VisitNumber;
/// /
/// /Index EncounterTypeIndex On EncounterType [ Type = bitmap ];
/// /
/// /// other indexes
/// /
/// /Index ExpectedAdmitTimeIndex On ExpectedAdmitTime;
/// /
/// /Index ExpectedDischargeTimeIndex On ExpectedDischargeTime;
/// /
/// /Index AdmittingClinicianFamilyNameIndex On AdmittingClinician.Name.FamilyName;
/// /
/// /// useful secondary index
/// /
/// /Index PatientStartTimeIndex On (Patient, StartTime);
/// /
/// /Index PatientIndex On Patient;
/// /
/// /Index EnteredAtIndex On EnteredAt;
/// /
/// /// Relationship PrimaryDiagnosis As HSAA.Diagnosis(POPORDER = -1) [ Cardinality = one, Inverse = EncounterPrimary ];
/// /
/// /// Index PrimaryDiagnosisIndex On PrimaryDiagnosis;
/// /
/// /Index HealthCareFacilityIndex On HealthCareFacility;
/// /
/// /Index SiteIndex On Site;
/// /
/// /Relationship ClinicalRelationshipRel As HSAA.ClinicalRelationship [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship DiagnosisRel As HSAA.Diagnosis [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship DocumentRel As HSAA.Document [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship EncounterGuarantorRel As HSAA.EncounterGuarantor [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship EncounterHealthPlanRel As HSAA.EncounterHealthPlan [ Cardinality = many, Inverse = Encounter ];
/// /
/// //// Event/care provider site relationship
/// /Relationship EventCareProviderSiteRel As HSAA.EventCareProviderSite [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship IllnessHistoryRel As HSAA.IllnessHistory [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship ProcedureRel As HSAA.Procedure [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship ObservationRel As HSAA.Observation [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship ObservationGroupRel As HSAA.ObservationGroup [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship OrderRel As HSAA.Order [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship MedicationAdministrationRel As HSAA.MedicationAdministration [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship LabResultItemRel As HSAA.LabResultItem [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship VaccinationRel As HSAA.Vaccination [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Relationship VitalSignRel As HSAA.VitalSign [ Cardinality = many, Inverse = Encounter ];
/// /
/// /Index ReadmitForEncounterIndex On ReadmitForEncounter;
/// /
/// /Relationship ReadmitForEncounterRel As HSAA.Encounter(POPORDER = -1) [ Cardinality = many, Inverse = ReadmitForEncounter ];
/// /
/// //// Delete EncounterGuarantors, EncounterHealthPlans for Encounter</br>
/// //// <var>sourceType</var> - type of source object - unused here</br>
/// //// <var>indent</var> - indentation level (for logging)</br>
/// /Method DeleteDependentObjects(sourceType As %String, indent As %String = "") As %Status
/// /{
/// /	set sc = $$$OK
/// / 	Try {
/// /	 	set id = ..%Id()
/// /		do ##class(HSAA.Logger).Info(indent_"Deleting encounter guarantors for encounter "_id) 	
/// /	
/// /		set stmt = "delete from hsaa.encounterguarantor where encounter = ?"
/// /		set tResult = ##class(%SQL.Statement).%ExecDirect(, stmt, id)
/// /		set SQLCODE = tResult.%SQLCODE 
/// /		
/// /		if SQLCODE && (SQLCODE '= 100) {
/// /			set sc = $$$ERROR($$$HSAAErrRunSQL, stmt, SQLCODE) 
/// /			quit }	
/// /
/// /		do ##class(HSAA.Logger).Info(indent_"Deleting encounter health plans for encounter "_id) 	
/// /	
/// /		set stmt = "delete from hsaa.encounterhealthplan where encounter = ?"
/// /		set tResult = ##class(%SQL.Statement).%ExecDirect(, stmt, id)
/// /		set SQLCODE = tResult.%SQLCODE 
/// /		
/// /		if SQLCODE && (SQLCODE '= 100) {
/// /			set sc = $$$ERROR($$$HSAAErrRunSQL, stmt, SQLCODE) 
/// /			quit }	
/// /
/// / 	}
/// / 	Catch(ex) {
/// /		set sc = ex.AsStatus()
/// / 	}
/// /	quit sc
/// /}
Storage Default
{
<Data name="EncounterDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CDREncID</Value>
</Value>
<Value name="3">
<Value>VisitNumber</Value>
</Value>
<Value name="4">
<Value>StartTime</Value>
</Value>
<Value name="5">
<Value>EndTime</Value>
</Value>
<Value name="6">
<Value>LOS</Value>
</Value>
<Value name="7">
<Value>AdmissionType</Value>
</Value>
<Value name="8">
<Value>AdmissionSource</Value>
</Value>
<Value name="9">
<Value>EncounterType</Value>
</Value>
<Value name="10">
<Value>AdmittingClinician</Value>
</Value>
<Value name="11">
<Value>AttendingClinician</Value>
</Value>
<Value name="12">
<Value>ConsultingClinician</Value>
</Value>
<Value name="13">
<Value>ReferringClinician</Value>
</Value>
<Value name="14">
<Value>DischargeDisposition</Value>
</Value>
<Value name="15">
<Value>AdmitReason</Value>
</Value>
<Value name="16">
<Value>OrderToAdmitTime</Value>
</Value>
<Value name="17">
<Value>DecisionToAdmitTime</Value>
</Value>
<Value name="18">
<Value>ComfortMeasuresOnly</Value>
</Value>
<Value name="19">
<Value>ChiefComplaint</Value>
</Value>
<Value name="20">
<Value>SmokingCessationCounseling</Value>
</Value>
<Value name="21">
<Value>AspirinPrescribedAtDischarge</Value>
</Value>
<Value name="22">
<Value>BetaBlockerPrescribedAtDischarge</Value>
</Value>
<Value name="23">
<Value>ACEIOrARBPrescribedAtDischarge</Value>
</Value>
<Value name="24">
<Value>StatinPrescribedAtDischarge</Value>
</Value>
<Value name="25">
<Value>LipidLoweringTherapyPrescribedAtDischarge</Value>
</Value>
<Value name="26">
<Value>DepressionScreening</Value>
</Value>
<Value name="27">
<Value>ACSC</Value>
</Value>
<Value name="28">
<Value>DiagnosisRelatedGroup</Value>
</Value>
<Value name="29">
<Value>Patient</Value>
</Value>
<Value name="30">
<Value>HealthCareFacility</Value>
</Value>
<Value name="31">
<Value>HealthPlan</Value>
</Value>
<Value name="32">
<Value>HSAAEncID</Value>
</Value>
<Value name="33">
<Value>Tag</Value>
</Value>
<Value name="34">
<Value>ReadmitForEncounter</Value>
</Value>
<Value name="35">
<Value>Site</Value>
</Value>
<Value name="36">
<Value>TransferredFromED</Value>
</Value>
<Value name="37">
<Value>EmergencyAdmitDateTime</Value>
</Value>
<Value name="38">
<Value>DischargeLocation</Value>
</Value>
<Value name="39">
<Value>AssignedRoom</Value>
</Value>
<Value name="40">
<Value>AssignedBed</Value>
</Value>
<Value name="41">
<Value>ExpectedAdmitTime</Value>
</Value>
<Value name="42">
<Value>ExpectedDischargeTime</Value>
</Value>
<Value name="43">
<Value>Priority</Value>
</Value>
<Value name="44">
<Value>VisitDescription</Value>
</Value>
<Value name="45">
<Value>EnteredBy</Value>
</Value>
<Value name="46">
<Value>EnteredAt</Value>
</Value>
<Value name="47">
<Value>EnteredOn</Value>
</Value>
<Value name="48">
<Value>UpdatedOn</Value>
</Value>
<Value name="49">
<Value>EncounterCodedType</Value>
</Value>
<Value name="50">
<Value>LastUpdated</Value>
</Value>
<Value name="51">
<Value>Extension</Value>
</Value>
<Value name="52">
<Value>FromTime</Value>
</Value>
<Value name="53">
<Value>AttendingClinicians</Value>
</Value>
<Value name="54">
<Value>ConsultingClinicians</Value>
</Value>
<Value name="55">
<Value>EncounterNumber</Value>
</Value>
<Value name="56">
<Value>AccountNumber</Value>
</Value>
<Value name="57">
<Value>PriorVisitNumber</Value>
</Value>
<Value name="58">
<Value>PreAdmissionNumber</Value>
</Value>
<Value name="59">
<Value>AssignedWard</Value>
</Value>
<Value name="60">
<Value>PriorWard</Value>
</Value>
<Value name="61">
<Value>PriorRoom</Value>
</Value>
<Value name="62">
<Value>PriorBed</Value>
</Value>
<Value name="63">
<Value>VisitStatus</Value>
</Value>
<Value name="64">
<Value>EncounterMRN</Value>
</Value>
<Value name="65">
<Value>HealthFunds</Value>
</Value>
<Value name="66">
<Value>Specialties</Value>
</Value>
<Value name="67">
<Value>RecommendationsProvided</Value>
</Value>
<Value name="68">
<Value>PublicityCode</Value>
</Value>
<Value name="69">
<Value>ExpectedLOAReturnTime</Value>
</Value>
<Value name="70">
<Value>ExternalId</Value>
</Value>
<Value name="71">
<Value>CustomPairs</Value>
</Value>
<Value name="72">
<Value>ToTime</Value>
</Value>
<Value name="73">
<Value>TagFacility</Value>
</Value>
<Value name="74">
<Value>EncounterMRNAA</Value>
</Value>
<Value name="75">
<Value>StreamletTime</Value>
</Value>
<Value name="76">
<Value>patient</Value>
</Value>
<Value name="77">
<Value>AttendingClinicianCode</Value>
</Value>
<Value name="78">
<Value>AttendingClinicianDescription</Value>
</Value>
<Value name="79">
<Value>AttendingClinicianSDACodingStandard</Value>
</Value>
<Value name="80">
<Value>AdmissionSourceCode</Value>
</Value>
<Value name="81">
<Value>DischargeDispositionCode</Value>
</Value>
</Data>
<DataLocation>^HSAA.EncounterD</DataLocation>
<DefaultData>EncounterDefaultData</DefaultData>
<Description>
<![CDATA[/// Allow synchronization
/
/Parameter DSTIME = "AUTO";
/
/// a negative POPORDER skips the setting of this property
/
//// The patient who had the encounter<br>
/Relationship Patient As HSAA.Patient(POPORDER = -1) [ Cardinality = one, Inverse = EncounterRel ];
/
//// HL7ToSDA3:<br>
//// MSH-4.1 is parsed as the EnteredAt Code. HL7ToSDA3 does not set the<br>
//// Description.<br><br>
//// HL7:  MSH-4.1 : SendingFacility.NamespaceID<br>
//// SDATableName=Organization<br>
/Relationship EnteredAt As HSAA.EnteredAt(POPORDER = -1) [ Cardinality = one, Inverse = EncounterRel ];
/
//// The healthcare facility at which the encounter occurred<br>
/Relationship HealthCareFacility As HSAA.HealthCareFacility(POPORDER = -1) [ Cardinality = one, Inverse = EncounterRel ];
/
//// The site at which the encounter occurred<br>
/Relationship Site As HSAA.Site(POPORDER = -1) [ Cardinality = one, Inverse = EncounterRel ];
/
/// for readmission
/
/Relationship ReadmitForEncounter As HSAA.Encounter(POPORDER = -1) [ Cardinality = one, Inverse = ReadmitForEncounterRel, OnDelete = cascade ];
/
/Index StartTimeIndex On StartTime;
/
/Index EndTimeIndex On EndTime;
/
/Index VisitNumberIndex On VisitNumber;
/
/Index EncounterTypeIndex On EncounterType [ Type = bitmap ];
/
/// other indexes
/
/Index ExpectedAdmitTimeIndex On ExpectedAdmitTime;
/
/Index ExpectedDischargeTimeIndex On ExpectedDischargeTime;
/
/Index AdmittingClinicianFamilyNameIndex On AdmittingClinician.Name.FamilyName;
/
/// useful secondary index
/
/Index PatientStartTimeIndex On (Patient, StartTime);
/
/Index PatientIndex On Patient;
/
/Index EnteredAtIndex On EnteredAt;
/
/// Relationship PrimaryDiagnosis As HSAA.Diagnosis(POPORDER = -1) [ Cardinality = one, Inverse = EncounterPrimary ];
/
/// Index PrimaryDiagnosisIndex On PrimaryDiagnosis;
/
/Index HealthCareFacilityIndex On HealthCareFacility;
/
/Index SiteIndex On Site;
/
/Relationship ClinicalRelationshipRel As HSAA.ClinicalRelationship [ Cardinality = many, Inverse = Encounter ];
/
/Relationship DiagnosisRel As HSAA.Diagnosis [ Cardinality = many, Inverse = Encounter ];
/
/Relationship DocumentRel As HSAA.Document [ Cardinality = many, Inverse = Encounter ];
/
/Relationship EncounterGuarantorRel As HSAA.EncounterGuarantor [ Cardinality = many, Inverse = Encounter ];
/
/Relationship EncounterHealthPlanRel As HSAA.EncounterHealthPlan [ Cardinality = many, Inverse = Encounter ];
/
//// Event/care provider site relationship
/Relationship EventCareProviderSiteRel As HSAA.EventCareProviderSite [ Cardinality = many, Inverse = Encounter ];
/
/Relationship IllnessHistoryRel As HSAA.IllnessHistory [ Cardinality = many, Inverse = Encounter ];
/
/Relationship ProcedureRel As HSAA.Procedure [ Cardinality = many, Inverse = Encounter ];
/
/Relationship ObservationRel As HSAA.Observation [ Cardinality = many, Inverse = Encounter ];
/
/Relationship ObservationGroupRel As HSAA.ObservationGroup [ Cardinality = many, Inverse = Encounter ];
/
/Relationship OrderRel As HSAA.Order [ Cardinality = many, Inverse = Encounter ];
/
/Relationship MedicationAdministrationRel As HSAA.MedicationAdministration [ Cardinality = many, Inverse = Encounter ];
/
/Relationship LabResultItemRel As HSAA.LabResultItem [ Cardinality = many, Inverse = Encounter ];
/
/Relationship VaccinationRel As HSAA.Vaccination [ Cardinality = many, Inverse = Encounter ];
/
/Relationship VitalSignRel As HSAA.VitalSign [ Cardinality = many, Inverse = Encounter ];
/
/Index ReadmitForEncounterIndex On ReadmitForEncounter;
/
/Relationship ReadmitForEncounterRel As HSAA.Encounter(POPORDER = -1) [ Cardinality = many, Inverse = ReadmitForEncounter ];
/
//// Delete EncounterGuarantors, EncounterHealthPlans for Encounter</br>
//// <var>sourceType</var> - type of source object - unused here</br>
//// <var>indent</var> - indentation level (for logging)</br>
/Method DeleteDependentObjects(sourceType As %String, indent As %String = "") As %Status
/{
/	set sc = $$$OK
/ 	Try {
/	 	set id = ..%Id()
/		do ##class(HSAA.Logger).Info(indent_"Deleting encounter guarantors for encounter "_id) 	
/	
/		set stmt = "delete from hsaa.encounterguarantor where encounter = ?"
/		set tResult = ##class(%SQL.Statement).%ExecDirect(, stmt, id)
/		set SQLCODE = tResult.%SQLCODE 
/		
/		if SQLCODE && (SQLCODE '= 100) {
/			set sc = $$$ERROR($$$HSAAErrRunSQL, stmt, SQLCODE) 
/			quit }	
/
/		do ##class(HSAA.Logger).Info(indent_"Deleting encounter health plans for encounter "_id) 	
/	
/		set stmt = "delete from hsaa.encounterhealthplan where encounter = ?"
/		set tResult = ##class(%SQL.Statement).%ExecDirect(, stmt, id)
/		set SQLCODE = tResult.%SQLCODE 
/		
/		if SQLCODE && (SQLCODE '= 100) {
/			set sc = $$$ERROR($$$HSAAErrRunSQL, stmt, SQLCODE) 
/			quit }	
/
/ 	}
/ 	Catch(ex) {
/		set sc = ex.AsStatus()
/ 	}
/	quit sc
/}]]></Description>
<ExtentSize>0</ExtentSize>
<IdLocation>^HSAA.EncounterD</IdLocation>
<IndexLocation>^HSAA.EncounterI</IndexLocation>
<Property name="%%CLASSNAME"/>
<Property name="%%ID"/>
<Property name="ACEIOrARBPrescribedAtDischarge"/>
<Property name="ACSC"/>
<Property name="AccountNumber"/>
<Property name="AdmissionSource"/>
<Property name="AdmissionType"/>
<Property name="AdmitReason"/>
<Property name="AdmittingClinician"/>
<Property name="AspirinPrescribedAtDischarge"/>
<Property name="AssignedBed"/>
<Property name="AssignedRoom"/>
<Property name="AssignedWard"/>
<Property name="AttendingClinician"/>
<Property name="AttendingClinicians"/>
<Property name="BetaBlockerPrescribedAtDischarge"/>
<Property name="ChiefComplaint"/>
<Property name="ComfortMeasuresOnly"/>
<Property name="ConsultingClinician"/>
<Property name="ConsultingClinicians"/>
<Property name="CustomPairs"/>
<Property name="DecisionToAdmitTime"/>
<Property name="DepressionScreening"/>
<Property name="DiagnosisRelatedGroup"/>
<Property name="DischargeDisposition"/>
<Property name="DischargeLocation"/>
<Property name="EmergencyAdmitDateTime"/>
<Property name="EncounterCodedType"/>
<Property name="EncounterMRN"/>
<Property name="EncounterMRNAA"/>
<Property name="EncounterNumber"/>
<Property name="EncounterType"/>
<Property name="EndTime"/>
<Property name="EnteredAt"/>
<Property name="EnteredBy"/>
<Property name="EnteredOn"/>
<Property name="ExpectedAdmitTime"/>
<Property name="ExpectedDischargeTime"/>
<Property name="ExpectedLOAReturnTime"/>
<Property name="Extension"/>
<Property name="ExternalId"/>
<Property name="FromTime"/>
<Property name="HSAAEncID"/>
<Property name="HealthCareFacility"/>
<Property name="HealthFunds"/>
<Property name="HealthPlan"/>
<Property name="LOS"/>
<Property name="LastUpdated"/>
<Property name="LipidLoweringTherapyPrescribedAtDischarge"/>
<Property name="OrderToAdmitTime"/>
<Property name="Patient"/>
<Property name="PreAdmissionNumber"/>
<Property name="PriorBed"/>
<Property name="PriorRoom"/>
<Property name="PriorVisitNumber"/>
<Property name="PriorWard"/>
<Property name="Priority"/>
<Property name="PublicityCode"/>
<Property name="ReadmitForEncounter"/>
<Property name="RecommendationsProvided"/>
<Property name="ReferringClinician"/>
<Property name="Site"/>
<Property name="SmokingCessationCounseling"/>
<Property name="Specialties"/>
<Property name="StartTime"/>
<Property name="StatinPrescribedAtDischarge"/>
<Property name="Tag"/>
<Property name="TagFacility"/>
<Property name="ToTime"/>
<Property name="TransferredFromED"/>
<Property name="UpdatedOn"/>
<Property name="VisitDescription"/>
<Property name="VisitNumber"/>
<Property name="VisitStatus"/>
<SQLMap name="$Encounter"/>
<SQLMap name="AdmittingClinicianFamilyNameIndex"/>
<SQLMap name="EncounterTypeIndex"/>
<SQLMap name="EndTimeIndex"/>
<SQLMap name="EnteredAtIndex"/>
<SQLMap name="ExpectedAdmitTimeIndex"/>
<SQLMap name="ExpectedDischargeTimeIndex"/>
<SQLMap name="HealthCareFacilityIndex"/>
<SQLMap name="HealthPlanIndex"/>
<SQLMap name="IDKEY"/>
<SQLMap name="LastUpdatedIndex"/>
<SQLMap name="PatientIndex"/>
<SQLMap name="PatientStartTimeIndex"/>
<SQLMap name="ReadmitForEncounterIndex"/>
<SQLMap name="SiteIndex"/>
<SQLMap name="StartTimeIndex"/>
<SQLMap name="TFIx"/>
<SQLMap name="TagIndex"/>
<SQLMap name="VisitNumberIndex"/>
<StreamLocation>^HSAA.EncounterS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
