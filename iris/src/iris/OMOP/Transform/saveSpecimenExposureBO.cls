/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.saveSpecimenExposureBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Proxy.MeasurementItem, target As OMOP.Request.saveSpecimenBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveSpecimenBO).%New()
		
		s target.type = "saveSpecimen"
		
		//get links from visit
		s providerId = ""
		s careSiteId = ""
		s visitId = ""
		s visitDetailsId = ""
		d ..getVisitInfo(source.encounter, .providerId, .careSiteId, .visitId, .visitDetailsId)
		
		s target.specimenId	= ""		; autoincrement id
		s target.personId = ""			; refference from p.9
		s target.specimenConceptId = ..getLookUpTblValue("specimen","specimen_concept_id", $s(source.eventConceptId'="":source.eventConceptId,1:source.eventSourceValue) )
		if target.specimenConceptId = "non-standard"{
			; !!! LOGERROR !!!
		}
		s target.specimenTypeConceptId = ""

		i target.specimenDate = source.eventEnteredonDate
		if target.specimenDate = "" set target.specimenDate = ..getVisitStartDateTime(source.encounter) 
		if target.specimenDate = "" {
			set target.specimenDate = ..getPersonSourceDateTime(source.personId)
		}
		s target.specimenDate = $e(target.specimenDate,1,10)
		
		
		i target.specimenDatetime = source.eventEnteredonDate
		if target.specimenDatetime = "" set target.specimenDatetime = ..getVisitStartDateTime(source.encounter) 
		if target.specimenDatetime = "" {
			set target.specimenDatetime = ..getPersonSourceDateTime(source.personId)
		}
		

		s target.specimenDatetime = source.eventStartTime
		s target.quantity = 1
		s target.unitConceptId = 0
		s target.anatomicSiteConceptId = ..getLookUpTblValue("specimen","anatomic_site_concept_id", $s(source.eventConceptId'="":source.valueSourceValue,1:source.valueAsConceptId) )
		i target.anatomicSiteConceptId = "" s target.anatomicSiteConceptId = 4129922
		s target.diseaseStatusConceptId = 0
		s target.specimenSourceId = ""
		s target.specimenSourceValue = $e(source.eventSourceValue,1,50)
		s target.unitSourceValue = ""
		s target.anatomicSiteSourceValue = $s(" Problem Procedure "[source.valueSourceValue:$e(source.valueSourceValue,1,50),1:"")
		s target.diseaseStatusSourceValue = ""
		
	} catch e {
		s sc = e.AsStatus()
		$$$TRACE(sc)
	}
	q sc
}

}

