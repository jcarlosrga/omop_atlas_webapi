/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.getVisitOccurrence Extends OMOP.Common.DataTransform
{

/// ClassMethod getPrecidingVIsitId( 	personId,	visitId)	
ClassMethod getPrecidingVIsitId(visitStartDatetime, visitOccurrenceId)
{
	s ret = ""
	if $d(^||getVisitOccurrence(visitStartDatetime)) {
		; get previous visit at the same date
		s ret = $o(^||getVisitOccurrence(visitStartDatetime, visitOccurrenceId), -1)
		
		; if not found get visit from previous date
		if ret = "" {
			s prevVisitStartDatetime = $o(^||getVisitOccurrence(visitStartDatetime), -1)
			
			if prevVisitStartDatetime '= ""{
				s ret = $o(^||getVisitOccurrence(prevVisitStartDatetime, visitOccurrenceId), -1)
			}
		}
	} else {
		
		; if not found get visit from previous date
		if ret = "" {
			s prevVisitStartDatetime = $o(^||getVisitOccurrence(visitStartDatetime), -1)
			
			if prevVisitStartDatetime '= ""{
				s ret = $o(^||getVisitOccurrence(prevVisitStartDatetime, visitOccurrenceId), -1)
			}
		}
	}
	
	
	q ret
	
	/*
	// local table
	// no need to call external request
	set tRS=##class(%ResultSet).%New()
	Set sc=tRS.Prepare("SELECT TOP 1 visit_occurrence_id "_
						"FROM SQLUser.visit_occurrence "_
						"WHERE person_id = "_personId_" "_
						"AND visit_occurrence_id < "_visitId_" "_
						"ORDER BY visit_start_datetime DESC")
	
	q:$$$ISERR(sc) ""
	set sc=tRS.Execute()
	q:$$$ISERR(sc) ""
	
	s ret = ""
	d tRS.Next(.tSC)
	q:$$$ISERR(tSC) ""
	
	s ret = tRS.GetDataByName("visit_occurrence_id")
	d tRS.Close()
	q ret
	*/
}

ClassMethod Transform(source As OMOP.Proxy.visitOccurenceItem, target As OMOP.Request.saveVisitOccurence) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveVisitOccurence).%New()
		
		s target.type = "saveVisitOccurence"
		
		s target.visitOccurrenceId = source.id
		s target.personId = source.patient
		
		s visitConceptId = ..getLookUpTblValue("visit_occurrence","visit_concept_id", source.encounterType)
		if visitConceptId = 0 {
			; LOGERROR
		}
		s target.visitConceptId = visitConceptId
		
		; - - - -
		set visitStartDate = "1900-01-01"
		if source.fromTime = "" {
			if ($ZCVT(source.encounterType,"U") '= "INPATIENT") && (source.toTime '= ""){
				set visitStartDate = $zdh($p(source.toTime, " ", 1),3)
				set visitStartDate = $zd(visitStartDate,3)
			}
		} else {
			set visitStartDate = $zdh($p(source.fromTime, " ", 1),3)
			set visitStartDate = $zd(visitStartDate,3)
		}
		s target.visitStartDate = $e(visitStartDate,1,10)
		
		; - - - -		
		
		if source.fromTime = "" {
			if ($ZCVT(source.encounterType,"U") '= "INPATIENT") && (source.toTime '= ""){
				set visitStartDatetime = source.toTime
			} else {
				set visitStartDatetime = "1900-01-01 00:00:00"
			}
		} else {
			set visitStartDatetime = source.fromTime
		}
		s target.visitStartDatetime = visitStartDatetime
		
		; save tmp data
		set ^||getVisitOccurrence(target.visitStartDatetime, target.visitOccurrenceId) = ""
		
		; - - - - - - 
		
		if ($ZCVT(source.encounterType,"U") '= "INPATIENT") {
			if source.toTime '= "" {
				set visitEndDate = $zdh($p(source.toTime, " ", 1),3)
				set visitEndDate = $zd(visitEndDate,3)
			} else {
				set visitEndDate = target.visitStartDate	
			}
		} elseif ($ZCVT(source.encounterType,"U") = "INPATIENT") {
			if source.endTime = "" {
				set visitEndDate = target.visitStartDate
			} else {
				set visitEndDate = $zdh($p(source.toTime, " ", 1),3)
				set visitEndDate = $zd(visitEndDate,3)
			}
		}
		s target.visitEndDate = $e(visitEndDate,1,10)
		
		; - - - - - -
		
		if ($ZCVT(source.encounterType,"U") '= "INPATIENT") {
			if source.toTime '= "" {
				set visitEndDatetime = source.toTime
			} else {
				set visitEndDatetime = target.visitStartDatetime
			}
		} elseif ($ZCVT(source.encounterType,"U") = "INPATIENT") {
			if source.endTime = "" {
				set visitEndDatetime = target.visitStartDatetime
			} else {
				set visitEndDatetime = source.toTime
			}
		}
		s target.visitEndDatetime = visitEndDatetime
		
		s target.visitTypeConceptId = 32827
		s target.providerId = source.attendingClinicianCode	; !!! 
		s target.careSiteId = source.site					; !!!
		s target.visitSourceValue = source.id
		s target.visitSourceConceptId = ..getLookUpTblValue("visit_occurrence","visit_concept_id", source.encounterType)
		
		s target.admittingSourceConceptId = ..getLookUpTblValue("visit_occurrence","admitting_source_concept_id", source.admissionSourceCode)	; !!!!
		s target.admittingSourceValue = source.admissionSourceCode
		s target.dischargeToConceptId = ..getLookUpTblValue("visit_occurrence","discharge_to_concept_id", source.dischargeDispositionCode)	; !!!!
		s target.dischargeToSourceValue = source.admissionSourceCode
		s target.precedingVisitOccurrenceId = +..getPrecidingVIsitId(target.visitStartDatetime, target.visitOccurrenceId)	;..getPrecidingVIsitId(source.patient, source.id)
		s target.visitDetailParentId = ""
	} catch e {
		s sc = e.AsStatus()
		$$$TRACE(sc)
	}
	q sc
}

}

