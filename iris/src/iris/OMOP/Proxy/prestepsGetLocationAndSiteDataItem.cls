Class OMOP.Proxy.prestepsGetLocationAndSiteDataItem Extends (%Persistent, %XML.Adaptor)
{

Property ID As %String(MAXLEN = "", XMLNAME = "ID");

Property HealthCareFacility As %String(MAXLEN = "", XMLNAME = "HealthCareFacility");

Property IsPractice As %String(MAXLEN = "", XMLNAME = "IsPractice");

Property LastUpdated As %String(MAXLEN = "", XMLNAME = "LastUpdated");

Property Name As %String(MAXLEN = "", XMLNAME = "Name");

Property RawName As %String(MAXLEN = "", XMLNAME = "RawName");

Storage Default
{
<Data name="prestepsGetLocationAndSiteDataItemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ID</Value>
</Value>
<Value name="3">
<Value>HealthCareFacility</Value>
</Value>
<Value name="4">
<Value>IsPractice</Value>
</Value>
<Value name="5">
<Value>LastUpdated</Value>
</Value>
<Value name="6">
<Value>Name</Value>
</Value>
<Value name="7">
<Value>RawName</Value>
</Value>
</Data>
<DataLocation>^OMOP.Proxy.prestepsGet29A3D</DataLocation>
<DefaultData>prestepsGetLocationAndSiteDataItemDefaultData</DefaultData>
<IdLocation>^OMOP.Proxy.prestepsGet29A3D</IdLocation>
<IndexLocation>^OMOP.Proxy.prestepsGet29A3I</IndexLocation>
<StreamLocation>^OMOP.Proxy.prestepsGet29A3S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
