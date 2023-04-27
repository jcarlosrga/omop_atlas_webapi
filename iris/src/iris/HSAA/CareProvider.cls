/// DO NOT EDIT - You should not directly alter this class in your applications.
Class HSAA.CareProvider Extends %Persistent
{

Property Description As %String(MAXLEN = "") [ SqlFieldName = Description ];

Property AddressCityCode As %String(MAXLEN = "") [ SqlFieldName = Address_City_Code ];

Property AddressStateCode As %String(MAXLEN = "") [ SqlFieldName = Address_State_Code ];

Property AddressStreet As %String(MAXLEN = "") [ SqlFieldName = Address_Street ];

Property AddressZipCode As %String(MAXLEN = "") [ SqlFieldName = Address_Zip_Code ];

Property Code As %String(MAXLEN = "") [ SqlFieldName = Code ];

Property SDACodingStandard As %String(MAXLEN = "") [ SqlFieldName = SDACodingStandard ];

Property NationalProviderID As %String(MAXLEN = "") [ SqlFieldName = NationalProviderID ];

Property DEANumber As %String(MAXLEN = "") [ SqlFieldName = DEANumber ];

Property Specialty As %String(MAXLEN = "") [ SqlFieldName = Specialty ];

Property LastUpdated As %String(MAXLEN = "") [ SqlFieldName = LastUpdated ];

Property AddressCountryCode As %String(MAXLEN = "") [ SqlFieldName = Address_Country_Code ];

Property facilitycode As %String(MAXLEN = "") [ SqlFieldName = facilitycode ];

/// /
/// /// Allow synchronization
/// /
/// /Parameter DSTIME = "AUTO";
/// /
/// /Index NameIndex On (Name.FamilyName, Name.GivenName, Name.MiddleName);
/// /
/// /Index NationalProviderIDIndex On NationalProviderID;
/// /
/// /Index DEANumberIndex On DEANumber;
/// /
/// /Index SDACodingStandardIndex On SDACodingStandard [ Type = bitmap ];
/// /
/// /Index CodeIndex On Code;
/// /
/// /Index CFNSCSIx On (Code, Name.FamilyName, SDACodingStandard);
/// /
/// /Index CDSCSIx On (Code, Description As SQLUPPER(100), SDACodingStandard);
/// /
/// //*
/// //// allergy
/// /Relationship AllergyRel As HSAA.Allergy [ Cardinality = many, Inverse = CareProvider ];
/// /*/
/// //// Care provider site/care provider relationship
/// /Relationship CareProviderSiteRel As HSAA.CareProviderSite [ Cardinality = many, Inverse = CareProvider ];
/// /
/// //// Clinical relationship/care provider relationship
/// /Relationship ClinicalRelationshipRel As HSAA.ClinicalRelationship [ Cardinality = many, Inverse = CareProvider ];
/// /
/// //// Program/care provider relationship
/// /Relationship ProgramRel As HSAA.Program [ Cardinality = many, Inverse = CareProvider ];
/// /
/// //// Create the index for the care provider name - this guarantees a unique index even if two differently coded</br>
/// //// care providers have the same name</br>
/// //// <var>Code</var> - code field</br>
/// //// <var>Description</var> - description field</br>
/// //// <var>SDACodingStandard</var> - any SDA coding standard</br>
/// //// <var>GivenName</var> - given name</br>
/// //// <var>MiddleName</var> - middle name</br>
/// //// <var>FamilyNamePrefix</var> - prefix to family name</br>
/// //// <var>FamilyName</var> - family name</br>
/// //// <var>NameSuffix</var> - name suffix</br>
/// //// <var>ProfessionalSuffix</var> - professional suffix</br>
/// /ClassMethod CareProviderNameIndex(code As %String, description As %String, SDACodingStandard As %String, GivenName As %String, MiddleName As %String, FamilyNamePrefix As %String, FamilyName As %String, NameSuffix As %String, ProfessionalSuffix As %String) As %String
/// /{
/// /	quit code_description_SDACodingStandard_##class(HSAA.Util.Format).FormatName(GivenName, MiddleName, FamilyNamePrefix, FamilyName, NameSuffix, ProfessionalSuffix)
/// /}
Storage Default
{
<Data name="CareProviderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Address</Value>
</Value>
<Value name="4">
<Value>ContactInfo</Value>
</Value>
<Value name="5">
<Value>NationalProviderID</Value>
</Value>
<Value name="6">
<Value>Specialty</Value>
</Value>
<Value name="7">
<Value>BoardCertified</Value>
</Value>
<Value name="8">
<Value>HealthCareFacility</Value>
</Value>
<Value name="9">
<Value>Tag</Value>
</Value>
<Value name="10">
<Value>DEANumber</Value>
</Value>
<Value name="11">
<Value>Specialty2</Value>
</Value>
<Value name="12">
<Value>Specialty3</Value>
</Value>
<Value name="13">
<Value>Specialty4</Value>
</Value>
<Value name="14">
<Value>Type</Value>
</Value>
<Value name="15">
<Value>TIN</Value>
</Value>
<Value name="16">
<Value>PrimaryCare</Value>
</Value>
<Value name="17">
<Value>Gender</Value>
</Value>
<Value name="18">
<Value>SDATableName</Value>
</Value>
<Value name="19">
<Value>SDACodingStandard</Value>
</Value>
<Value name="20">
<Value>Code</Value>
</Value>
<Value name="21">
<Value>Description</Value>
</Value>
<Value name="22">
<Value>InternalReference</Value>
</Value>
<Value name="23">
<Value>EId</Value>
</Value>
<Value name="24">
<Value>ErrorStatus</Value>
</Value>
<Value name="25">
<Value>CareProviderType</Value>
</Value>
<Value name="26">
<Value>EnteredBy</Value>
</Value>
<Value name="27">
<Value>EnteredAt</Value>
</Value>
<Value name="28">
<Value>EnteredOn</Value>
</Value>
<Value name="29">
<Value>LastUpdated</Value>
</Value>
<Value name="30">
<Value>Extension</Value>
</Value>
<Value name="31">
<Value>NameTypeCode</Value>
</Value>
<Value name="32">
<Value>UpdatedOn</Value>
</Value>
<Value name="33">
<Value>FromTime</Value>
</Value>
<Value name="34">
<Value>ToTime</Value>
</Value>
<Value name="35">
<Value>ExternalId</Value>
</Value>
<Value name="36">
<Value>EncounterNumber</Value>
</Value>
<Value name="37">
<Value>IdentifierTypeCode</Value>
</Value>
<Value name="38">
<Value>AtOrganization</Value>
</Value>
<Value name="39">
<Value>AddressCityCode</Value>
</Value>
<Value name="40">
<Value>AddressStateCode</Value>
</Value>
<Value name="41">
<Value>AddressStreet</Value>
</Value>
<Value name="42">
<Value>AddressZipCode</Value>
</Value>
<Value name="43">
<Value>AddressCountryCode</Value>
</Value>
<Value name="44">
<Value>facilitycode</Value>
</Value>
</Data>
<DataLocation>^HSAA.CareProviderD</DataLocation>
<DefaultData>CareProviderDefaultData</DefaultData>
<Description>
<![CDATA[/
/// Allow synchronization
/
/Parameter DSTIME = "AUTO";
/
/Index NameIndex On (Name.FamilyName, Name.GivenName, Name.MiddleName);
/
/Index NationalProviderIDIndex On NationalProviderID;
/
/Index DEANumberIndex On DEANumber;
/
/Index SDACodingStandardIndex On SDACodingStandard [ Type = bitmap ];
/
/Index CodeIndex On Code;
/
/Index CFNSCSIx On (Code, Name.FamilyName, SDACodingStandard);
/
/Index CDSCSIx On (Code, Description As SQLUPPER(100), SDACodingStandard);
/
//*
//// allergy
/Relationship AllergyRel As HSAA.Allergy [ Cardinality = many, Inverse = CareProvider ];
/*/
//// Care provider site/care provider relationship
/Relationship CareProviderSiteRel As HSAA.CareProviderSite [ Cardinality = many, Inverse = CareProvider ];
/
//// Clinical relationship/care provider relationship
/Relationship ClinicalRelationshipRel As HSAA.ClinicalRelationship [ Cardinality = many, Inverse = CareProvider ];
/
//// Program/care provider relationship
/Relationship ProgramRel As HSAA.Program [ Cardinality = many, Inverse = CareProvider ];
/
//// Create the index for the care provider name - this guarantees a unique index even if two differently coded</br>
//// care providers have the same name</br>
//// <var>Code</var> - code field</br>
//// <var>Description</var> - description field</br>
//// <var>SDACodingStandard</var> - any SDA coding standard</br>
//// <var>GivenName</var> - given name</br>
//// <var>MiddleName</var> - middle name</br>
//// <var>FamilyNamePrefix</var> - prefix to family name</br>
//// <var>FamilyName</var> - family name</br>
//// <var>NameSuffix</var> - name suffix</br>
//// <var>ProfessionalSuffix</var> - professional suffix</br>
/ClassMethod CareProviderNameIndex(code As %String, description As %String, SDACodingStandard As %String, GivenName As %String, MiddleName As %String, FamilyNamePrefix As %String, FamilyName As %String, NameSuffix As %String, ProfessionalSuffix As %String) As %String
/{
/	quit code_description_SDACodingStandard_##class(HSAA.Util.Format).FormatName(GivenName, MiddleName, FamilyNamePrefix, FamilyName, NameSuffix, ProfessionalSuffix)
/}]]></Description>
<ExtentSize>0</ExtentSize>
<IdLocation>^HSAA.CareProviderD</IdLocation>
<IndexLocation>^HSAA.CareProviderI</IndexLocation>
<Property name="%%CLASSNAME"/>
<Property name="%%ID"/>
<Property name="Address"/>
<Property name="AtOrganization"/>
<Property name="BoardCertified"/>
<Property name="CareProviderType"/>
<Property name="Code"/>
<Property name="ContactInfo"/>
<Property name="DEANumber"/>
<Property name="Description"/>
<Property name="EnteredAt"/>
<Property name="EnteredBy"/>
<Property name="EnteredOn"/>
<Property name="Extension"/>
<Property name="Gender"/>
<Property name="HealthCareFacility"/>
<Property name="IdentifierTypeCode"/>
<Property name="LastUpdated"/>
<Property name="Name"/>
<Property name="NameTypeCode"/>
<Property name="NationalProviderID"/>
<Property name="PrimaryCare"/>
<Property name="SDACodingStandard"/>
<Property name="Specialty"/>
<Property name="Specialty2"/>
<Property name="Specialty3"/>
<Property name="Specialty4"/>
<Property name="TIN"/>
<Property name="Tag"/>
<Property name="Type"/>
<Property name="UpdatedOn"/>
<SQLMap name="$CareProvider"/>
<SQLMap name="CDSCSIx"/>
<SQLMap name="CFNSCSIx"/>
<SQLMap name="CodeIndex"/>
<SQLMap name="DEANumberIndex"/>
<SQLMap name="FamilyNameIndex"/>
<SQLMap name="IDKEY"/>
<SQLMap name="LastUpdatedIndex"/>
<SQLMap name="NameIndex"/>
<SQLMap name="NationalProviderIDIndex"/>
<SQLMap name="SDACodingStandard"/>
<SQLMap name="SDACodingStandardIndex"/>
<SQLMap name="TagIndex"/>
<StreamLocation>^HSAA.CareProviderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
