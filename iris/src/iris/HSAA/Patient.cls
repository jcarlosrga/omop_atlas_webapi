/// DO NOT EDIT - You should not directly alter this class in your applications.
/// 	HSAA.Indices.Patient
Class HSAA.Patient Extends %Persistent
{

// Allow synchronization

/// Property ID1 As %String(MAXLEN = "") [ SqlFieldName = ID ];
Property DeathTime As %String(MAXLEN = "");

Property Deceased As %String(MAXLEN = "");

Property BirthTime As %String(MAXLEN = "");

Property RaceCode As %String(MAXLEN = "") [ SqlFieldName = Race_Code ];

Property RaceDescription As %String(MAXLEN = "") [ SqlFieldName = Race_Description ];

Property EthnicGroupCode As %String(MAXLEN = "") [ SqlFieldName = EthnicGroup_Code ];

Property EthnicGroupDescription As %String(MAXLEN = "") [ SqlFieldName = EthnicGroup_Description ];

Property AddressStreet As %String(MAXLEN = "") [ SqlFieldName = Address_Street ];

Property AddressCityDescription As %String(MAXLEN = "") [ SqlFieldName = Address_City_Description ];

Property AddressCountRyCode As %String(MAXLEN = "") [ SqlFieldName = Address_CountRy_Code ];

Property AddressStateCode As %String(MAXLEN = "") [ SqlFieldName = Address_State_Code ];

Property AddressZipCode As %String(MAXLEN = "") [ SqlFieldName = Address_Zip_Code ];

Property GenderCode As %String(MAXLEN = "") [ SqlFieldName = Gender_Code ];

Property GenderDescription As %String(MAXLEN = "") [ SqlFieldName = Gender_Description ];

Property BirthGenderCode As %String(MAXLEN = "") [ SqlFieldName = BirthGender_Code ];

Property BirthGenderDescription As %String(MAXLEN = "") [ SqlFieldName = BirthGender_Description ];

Property RawGenderCode As %String(MAXLEN = "") [ SqlFieldName = RawGender_Code ];

Property RawGenderDescription As %String(MAXLEN = "") [ SqlFieldName = RawGender_Description ];

Property AddressCityCode As %String(MAXLEN = "") [ SqlFieldName = Address_City_Code ];

Property CreatedOn As %String(MAXLEN = "") [ SqlFieldName = CreatedOn ];

/// 

Storage Default
{
<Data name="Numbers">
<Attribute>Numbers</Attribute>
<Structure>subnode</Structure>
<Subscript>"Numbers"</Subscript>
</Data>
<Data name="PatientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>HSAAID</Value>
</Value>
<Value name="3">
<Value>MPIID</Value>
</Value>
<Value name="4">
<Value>Name</Value>
</Value>
<Value name="5">
<Value>Alias</Value>
</Value>
<Value name="6">
<Value>PrimaryLanguage</Value>
</Value>
<Value name="7">
<Value>Religion</Value>
</Value>
<Value name="8">
<Value>MaritalStatus</Value>
</Value>
<Value name="9">
<Value>Gender</Value>
</Value>
<Value name="10">
<Value>Race</Value>
</Value>
<Value name="11">
<Value>Ethnicity</Value>
</Value>
<Value name="12">
<Value>Occupation</Value>
</Value>
<Value name="13">
<Value>BirthTime</Value>
</Value>
<Value name="14">
<Value>BirthDate</Value>
</Value>
<Value name="15">
<Value>DeathTime</Value>
</Value>
<Value name="16">
<Value>Deceased</Value>
</Value>
<Value name="17">
<Value>IsMultipleBirth</Value>
</Value>
<Value name="18">
<Value>BirthOrder</Value>
</Value>
<Value name="19">
<Value>Age</Value>
</Value>
<Value name="20">
<Value>BirthPlace</Value>
</Value>
<Value name="21">
<Value>IsIdentityUnknown</Value>
</Value>
<Value name="22">
<Value>SetIsPregnant</Value>
</Value>
<Value name="23">
<Value>AccountNumber</Value>
</Value>
<Value name="24">
<Value>Address</Value>
</Value>
<Value name="25">
<Value>ContactInfo</Value>
</Value>
<Value name="26">
<Value>HealthPlan</Value>
</Value>
<Value name="27">
<Value>Tag</Value>
</Value>
<Value name="28">
<Value>Aliases</Value>
</Value>
<Value name="29">
<Value>RawGender</Value>
</Value>
<Value name="30">
<Value>SSNOrProxy</Value>
</Value>
<Value name="31">
<Value>EthnicGroup</Value>
</Value>
<Value name="32">
<Value>CarrierSpecificMemberID</Value>
</Value>
<Value name="33">
<Value>CommunicationPreferences</Value>
</Value>
<Value name="34">
<Value>CommunicationPreference</Value>
</Value>
<Value name="35">
<Value>Races</Value>
</Value>
<Value name="36">
<Value>Addresses</Value>
</Value>
<Value name="37">
<Value>Comments</Value>
</Value>
<Value name="38">
<Value>EnteredBy</Value>
</Value>
<Value name="39">
<Value>CreatedBy</Value>
</Value>
<Value name="40">
<Value>EnteredAt</Value>
</Value>
<Value name="41">
<Value>EnteredOn</Value>
</Value>
<Value name="42">
<Value>CreatedOn</Value>
</Value>
<Value name="43">
<Value>UpdatedOn</Value>
</Value>
<Value name="44">
<Value>LastUpdated</Value>
</Value>
<Value name="45">
<Value>PatientNumbers</Value>
</Value>
<Value name="46">
<Value>Extension</Value>
</Value>
<Value name="47">
<Value>BlankNameReason</Value>
</Value>
<Value name="48">
<Value>MothersMaidenName</Value>
</Value>
<Value name="49">
<Value>MothersFullName</Value>
</Value>
<Value name="50">
<Value>OtherLanguages</Value>
</Value>
<Value name="51">
<Value>CustomPairs</Value>
</Value>
<Value name="52">
<Value>SupportContacts</Value>
</Value>
<Value name="53">
<Value>IsProtected</Value>
</Value>
<Value name="54">
<Value>ProtectedEffectiveDate</Value>
</Value>
<Value name="55">
<Value>DeathLocation</Value>
</Value>
<Value name="56">
<Value>DeathDeclaredBy</Value>
</Value>
<Value name="57">
<Value>Citizenship</Value>
</Value>
<Value name="58">
<Value>PriorPatientNumbers</Value>
</Value>
<Value name="59">
<Value>FamilyDoctor</Value>
</Value>
<Value name="60">
<Value>InactiveMRNs</Value>
</Value>
<Value name="61">
<Value>PublicityCode</Value>
</Value>
<Value name="62">
<Value>PublicityEffectiveDate</Value>
</Value>
<Value name="63">
<Value>ImmunizationRegistryStatus</Value>
</Value>
<Value name="64">
<Value>ImmunizationRegistryStatusEffectiveDate</Value>
</Value>
<Value name="65">
<Value>EncounterNumber</Value>
</Value>
<Value name="66">
<Value>FromTime</Value>
</Value>
<Value name="67">
<Value>ToTime</Value>
</Value>
<Value name="68">
<Value>ExternalId</Value>
</Value>
<Value name="69">
<Value>Providers</Value>
</Value>
<Value name="70">
<Value>Organizations</Value>
</Value>
<Value name="71">
<Value>EnteredAt2</Value>
</Value>
<Value name="72">
<Value>BirthGender</Value>
</Value>
<Value name="73">
<Value>ID</Value>
</Value>
<Value name="74">
<Value>RaceCode</Value>
</Value>
<Value name="75">
<Value>RaceDescription</Value>
</Value>
<Value name="76">
<Value>EthnicGroupCode</Value>
</Value>
<Value name="77">
<Value>EthnicGroupDescription</Value>
</Value>
<Value name="78">
<Value>AddressStreet</Value>
</Value>
<Value name="79">
<Value>AddressCityDescription</Value>
</Value>
<Value name="80">
<Value>AddressCountRyCode</Value>
</Value>
<Value name="81">
<Value>AddressStateCode</Value>
</Value>
<Value name="82">
<Value>AddressZipCode</Value>
</Value>
<Value name="83">
<Value>GenderCode</Value>
</Value>
<Value name="84">
<Value>GenderDescription</Value>
</Value>
<Value name="85">
<Value>BirthGenderCode</Value>
</Value>
<Value name="86">
<Value>BirthGenderDescription</Value>
</Value>
<Value name="87">
<Value>RawGenderCode</Value>
</Value>
<Value name="88">
<Value>RawGenderDescription</Value>
</Value>
<Value name="89">
<Value>ID1</Value>
</Value>
<Value name="90">
<Value>AddressCityCode</Value>
</Value>
</Data>
<DataLocation>^HSAA.PatientD</DataLocation>
<DefaultData>PatientDefaultData</DefaultData>
<Description>
<![CDATA[
]]></Description>
<ExtentSize>0</ExtentSize>
<IdLocation>^HSAA.PatientD</IdLocation>
<IndexLocation>^HSAA.PatientI</IndexLocation>
<Property name="%%CLASSNAME"/>
<Property name="%%ID"/>
<Property name="AccountNumber"/>
<Property name="Address"/>
<Property name="Addresses"/>
<Property name="Age"/>
<Property name="AgeInMonths"/>
<Property name="Alias"/>
<Property name="Aliases"/>
<Property name="BirthDate"/>
<Property name="BirthGender"/>
<Property name="BirthOrder"/>
<Property name="BirthPlace"/>
<Property name="BirthTime"/>
<Property name="BlankNameReason"/>
<Property name="CarrierSpecificMemberID"/>
<Property name="Citizenship"/>
<Property name="Comments"/>
<Property name="CommunicationPreference"/>
<Property name="ContactInfo"/>
<Property name="CreatedBy"/>
<Property name="CreatedOn"/>
<Property name="CustomPairs"/>
<Property name="DeathDeclaredBy"/>
<Property name="DeathLocation"/>
<Property name="DeathTime"/>
<Property name="Deceased"/>
<Property name="EncounterNumber"/>
<Property name="EnteredAt"/>
<Property name="EnteredAt2"/>
<Property name="EnteredBy"/>
<Property name="EnteredOn"/>
<Property name="EthnicGroup"/>
<Property name="Ethnicity"/>
<Property name="Extension"/>
<Property name="ExternalId"/>
<Property name="FromTime"/>
<Property name="Gender"/>
<Property name="HSAAID"/>
<Property name="ImmunizationRegistryStatus"/>
<Property name="ImmunizationRegistryStatusEffectiveDate"/>
<Property name="InactiveMRNs"/>
<Property name="IsIdentityUnknown"/>
<Property name="IsMultipleBirth"/>
<Property name="IsProtected"/>
<Property name="LastUpdated"/>
<Property name="MPIID"/>
<Property name="MaritalStatus"/>
<Property name="MothersFullName"/>
<Property name="MothersMaidenName"/>
<Property name="Name"/>
<Property name="Occupation"/>
<Property name="OtherLanguages"/>
<Property name="PatientNumbers"/>
<Property name="PrimaryLanguage"/>
<Property name="PriorPatientNumbers"/>
<Property name="ProtectedEffectiveDate"/>
<Property name="PublicityCode"/>
<Property name="PublicityEffectiveDate"/>
<Property name="Race"/>
<Property name="Races"/>
<Property name="RawGender"/>
<Property name="Religion"/>
<Property name="SSNOrProxy"/>
<Property name="SetIsPregnant"/>
<Property name="SupportContacts"/>
<Property name="Tag"/>
<Property name="ToTime"/>
<Property name="UpdatedOn"/>
<SQLMap name="$Patient"/>
<SQLMap name="BirthDateIndex"/>
<SQLMap name="BirthTimeIndex"/>
<SQLMap name="CarrierSpecificMemberIDIndex"/>
<SQLMap name="DeathTimeIndex"/>
<SQLMap name="EnteredAt2Index"/>
<SQLMap name="EnteredAtIndex"/>
<SQLMap name="FamilyNameIndex"/>
<SQLMap name="GenderCodeIndex"/>
<SQLMap name="HSAAIDIndex"/>
<SQLMap name="IDKEY"/>
<SQLMap name="LastUpdatedIndex"/>
<SQLMap name="MPIIDIndex"/>
<SQLMap name="SSNOrProxyIndex"/>
<StreamLocation>^HSAA.PatientS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

Trigger OnUpdate [ Event = INSERT/UPDATE, Time = AFTER ]
{
	set id = {ID}
	
	// add patient to the list for future processing
	set patientRecord = ##class(HSAA.PatientList).patientIdIndOpen(id,2,.sc)

	if $$$ISERR(sc) {	// record not found
		set patientRecord = ##class(HSAA.PatientList).%New()
	}
	
	set patientRecord.patientId = id
	set sc = patientRecord.%Save()
}

}
