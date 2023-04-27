Class OMOP.Proxy.saveDataToIRIS Extends (%Persistent, %XML.Adaptor)
{

Property items As list Of OMOP.Request.saveDataCommonBO;

Storage Default
{
<Data name="saveDataToIRISDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>items</Value>
</Value>
</Data>
<DataLocation>^OMOP.Proxy.saveDataToIRISD</DataLocation>
<DefaultData>saveDataToIRISDefaultData</DefaultData>
<IdLocation>^OMOP.Proxy.saveDataToIRISD</IdLocation>
<IndexLocation>^OMOP.Proxy.saveDataToIRISI</IndexLocation>
<StreamLocation>^OMOP.Proxy.saveDataToIRISS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
