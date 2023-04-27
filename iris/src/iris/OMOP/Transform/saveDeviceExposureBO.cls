/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.saveDeviceExposureBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Proxy.MeasurementItem, target As OMOP.Request.saveDeviceExposureBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveDeviceExposureBO).%New()
		
		s target.type = "saveDeviceExposure"
		
		//get links from visit
		s providerId = ""
		s careSiteId = ""
		s visitId = ""
		s visitDetailsId = ""
		d ..getVisitInfo(source.encounter, .providerId, .careSiteId, .visitId, .visitDetailsId)
		
		s target.deviceExposureId	= ""		; autoincrement id
		s target.personId = ""			; refference from p.9
		s target.deviceConceptId = ..getLookUpTblValue("device_exposure","device_concept_id", $s(source.eventConceptId'="":source.eventConceptId,1:source.eventSourceValue) )
		if target.deviceConceptId = "non-standard"{
			; !!! LOGERROR !!!
		}
		
		s target.deviceExposureStartDate = source.eventStartTime
		i target.deviceExposureStartDate = "" s target.deviceExposureStartDate = source.eventEndTime
		i target.deviceExposureStartDate = "" s target.deviceExposureStartDate = source.eventEnteredonDate
		if target.deviceExposureStartDate = "" set target.deviceExposureStartDate = ..getVisitStartDateTime(source.encounter) 
		if target.deviceExposureStartDate = "" {
			set target.deviceExposureStartDate = ..getPersonSourceDateTime(source.personId)
		}
		s target.deviceExposureStartDate = $e(target.deviceExposureStartDate,1,10)
		
		
		s target.deviceExposureStartDatetime = source.eventStartTime
		i target.deviceExposureStartDatetime = "" s target.deviceExposureStartDatetime = source.eventEndTime
		i target.deviceExposureStartDatetime = "" s target.deviceExposureStartDatetime = source.eventEnteredonDate
		if target.deviceExposureStartDatetime = "" set target.deviceExposureStartDatetime = ..getVisitStartDateTime(source.encounter) 
		if target.deviceExposureStartDatetime = "" {
			set target.deviceExposureStartDatetime = ..getPersonSourceDateTime(source.personId)
		}
		
		
		s target.deviceExposureEndDate = source.eventEndTime
		i target.deviceExposureEndDate = "" s target.deviceExposureEndDate = target.deviceExposureStartDatetime
		s target.deviceExposureEndDate = $e(target.deviceExposureEndDate,1,10)
		
		s target.deviceExposureEndDatetime = source.eventEndTime
		i target.deviceExposureEndDate = "" s target.deviceExposureEndDate = target.deviceExposureStartDatetime
		
		s target.uniqueDeviceId = ""
		s target.quantity = 1
		s target.providerId = providerId
		s target.visitOccurrenceId = visitId
		s target.visitDetailId = visitDetailsId
		s target.deviceSourceValue = $e(source.eventSourceValue,1,50)
		s target.deviceSourceConceptId = 0
		s target.deviceTypeConceptId = 32827
		
	} catch e {
		s sc = e.AsStatus()
		$$$TRACE(sc)
	}
	q sc
}

}

