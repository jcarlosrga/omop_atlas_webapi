/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.saveObservation Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Proxy.ObservationItem, target As OMOP.Request.saveObservationBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveObservationBO).%New()
		
		s target.type = "saveObservation"
		

		
		//get links from visit
		s providerId = ""
		s careSiteId = ""
		s visitId = ""
		s visitDetailsId = ""
		d ..getVisitInfo(source.encounter, .providerId, .careSiteId, .visitId, .visitDetailsId)
		
		s target.observationId = ""		; autoincrement id
		s target.personId = ""			; refference from p.9
		s target.observationConceptId = ..getLookUpTblValue("observation","observation_concept_id", $s(source.eventConceptId'="":source.eventConceptId,1:source.eventSourceValue) )
		i target.observationConceptId = "non-standard" {
			/// LOGERROR	non-standard  concept
		}

		
		s target.observationDate = source.eventEnteredonDate
		; !!!
		i target.observationDate = "" s target.observationDate = source.eventStartTime
		i target.observationDate = "" s target.observationDate = ..getVisitStartDateTime(source.encounter)
		i target.observationDate = "" {
			s target.observationDate = ..getPersonSourceDateTime(source.personId)
		}
		s target.observationDate = $e(target.observationDate,1,10)
		i target.observationDate '= "" {
			set target.observationDate = $zdh($p(target.observationDate, " ", 1),3)
		}
		
		s target.observationDatetime = source.eventEnteredonDate
		; !!!
		i target.observationDate = "" s target.observationDate = source.eventStartTime
		i target.observationDatetime = "" s target.observationDatetime = ..getVisitStartDateTime(source.encounter)
		i target.observationDatetime = "" {
			s target.observationDatetime = ..getPersonSourceDateTime(source.personId)
		}
		
		s target.observationTypeConceptId = 32827
		s target.valueAsNumber = $s(source.valueSourceValue'="":+source.valueSourceValue,1:source.valueSourceValue)
		s target.valueAsString = ""
		s target.valueAsConceptId = ..getLookUpTblValue("any","value_as_concept_id",$p(source.valueSourceValue,"(",1))
		if target.valueAsConceptId = "" {
			set target.valueAsConceptId = 4129922
		}
		
		s target.qualifierConceptId = ..getLookUpTblValue("observation", "qualifier_concept_id", $s(source.qualifierConceptId'="":source.qualifierConceptId,1:source.qualifierSourceValue) )
		if target.qualifierConceptId = "" {
			set target.qualifierConceptId = 4129922
		}
		s target.unitConceptId = ..getLookUpTblValue("any","unit_concept_id", $s(source.unitConceptId'="":source.unitConceptId,1:source.unitSourceValue))
		s target.providerId = providerId
		s target.visitOccurrenceId = visitId
		s target.visitDetailId = visitDetailsId

		//"IF source_table = 'Allergy"" =>  concat values source_id, '|a|', event_source_value => trim up to 50 chars
		//IF source_table = 'AllergyReaction"" =>  concat values source_id, '|r|', event_source_value => trim up to 50 chars
		//IF another source_table => as is => trim up to 50 chars

		if $ZCVT(source.sourceTable, "L") = "allergy"{
			s target.observationSourceValue = source.sourceId_"|a|"_$e(source.eventSourceValue,1 ,50)

		} elseif $ZCVT(source.sourceTable, "L") = "allergyreaction"{
			s target.observationSourceValue = source.sourceId_"|r|"_$e(source.eventSourceValue,1 ,50)

		} else {
			s target.observationSourceValue = $e(source.eventSourceValue,1 ,50)

		}

		s target.observationSourceConceptId = 0
		s target.unitSourceValue = source.unitSourceValue
		s target.qualifierSourceValue = source.qualifierSourceValue
		
	} catch e {
		s sc = e.AsStatus()
		$$$TRACE(sc)
	}
	q sc
}

}

