/// 
/// request for the saveData* operations to save information about note
/// 
Class OMOP.Request.saveNoteBO Extends OMOP.Request.saveDataCommonBO
{

Parameter RESPONSECLASSNAME = "OMOP.Response.saveNoteBO";

Property noteId As %String(MAXLEN = "", XMLNAME = "note_id");

Property personId As %String(MAXLEN = "", XMLNAME = "person_id");

Property noteDate As %String(MAXLEN = "", XMLNAME = "note_date");

Property noteDatetime As %String(MAXLEN = "", XMLNAME = "note_datetime");

Property noteTypeConceptId As %String(MAXLEN = "", XMLNAME = "note_type_concept_id");

Property noteClassConceptId As %String(MAXLEN = "", XMLNAME = "note_class_concept_id");

Property noteTitle As %String(MAXLEN = "", XMLNAME = "note_title");

Property noteText As %String(MAXLEN = "", XMLNAME = "note_text");

Property encodingConceptId As %String(MAXLEN = "", XMLNAME = "encoding_concept_id");

Property languageConceptId As %String(MAXLEN = "", XMLNAME = "language_concept_id");

Property providerId As %String(MAXLEN = "", XMLNAME = "provider_id");

Property visitOccurrenceId As %String(MAXLEN = "", XMLNAME = "visit_occurrence_id");

Property visitDetailId As %String(MAXLEN = "", XMLNAME = "visit_detail_id");

Property noteSourceValue As %String(MAXLEN = "", XMLNAME = "note_source_value");

Storage Default
{
<Data name="saveNoteBODefaultData">
<Subscript>"saveNoteBO"</Subscript>
<Value name="1">
<Value>specimenId</Value>
</Value>
<Value name="2">
<Value>personId</Value>
</Value>
<Value name="3">
<Value>specimenConceptId</Value>
</Value>
<Value name="4">
<Value>specimenTypeConceptId</Value>
</Value>
<Value name="5">
<Value>specimenDate</Value>
</Value>
<Value name="6">
<Value>specimenDatetime</Value>
</Value>
<Value name="7">
<Value>quantity</Value>
</Value>
<Value name="8">
<Value>unitConceptId</Value>
</Value>
<Value name="9">
<Value>anatomicSiteConceptId</Value>
</Value>
<Value name="10">
<Value>diseaseStatusConceptId</Value>
</Value>
<Value name="11">
<Value>specimenSourceId</Value>
</Value>
<Value name="12">
<Value>specimenSourceValue</Value>
</Value>
<Value name="13">
<Value>unitSourceValue</Value>
</Value>
<Value name="14">
<Value>anatomicSiteSourceValue</Value>
</Value>
<Value name="15">
<Value>diseaseStatusSourceValue</Value>
</Value>
<Value name="16">
<Value>noteId</Value>
</Value>
<Value name="17">
<Value>noteDate</Value>
</Value>
<Value name="18">
<Value>noteDatetime</Value>
</Value>
<Value name="19">
<Value>noteTypeConceptId</Value>
</Value>
<Value name="20">
<Value>noteClassConceptId</Value>
</Value>
<Value name="21">
<Value>noteTitle</Value>
</Value>
<Value name="22">
<Value>encodingConceptId</Value>
</Value>
<Value name="23">
<Value>languageConceptId</Value>
</Value>
<Value name="24">
<Value>providerId</Value>
</Value>
<Value name="25">
<Value>visitOccurrenceId</Value>
</Value>
<Value name="26">
<Value>visitDetailId</Value>
</Value>
<Value name="27">
<Value>noteSourceValue</Value>
</Value>
<Value name="28">
<Value>noteText</Value>
</Value>
</Data>
<DefaultData>saveNoteBODefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
