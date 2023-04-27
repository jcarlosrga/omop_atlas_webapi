/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.saveMeasurement Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Proxy.MeasurementItem, target As OMOP.Request.saveMeasurementBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveMeasurementBO).%New()
		
		s target.type = "saveMeasurement"
		
		//get links from visit
		s providerId = ""
		s careSiteId = ""
		s visitId = ""
		s visitDetailsId = ""
		d ..getVisitInfo(source.encounter, .providerId, .careSiteId, .visitId, .visitDetailsId)
		
		s target.measurementId = ""		; autoincrement id
		s target.personId = ""			; refference from p.9
		s target.measurementConceptId = ..getLookUpTblValue("measurement","measurement_concept_id", $s(source.eventConceptId'="":source.eventConceptId,1:source.eventSourceValue) )
		
		s target.measurementDate = source.eventStartTime
		if target.measurementDate = "" set target.measurementDate = ..getVisitStartDateTime(source.encounter) 
		if target.measurementDate = "" {
			set target.measurementDate = ..getPersonSourceDateTime(source.personId)
		}
		s target.measurementDate = $e(target.measurementDate,1,10)
		;s:target.measurementDate?4N1"-"2N1"-"2N target.measurementDate = $zdh($p(target.measurementDate, " ", 1),3)		;$TR("dD.mM.year","year-mM-dD",target.measurementDate) 
		
		s target.measurementDatetime = source.eventStartTime
		if target.measurementDatetime = "" set target.measurementDatetime = ..getVisitStartDateTime(source.encounter) 
		if target.measurementDatetime = "" {
			set target.measurementDatetime = ..getPersonSourceDateTime(source.personId)
		}
		
		s target.measurementTime = $e(target.measurementDatetime,12,19)
		
		s target.measurementTypeConceptId = 32827
		s target.operatorConceptId = $s(source.sourceTable = "Observation":412703,1:0)
		s target.valueAsNumber = $s(source.valueSourceValue'="":+source.valueSourceValue,1:source.valueSourceValue)
		s target.valueAsConceptId = 0
		s target.qualifierConceptId = ..getLookUpTblValue()
		s target.unitConceptId = ..getLookUpTblValue()
		s target.rangeLow = ""
		s target.rangeHigh = ""
		s target.providerId = providerId
		s target.visitOccurrenceId = visitId
		s target.visitDetailId = visitDetailsId
		
		if $zcvt(source.sourceTable,"L") = "allergy"{
			s target.measurementSourceValue = source.sourceId_"|a|"_source.eventSourceValue
		
		} elseif $zcvt(source.sourceTable,"L") = "allergyreaction"{
			s target.measurementSourceValue = source.sourceId_"|r|"_source.eventSourceValue

		} else {
			s target.measurementSourceValue = source.eventSourceValue
			
		}
		s target.measurementSourceValue = $e(target.measurementSourceValue	,1,50)
		
		s target.measurementSourceConceptId = 0
		s target.unitSourceValue = $e(source.unitSourceValue,1,50)
			;s target.qualifierSourceValue = $e(source.qualifierSourceValue,1,50)
		s target.valueSourceValue = $e(source.valueSourceValue,1,50)
		
	} catch e {
		s sc = e.AsStatus()
		$$$TRACE(sc)
	}
	q sc
}

}

