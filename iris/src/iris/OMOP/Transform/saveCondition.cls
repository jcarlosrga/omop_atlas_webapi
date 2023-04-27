/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.saveCondition Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Proxy.conditionItem, target As OMOP.Request.saveConditionBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveConditionBO).%New()
		
		//get links from visit
		s providerId = ""
		s careSiteId = ""
		s visitId = ""
		s visitDetailsId = ""
		d ..getVisitInfo(source.encounter, .providerId, .careSiteId, .visitId, .visitDetailsId)
		
		s target.type = "saveCondition"
		
		s target.conditionOccurrenceId = ""
		s target.personId = source.personId
		s target.conditionConceptId = ..getLookUpTblValue("condition_occurrence","condition_concept_id", $s(source.eventConceptId'="":source.eventConceptId,1:source.eventSourceValue) )
		
		i target.conditionConceptId = "non-standard" {
			/// LOGERROR	non-standard  concept
		}
		i target.conditionConceptId = "" {
			s target.conditionConceptId = "44790729"
			/// LOGERROR	unknown condition
		}
		
		s target.conditionStartDate = source.eventStartTime
		i target.conditionStartDate = "" s target.conditionStartDate = source.eventEndTime
		i target.conditionStartDate = "" s target.conditionStartDate = source.eventEnteredonDate
		if target.conditionStartDate = "" {
			s target.conditionStartDate = ..getVisitStartDateTime(source.encounter)
			; !!! LOGERROR
			if target.conditionStartDate = "" {
				s target.conditionStartDate = ..getPersonSourceDateTime(source.personId)
				; !!! LOGERROR
				
			}
		}
		s target.conditionStartDate = $e(target.conditionStartDate,1,10)
		
		s target.conditionStartDatetime = source.eventStartTime
		i target.conditionStartDatetime = "" s target.conditionStartDatetime = source.eventEndTime
		i target.conditionStartDatetime = "" s target.conditionStartDatetime = source.eventEnteredonDate
		if target.conditionStartDatetime = "" {
			s target.conditionStartDatetime = ..getVisitStartDateTime(source.encounter)
			; !!! LOGERROR
			if target.conditionStartDatetime = "" {
				s target.conditionStartDatetime = ..getPersonSourceDateTime(source.personId)
				; !!! LOGERROR
				
			}
		}
		
		s target.conditionEndDate = source.eventEndTime
		i target.conditionEndDate = "" s target.conditionEndDate = target.conditionStartDatetime
		s target.conditionEndDate = $e(target.conditionEndDate,1,10)
		
		s target.conditionEndDatetime = source.eventEndTime
		i target.conditionEndDatetime = "" s target.conditionEndDatetime = target.conditionStartDatetime
		
		s target.conditionTypeConceptId = 32827
		s target.conditionStatusConceptId = 0
		s target.stopReason = ""
		s target.providerId = providerId
		s target.visitOccurrenceId = visitId
		s target.visitDetailId = visitDetailsId
				
		
		if $zcvt(source.sourceTable,"L") = "allergy"{
			s target.conditionSourceValue = source.sourceId_"|a|"_source.eventSourceValue
		
		} elseif $zcvt(source.sourceTable,"L") = "allergyreaction"{
			s target.conditionSourceValue = source.sourceId_"|r|"_source.eventSourceValue

		}else{
			s target.conditionSourceValue = source.eventSourceValue	
			
		}
		s target.conditionSourceValue = $e(target.conditionSourceValue,1,50)
		
		s target.conditionStatusSourceValue = ""
		
		s target.conditionSourceConceptId = 0
		
	} catch e {
		s sc = e.AsStatus()
		$$$TRACE(sc)
	}
	q sc
}

}

