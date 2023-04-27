/// 
/// 20211012 Denis Bulashev
/// data transformation errors storage
/// 
Class OMOP.Storage.Errors Extends %Persistent
{

Property omopTblId As %String(MAXLEN = "", XMLNAME = "omop_tbl_id");

Property omopField As %String(MAXLEN = "", XMLNAME = "omop_field");

Property omopRecordId As %String(MAXLEN = "", XMLNAME = "omop_record_id");

Property omopValue As %String(MAXLEN = "", XMLNAME = "omop_value");

Property sourceTbl As %String(MAXLEN = "", XMLNAME = "source_tbl");

Property sourceField As %String(MAXLEN = "", XMLNAME = "source_field");

Property sourceRecordId As %String(MAXLEN = "", XMLNAME = "source_record_id");

Property sourceValue As %String(MAXLEN = "", XMLNAME = "omop_value");

Storage Default
{
<Data name="ErrorsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>omopTblId</Value>
</Value>
<Value name="3">
<Value>omopField</Value>
</Value>
<Value name="4">
<Value>omopRecordId</Value>
</Value>
<Value name="5">
<Value>sourceTbl</Value>
</Value>
<Value name="6">
<Value>sourceField</Value>
</Value>
<Value name="7">
<Value>sourceRecordId</Value>
</Value>
<Value name="8">
<Value>sourceValue</Value>
</Value>
<Value name="9">
<Value>omopValue</Value>
</Value>
</Data>
<DataLocation>^OMOP.Storage.ErrorsD</DataLocation>
<DefaultData>ErrorsDefaultData</DefaultData>
<IdLocation>^OMOP.Storage.ErrorsD</IdLocation>
<IndexLocation>^OMOP.Storage.ErrorsI</IndexLocation>
<StreamLocation>^OMOP.Storage.ErrorsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
