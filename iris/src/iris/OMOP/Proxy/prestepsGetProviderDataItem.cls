Class OMOP.Proxy.prestepsGetProviderDataItem Extends (%Persistent, %XML.Adaptor)
{

Property ID As %String(MAXLEN = "", XMLNAME = "ID");

Property BHSID As %String(MAXLEN = "", XMLNAME = "BHSID");

Property Provider As %String(MAXLEN = "", XMLNAME = "Provider");

Property SDACode As %String(MAXLEN = "", XMLNAME = "SDACode");

Property StartDate As %String(MAXLEN = "", XMLNAME = "StartDate");

Property EndDate As %String(MAXLEN = "", XMLNAME = "EndDate");

Property LastUpdated As %String(MAXLEN = "", XMLNAME = "LastUpdated");

Property SiteID As %String(MAXLEN = "", XMLNAME = "SiteID");

Property Site As %String(MAXLEN = "", XMLNAME = "Site");

Property HCFID As %String(MAXLEN = "", XMLNAME = "HCFID");

Property HCFacility As %String(MAXLEN = "", XMLNAME = "HCFacility");

Property HCFName As %String(MAXLEN = "", XMLNAME = "HCFName");

Property NationalProviderID As %String(MAXLEN = "", XMLNAME = "NationalProviderID");

Property DEANumber As %String(MAXLEN = "", XMLNAME = "DEANumber");

Property Specialty As %String(MAXLEN = "", XMLNAME = "Specialty");

Storage Default
{
<Data name="prestepsGetProviderDataItemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ID</Value>
</Value>
<Value name="3">
<Value>BHSID</Value>
</Value>
<Value name="4">
<Value>Provider</Value>
</Value>
<Value name="5">
<Value>SDACode</Value>
</Value>
<Value name="6">
<Value>StartDate</Value>
</Value>
<Value name="7">
<Value>EndDate</Value>
</Value>
<Value name="8">
<Value>LastUpdated</Value>
</Value>
<Value name="9">
<Value>SiteID</Value>
</Value>
<Value name="10">
<Value>Site</Value>
</Value>
<Value name="11">
<Value>HCFID</Value>
</Value>
<Value name="12">
<Value>HCFacility</Value>
</Value>
<Value name="13">
<Value>HCFName</Value>
</Value>
<Value name="14">
<Value>NationalProviderID</Value>
</Value>
<Value name="15">
<Value>DEANumber</Value>
</Value>
<Value name="16">
<Value>Specialty</Value>
</Value>
</Data>
<DataLocation>^OMOP.Proxy.prestepsGetD1F6D</DataLocation>
<DefaultData>prestepsGetProviderDataItemDefaultData</DefaultData>
<IdLocation>^OMOP.Proxy.prestepsGetD1F6D</IdLocation>
<IndexLocation>^OMOP.Proxy.prestepsGetD1F6I</IndexLocation>
<StreamLocation>^OMOP.Proxy.prestepsGetD1F6S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
