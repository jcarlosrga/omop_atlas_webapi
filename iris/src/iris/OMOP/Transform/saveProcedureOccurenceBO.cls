/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.saveProcedureOccurenceBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Proxy.MeasurementItem, target As OMOP.Request.saveProcedureOccurenceBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveProcedureOccurenceBO).%New()
		
		s target.type = "saveProcedureOccurence"
		
		//get links from visit
		s providerId = ""
		s careSiteId = ""
		s visitId = ""
		s visitDetailsId = ""
		d ..getVisitInfo(source.encounter, .providerId, .careSiteId, .visitId, .visitDetailsId)
		
		s target.procedureOccurrenceId = ""		; autoincrement id
		s target.personId = ""			; refference from p.9
		s target.procedureConceptId = ..getLookUpTblValue("procedure_occurrence","procedure_concept_id", $s(source.eventConceptId'="":source.eventConceptId,1:source.eventSourceValue) )
		if target.procedureConceptId = 0 {
			; !!! LOGERROR !!!
		}
		
		s target.procedureDate = source.eventEnteredonDate
		if target.procedureDate = "" set target.procedureDate = ..getVisitStartDateTime(source.encounter) 
		if target.procedureDate = "" {
			set target.procedureDate = ..getPersonSourceDateTime(source.personId)
		}
		s target.procedureDate = $e(target.procedureDate,1,10)
		
		s target.procedureDatetime = source.eventEnteredonDate
		if target.procedureDatetime = "" set target.procedureDatetime = ..getVisitStartDateTime(source.encounter) 
		if target.procedureDatetime = "" {
			set target.procedureDatetime = ..getPersonSourceDateTime(source.personId)
		}

		
		s target.procedureTypeConceptId = 32827
		s target.modifierConceptId = 0
		s target.quantity = source.quantity
		s target.providerId = providerId
		s target.visitOccurrenceId = visitId
		s target.visitDetailId = visitDetailsId
		if $ZCVT(source.sourceTable,"L") = "allergy"{
			s target.procedureSourceValue = source.sourceId_"|a|"_source.eventSourceValue
		
		} elseif $ZCVT(source.sourceTable,"L") = "allergyreaction"{
			s target.procedureSourceValue = source.sourceId_"|r|"_source.eventSourceValue

		} else {
			s target.procedureSourceValue = source.eventSourceValue
			
		}
		s target.procedureSourceValue = $e(target.procedureSourceValue	,1,50)
		
		s target.procedureSourceConceptId = 0
		s target.modifierSourceValue = ""
				
	} catch e {
		s sc = e.AsStatus()
		$$$TRACE(sc)
	}
	q sc
}

}

