/// 
/// datatransformation for patients notes
/// 
Class OMOP.Transform.saveNoteBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Proxy.eventItem, target As OMOP.Request.saveNoteBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveNoteBO).%New()
		
		s target.type = "saveNote"
		
		//get links from visit
		s providerId = ""
		s careSiteId = ""
		s visitId = ""
		s visitDetailsId = ""
		d ..getVisitInfo(source.encounter, .providerId, .careSiteId, .visitId, .visitDetailsId)
		
		s target.noteId = ""
		s target.personId = ""
		
		s target.noteDate = source.eventStartTime
		i target.noteDate = "" s target.noteDate = source.eventEndTime
		i target.noteDate = "" s target.noteDate = source.eventEnteredonDate
		if target.noteDate = "" set target.noteDate = ..getVisitStartDateTime(source.encounter) 
		if target.noteDate = "" {
			set target.noteDate = ..getPersonSourceDateTime(source.personId)
		}
		s target.noteDate = $e(target.noteDate,1,10)
		
		s target.noteDatetime = source.eventStartTime
		i target.noteDatetime = "" s target.noteDatetime = source.eventEndTime
		i target.noteDatetime = "" s target.noteDatetime = source.eventEnteredonDate
		if target.noteDatetime = "" set target.noteDatetime = ..getVisitStartDateTime(source.encounter) 
		if target.noteDatetime = "" {
			set target.noteDatetime = ..getPersonSourceDateTime(source.personId)
		}
		
		s target.noteTypeConceptId = 32827
		s target.noteClassConceptId = ..getLookUpTblValue("note","note_class__concept_id", $s(source.eventConceptId'="":source.eventConceptId,1:source.eventSourceValue) )
		i target.noteClassConceptId = "" {
			s target.noteClassConceptId = 0
			; !!! LOG ERROR
		}
		s target.noteTitle = source.valueSourceValue
		s target.noteText = source.note
		s target.encodingConceptId = 32678
		s target.languageConceptId = 4180186
		s target.providerId = providerId
		s target.visitOccurrenceId = visitId
		s target.visitDetailId = visitDetailsId
		s target.noteSourceValue = source.eventSourceValue

		
	} catch e {
		s sc = e.AsStatus()
		$$$TRACE(sc)
	}
	q sc
}

}

