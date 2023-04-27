Class OMOP.Response.getCareProviderInfoBO Extends Ens.Response
{

Property Description As %String(MAXLEN = "", XMLNAME = "Description");

Property NationalProviderID As %String(MAXLEN = "", XMLNAME = "NationalProviderID");

Property DEANumber As %String(MAXLEN = "", XMLNAME = "DEANumber");

Property Specialty As %String(MAXLEN = "", XMLNAME = "Specialty");

Property Code As %String(MAXLEN = "", XMLNAME = "Code");

Property SDACodingStandard As %String(MAXLEN = "", XMLNAME = "SDACodingStandard");

Property LastUpdated As %String(MAXLEN = "", XMLNAME = "LastUpdated");

Storage Default
{
<Data name="getCareProviderInfoBODefaultData">
<Subscript>"getCareProviderInfoBO"</Subscript>
<Value name="1">
<Value>CareProviderId</Value>
</Value>
<Value name="2">
<Value>CareProvider</Value>
</Value>
<Value name="3">
<Value>ClinicianDescription</Value>
</Value>
<Value name="4">
<Value>NationalProviderID</Value>
</Value>
<Value name="5">
<Value>DEANumber</Value>
</Value>
<Value name="6">
<Value>Specialty</Value>
</Value>
<Value name="7">
<Value>careSiteId</Value>
</Value>
<Value name="8">
<Value>Description</Value>
</Value>
<Value name="9">
<Value>Code</Value>
</Value>
<Value name="10">
<Value>SDACodingStandard</Value>
</Value>
<Value name="11">
<Value>LastUpdated</Value>
</Value>
</Data>
<DefaultData>getCareProviderInfoBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
