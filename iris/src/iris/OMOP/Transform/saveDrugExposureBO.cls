/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.saveDrugExposureBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Proxy.MeasurementItem, target As OMOP.Request.saveDrugExposureBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveDrugExposureBO).%New()
		
		s target.type = "saveDrugExposure"
		
		//get links from visit
		s providerId = ""
		s careSiteId = ""
		s visitId = ""
		s visitDetailsId = ""
		d ..getVisitInfo(source.encounter, .providerId, .careSiteId, .visitId, .visitDetailsId)
		
		s target.drugExposureId	= ""		; autoincrement id
		s target.personId = ""			; refference from p.9
		s target.drugConceptId = ..getLookUpTblValue("drug_exposure","drug_concept_id", $s(source.eventConceptId'="":source.eventConceptId,1:source.eventSourceValue) )
		if target.drugConceptId = "non-standard"{
			; !!! LOGERROR !!!
		}
		
		s target.drugExposureStartDate = source.eventStartTime
		if target.drugExposureStartDate = "" set target.drugExposureStartDate = ..getVisitStartDateTime(source.encounter) 
		if target.drugExposureStartDate = "" {
			set target.drugExposureStartDate = ..getPersonSourceDateTime(source.personId)
		}
		s target.drugExposureStartDate = $e(target.drugExposureStartDate,1,10)
		
		s target.drugExposureStartDatetime = source.eventStartTime
		if target.drugExposureStartDatetime = "" set target.drugExposureStartDatetime = ..getVisitStartDateTime(source.encounter) 
		if target.drugExposureStartDatetime = "" {
			set target.drugExposureStartDatetime = ..getPersonSourceDateTime(source.personId)
		}

		s target.drugExposureEndDate = source.eventEndTime
		i target.drugExposureEndDate = "" s target.drugExposureEndDate = target.drugExposureStartDatetime
		s target.drugExposureEndDate = $e(target.drugExposureEndDate,1,10)

		s target.drugExposureEndDatetime = source.eventEndTime
		i target.drugExposureEndDatetime = "" s target.drugExposureEndDatetime = target.drugExposureStartDatetime
		
		
		s target.verbatimEndDate = ""
		s target.drugTypeConceptId = 32833
		s target.stopReason = ""
		s target.refills = ""
		s target.quantity = source.quantity
		s target.daysSupply = ($zdh(target.drugExposureEndDate,3) - $zdh(target.drugExposureStartDate,3))
		s:+target.daysSupply<1 target.daysSupply = 1
		s target.sig = source.note
		s target.routeConceptId = ..getLookUpTblValue("drug_exposure", "route_concept_id", "", source.routeSourceValue )
		if target.routeConceptId = "" {
			s target.routeConceptId = 4129922
			; !!! LOGERROR
		}
		
		s target.lotNumber = ""
		s target.providerId = providerId
		s target.visitOccurrenceId = visitId
		s target.visitDetailId = visitDetailsId
		
		s target.drugSourceValue = $e(source.eventSourceValue,1,50)
		s target.drugSourceConceptId = 0
		s target.routeSourceValue = $e(source.routeSourceValue,1,50)
		s target.doseUnitSourceValue = $e(source.unitSourceValue,1,50)
		
	} catch e {
		s sc = e.AsStatus()
		$$$TRACE(sc)
	}
	q sc
}

}

