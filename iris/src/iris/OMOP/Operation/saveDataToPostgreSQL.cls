/// 20211007 Denis Bulashev
/// Method to save data to PostgreSQL
Class OMOP.Operation.saveDataToPostgreSQL Extends OMOP.Operation.saveDataCommon
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

/// save data to IRIS database
Method saveData(sql, request) As %Status
{
	;q $$$OK
	
	s sc = $$$OK
	try{
		#dim rs As EnsLib.SQL.GatewayResultSet
		
		if request.%IsA(##class(OMOP.Request.savePatientLocationBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.locationId, request.address1, request.address2, request.city, request.state, request.zip, request.county, request.locationSourceValue)
		
		} elseif request.%IsA(##class(OMOP.Request.saveCareProviderInfoBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.providerId,request.providerName,request.npi,request.dea,request.specialtyConceptId,request.careSiteId,request.yearOfBirth,request.genderConceptId,request.providerSourceValue,request.specialtySourceValue,request.specialtySourceConceptId,request.genderSourceValue,request.genderSourceConceptId)
			
		} elseif request.%IsA(##class(OMOP.Request.savePersonBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.personId, request.genderConceptId, request.yearOfBirth, request.monthOfBirth, request.dayOfBirth, request.birthDatetime, request.raceConceptId, request.ethnicityConceptId, request.locationId, request.providerId, request.careSiteId, request.personSourceValue, request.genderSourceValue, request.genderSourceConceptId, request.raceSourceValue, request.raceSourceConceptId, request.ethnicitySourceValue, request.ethnicitySourceConceptId)
			
		} elseif request.%IsA(##class(OMOP.Request.saveDeathBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.personId, request.deathDate, request.deathDatetime, request.deathTypeConceptId, request.causeConceptId, request.causeSourceValue, request.causeSourceConceptId)

		} elseif request.%IsA(##class(OMOP.Request.saveVisitOccurence).%ClassName(1)){
			if request.type = "saveVisitDetail" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.visitDetailId, request.personId, request.visitConceptId, request.visitStartDate, request.visitStartDatetime, request.visitEndDate, request.visitEndDatetime, request.visitTypeConceptId, request.providerId, request.careSiteId, request.visitSourceValue, request.visitSourceConceptId, request.admittingSourceValue, request.admittingSourceConceptId, request.dischargeToConceptId, request.dischargeToSourceValue, request.precedingVisitOccurrenceId, request.visitDetailParentId, request.visitOccurrenceId)
			
			} else {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.visitOccurrenceId, request.personId, request.visitConceptId, request.visitStartDate, request.visitStartDatetime, request.visitEndDate, request.visitEndDatetime, request.visitTypeConceptId, request.providerId, request.careSiteId, request.visitSourceValue, request.visitSourceConceptId, request.admittingSourceValue, request.admittingSourceConceptId, request.dischargeToConceptId, request.dischargeToSourceValue, request.precedingVisitOccurrenceId)	
				;set sc=rs.Execute(request.visitOccurrenceId, request.personId, request.visitConceptId, request.visitStartDate, request.visitStartDatetime, request.visitEndDate, request.visitEndDatetime, request.visitTypeConceptId, request.providerId, request.careSiteId, request.visitSourceValue, request.visitSourceConceptId, request.admittingSourceValue, request.admittingSourceConceptId, request.dischargeToConceptId, request.dischargeToSourceValue, request.precedingVisitOccurrenceId)
			}
			; s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.visitOccurrenceId, request.personId, request.visitConceptId, request.visitStartDate, request.visitStartDatetime, request.visitEndDate, request.visitEndDatetime, request.visitTypeConceptId, request.providerId, request.careSiteId, request.visitSourceValue, request.visitSourceConceptId, request.admittingSourceValue, request.admittingSourceConceptId, request.dischargeToConceptId, request.dischargeToSourceValue, request.precedingVisitOccurrenceId)
			
		} elseif request.%IsA(##class(OMOP.Request.saveEventBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.encounter, request.eventConceptId, request.eventEndTime, request.eventSourceValue, request.eventStartTime, request.modifierConceptId, request.modifierSourceValue, request.providerName, request.qualifierConceptId, request.qualifierSourceValue, request.routeConceptId, request.routeSourceValue, request.sourceTable, request.unitConceptId, request.unitSourceValue, request.valueAsConceptId, request.valueSourceValue, request.personId, request.note, request.quantity)
					
		} elseif request.%IsA(##class(OMOP.Request.saveConditionBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.conditionOccurrenceId, request.personId, request.conditionConceptId, request.conditionStartDate, request.conditionStartDatetime, request.conditionEndDate, request.conditionEndDatetime, request.conditionTypeConceptId, request.conditionStatusConceptId, request.stopReason, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.conditionSourceValue, request.conditionSourceConceptId, request.conditionStatusSourceValue)
			
		} elseif request.%IsA(##class(OMOP.Request.saveConditionBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.observationId, request.personId, request.observationConceptId, request.observationDate, request.observationDatetime, request.observationTypeConceptId, request.valueAsNumber, request.valueAsString, request.valueAsConceptId, request.qualifierConceptId, request.unitConceptId, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.observationSourceValue, request.observationSourceConceptId, request.unitSourceValue, request.qualifierSourceValue)
			
		} elseif request.%IsA(##class(OMOP.Request.saveCareSiteInfoBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.careSiteId, request.careSiteName, request.placeOfServiceConceptId, request.locationId, request.careSiteSourceValue, request.placeOfServiceConceptId)
			
		}elseif request.%IsA(##class(OMOP.Request.saveCareLocationInfoBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.locationId, request.address1, request.address2, request.city, request.state, request.zip, request.county, request.locationSourceValue)	
			
		} elseif request.%IsA(##class(OMOP.Request.saveMeasurementBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql,request.measurementId, request.personId, request.measurementConceptId, request.measurementDate, request.measurementDatetime, request.measurementTime, request.measurementTypeConceptId, request.operatorConceptId, request.valueAsNumber, request.valueAsConceptId, request.unitConceptId, request.rangeLow, request.rangeHigh, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.measurementSourceValue, request.measurementSourceConceptId, request.unitSourceValue, request.valueSourceValue)
			
		} elseif request.%IsA(##class(OMOP.Request.saveProcedureOccurenceBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.procedureOccurrenceId, request.personId, request.procedureConceptId, request.procedureDate, request.procedureDatetime, request.procedureTypeConceptId, request.modifierConceptId, request.quantity, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.procedureSourceValue, request.procedureSourceConceptId, request.modifierSourceValue)
			
		} elseif request.%IsA(##class(OMOP.Request.saveDrugExposureBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.drugExposureId, request.personId, request.drugConceptId, request.drugExposureStartDate, request.drugExposureStartDatetime, request.drugExposureEndDate, request.drugExposureEndDatetime, request.verbatimEndDate, request.drugTypeConceptId, request.stopReason, request.refills, request.quantity, request.daysSupply, request.sig, request.routeConceptId, request.lotNumber, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.drugSourceValue, request.drugSourceConceptId, request.routeSourceValue, request.doseUnitSourceValue)
			
		} elseif request.%IsA(##class(OMOP.Request.saveDeviceExposureBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.deviceExposureId, request.personId, request.deviceConceptId, request.deviceExposureStartDate, request.deviceExposureStartDatetime, request.deviceExposureEndDate, request.deviceExposureEndDatetime, request.deviceTypeConceptId, request.uniqueDeviceId, request.quantity, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.deviceSourceValue, request.deviceSourceConceptId)
			
		} elseif request.%IsA(##class(OMOP.Request.saveSpecimenBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.specimenId, request.personId, request.specimenConceptId, request.specimenTypeConceptId, request.specimenDate, request.specimenDatetime, request.quantity, request.unitConceptId, request.anatomicSiteConceptId, request.diseaseStatusConceptId, request.specimenSourceId, request.specimenSourceValue, request.unitSourceValue, request.anatomicSiteSourceValue, request.diseaseStatusSourceValue)
			
		} elseif request.%IsA(##class(OMOP.Request.saveNoteBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.noteId, request.personId, request.noteDate, request.noteDatetime, request.noteTypeConceptId, request.noteClassConceptId, request.noteTitle, request.noteText, request.encodingConceptId, request.languageConceptId, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.noteSourceValue)
			
		} elseif request.%IsA(##class(OMOP.Request.saveFactRelationshipBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.domainConceptId1, request.factId1, request.domainConceptId2, request.factId2, request.relationshipConceptId)

		} elseif request.%IsA(##class(OMOP.Request.saveObservationPeriodBO).%ClassName(1)){
			s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.observationPeriodId, request.personId, request.startDate, request.endDate, request.periodTypeConceptId)

		} else {
			$$$TRACE("Unknown request: "_request.%ClassName(1))
		}

	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

}

