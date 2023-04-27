/// 20211007 Denis Bulashev
/// Method to save data to IRIS database
Class OMOP.Operation.saveDataToIRIS Extends OMOP.Operation.saveDataCommon
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method saveBulkData(request As OMOP.Proxy.saveDataToIRIS, dataType = "") As %Status
{
	s sc = $$$OK
	try{
		
		set rowLimit = 50
		
		if dataType = "saveObservation" {
			s sqlOrig = "INSERT INTO observation(observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value) "
			set rowNum = 0
			
			for itemNum = 1:1:request.items.Count() {
				set item = request.items.GetAt(itemNum)
				set rowNum = rowNum + 1
				
				if rowNum = 1{
					set sql = sqlOrig_"SELECT "_
						$s(item.observationId="":"null",1:item.observationId)_","_
						$s(item.personId="":"null",1:item.personId)_","_
						$s(item.observationConceptId="":"null",1:item.observationConceptId)_","_
						$s(item.observationDate = "" : "null", 1 : $zdh( item.observationDate, 3 ) )_","_
						$s(item.observationDatetime="":"null",1:"'"_item.observationDatetime_"'")_","_
						$s(item.observationTypeConceptId="":"null",1:item.observationTypeConceptId)_","_
						$s(item.valueAsNumber="":"null",1:item.valueAsNumber)_","_
						$s(item.valueAsString="":"null",1:"'"_$tr(item.valueAsString,"'","")_"'")_","_
						$s(item.valueAsConceptId="":"null",1:item.valueAsConceptId)_","_
						$s(item.qualifierConceptId="":"null",1:item.qualifierConceptId)_","_
						$s(item.unitConceptId="":"null",1:item.unitConceptId)_","_
						$s(item.providerId="":"null",1:item.providerId)_","_
						$s(item.visitOccurrenceId="":"null",1:item.visitOccurrenceId)_","_
						$s(item.visitDetailId="":"null",1:item.visitDetailId)_","_
						$s(item.observationSourceValue="":"null",1:"'"_$tr(item.observationSourceValue,"'","")_"'")_","_
						$s(item.observationSourceConceptId="":"null",1:item.observationSourceConceptId)_","_
						$s(item.unitSourceValue="":"null",1:"'"_$tr(item.unitSourceValue,"'","")_"'")_","_
						$s(item.qualifierSourceValue="":"null",1:"'"_$tr(item.qualifierSourceValue,"'","")_"'")
				} else {
					set sql = sql_" UNION ALL SELECT "_
						$s(item.observationId="":"null",1:item.observationId)_","_
						$s(item.personId="":"null",1:item.personId)_","_
						$s(item.observationConceptId="":"null",1:item.observationConceptId)_","_
						$s(item.observationDate = "" : "null", 1 : $zdh( item.observationDate, 3 ) )_","_
						$s(item.observationDatetime="":"null",1:"'"_item.observationDatetime_"'")_","_
						$s(item.observationTypeConceptId="":"null",1:item.observationTypeConceptId)_","_
						$s(item.valueAsNumber="":"null",1:item.valueAsNumber)_","_
						$s(item.valueAsString="":"null",1:"'"_$tr(item.valueAsString,"'","")_"'")_","_
						$s(item.valueAsConceptId="":"null",1:item.valueAsConceptId)_","_
						$s(item.qualifierConceptId="":"null",1:item.qualifierConceptId)_","_
						$s(item.unitConceptId="":"null",1:item.unitConceptId)_","_
						$s(item.providerId="":"null",1:item.providerId)_","_
						$s(item.visitOccurrenceId="":"null",1:item.visitOccurrenceId)_","_
						$s(item.visitDetailId="":"null",1:item.visitDetailId)_","_
						$s(item.observationSourceValue="":"null",1:"'"_$tr(item.observationSourceValue,"'","")_"'")_","_
						$s(item.observationSourceConceptId="":"null",1:item.observationSourceConceptId)_","_
						$s(item.unitSourceValue="":"null",1:"'"_$tr(item.unitSourceValue,"'","")_"'")_","_
						$s(item.qualifierSourceValue="":"null",1:"'"_$tr(item.qualifierSourceValue,"'","")_"'")					
				}
				
				if (rowNum = rowLimit) || (itemNum = request.items.Count()) {
					set rowNum = 0	
					$$$TRACE(sql)
					s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql)
				}
			}
		}
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

/// save data to IRIS database
Method saveData(sql, request) As %Status
{
	s sc = $$$OK
	
	try{
		; TO DO - create setting on BO
		s localSave = 1	; Save in the SAME instance of IRIS
		
		if request.%IsA(##class(OMOP.Request.savePatientLocationBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.locationId, request.address1, request.address2, request.city, request.state, request.zip, request.county, request.locationSourceValue)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.locationId, request.address1, request.address2, request.city, request.state, request.zip, request.county, request.locationSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}
			
		} elseif request.%IsA(##class(OMOP.Request.saveCareProviderInfoBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.providerId,request.providerName,request.npi,request.dea,request.specialtyConceptId,request.careSiteId,request.yearOfBirth,request.genderConceptId,request.providerSourceValue,request.specialtySourceValue,request.specialtySourceConceptId,request.genderSourceValue,request.genderSourceConceptId)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.providerId,request.providerName,request.npi,request.dea,request.specialtyConceptId,request.careSiteId,request.yearOfBirth,request.genderConceptId,request.providerSourceValue,request.specialtySourceValue,request.specialtySourceConceptId,request.genderSourceValue,request.genderSourceConceptId)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}
			
		} elseif request.%IsA(##class(OMOP.Request.savePersonBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.personId, request.genderConceptId, request.yearOfBirth, request.monthOfBirth, request.dayOfBirth, request.birthDatetime, request.raceConceptId, request.ethnicityConceptId, request.locationId, request.providerId, request.careSiteId, request.personSourceValue, request.genderSourceValue, request.genderSourceConceptId, request.raceSourceValue, request.raceSourceConceptId, request.ethnicitySourceValue, request.ethnicitySourceConceptId)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.personId, request.genderConceptId, request.yearOfBirth, request.monthOfBirth, request.dayOfBirth, request.birthDatetime, request.raceConceptId, request.ethnicityConceptId, request.locationId, request.providerId, request.careSiteId, request.personSourceValue, request.genderSourceValue, request.genderSourceConceptId, request.raceSourceValue, request.raceSourceConceptId, request.ethnicitySourceValue, request.ethnicitySourceConceptId)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}

		} elseif request.%IsA(##class(OMOP.Request.saveDeathBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.personId, request.deathDate, request.deathDatetime, request.deathTypeConceptId, request.causeConceptId, request.causeSourceValue, request.causeSourceConceptId)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.personId, request.deathDate, request.deathDatetime, request.deathTypeConceptId, request.causeConceptId, request.causeSourceValue, request.causeSourceConceptId)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}

		} elseif request.%IsA(##class(OMOP.Request.saveVisitOccurence).%ClassName(1)){
			if $g(localSave) = "" {
				if request.type = "saveVisitDetail" {
					s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.visitDetailId, request.personId, request.visitConceptId, request.visitStartDate, request.visitStartDatetime, request.visitEndDate, request.visitEndDatetime, request.visitTypeConceptId, request.providerId, request.careSiteId, request.visitSourceValue, request.visitSourceConceptId, request.admittingSourceValue, request.admittingSourceConceptId, request.dischargeToConceptId, request.dischargeToSourceValue, request.precedingVisitOccurrenceId, request.visitDetailParentId, request.visitOccurrenceId)
				} else {
					s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.visitOccurrenceId, request.personId, request.visitConceptId, request.visitStartDate, request.visitStartDatetime, request.visitEndDate, request.visitEndDatetime, request.visitTypeConceptId, request.providerId, request.careSiteId, request.visitSourceValue, request.visitSourceConceptId, request.admittingSourceValue, request.admittingSourceConceptId, request.dischargeToConceptId, request.dischargeToSourceValue, request.precedingVisitOccurrenceId)
				}
			
			} else {
				$$$TRACE(sql)
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				if request.type = "saveVisitDetail" {
					set sc=rs.Execute(request.visitDetailId, request.personId, request.visitConceptId, request.visitStartDate, request.visitStartDatetime, request.visitEndDate, request.visitEndDatetime, request.visitTypeConceptId, request.providerId, request.careSiteId, request.visitSourceValue, request.visitSourceConceptId, request.admittingSourceValue, request.admittingSourceConceptId, request.dischargeToConceptId, request.dischargeToSourceValue, request.precedingVisitOccurrenceId, request.visitDetailParentId, request.visitOccurrenceId)

				} else {
					
					set sc=rs.Execute(request.visitOccurrenceId, request.personId, request.visitConceptId, request.visitStartDate, request.visitStartDatetime, request.visitEndDate, request.visitEndDatetime, request.visitTypeConceptId, request.providerId, request.careSiteId, request.visitSourceValue, request.visitSourceConceptId, request.admittingSourceValue, request.admittingSourceConceptId, request.dischargeToConceptId, request.dischargeToSourceValue, request.precedingVisitOccurrenceId)

				}
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}
			
		} elseif request.%IsA(##class(OMOP.Request.saveEventBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.encounter, request.eventConceptId, request.eventEndTime, request.eventSourceValue, request.eventStartTime, request.modifierConceptId, request.modifierSourceValue, request.providerName, request.qualifierConceptId, request.qualifierSourceValue, request.routeConceptId, request.routeSourceValue, request.sourceTable, request.unitConceptId, request.unitSourceValue, request.valueAsConceptId, request.valueSourceValue, request.personId, request.note, request.quantity, request.sourceId, request.valueAsNumber, request.rangeLow, request.rangeHigh)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.encounter, request.eventConceptId, request.eventEndTime, request.eventSourceValue, request.eventStartTime, request.modifierConceptId, request.modifierSourceValue, request.providerName, request.qualifierConceptId, request.qualifierSourceValue, request.routeConceptId, request.routeSourceValue, request.sourceTable, request.unitConceptId, request.unitSourceValue, request.valueAsConceptId, request.valueSourceValue, request.personId, request.note, request.quantity, request.sourceId, request.valueAsNumber, request.rangeLow, request.rangeHigh)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}
			
		} elseif request.%IsA(##class(OMOP.Request.saveConditionBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.conditionOccurrenceId, request.personId, request.conditionConceptId, request.conditionStartDate, request.conditionStartDatetime, request.conditionEndDate, request.conditionEndDatetime, request.conditionTypeConceptId, request.conditionStatusConceptId, request.stopReason, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.conditionSourceValue, request.conditionSourceConceptId, request.conditionStatusSourceValue)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.conditionOccurrenceId, request.personId, request.conditionConceptId, request.conditionStartDate, request.conditionStartDatetime, request.conditionEndDate, request.conditionEndDatetime, request.conditionTypeConceptId, request.conditionStatusConceptId, request.stopReason, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.conditionSourceValue, request.conditionSourceConceptId, request.conditionStatusSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}

		} elseif request.%IsA(##class(OMOP.Request.saveObservationBO).%ClassName(1)){
			if $g(localSave) = "" {
				;s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.observationId, request.personId, request.observationConceptId, request.observationDate, request.observationDatetime, request.observationTypeConceptId, request.valueAsNumber, request.valueAsString, request.valueAsConceptId, request.qualifierConceptId, request.unitConceptId, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.observationSourceValue, request.observationSourceConceptId, request.unitSourceValue, request.qualifierSourceValue)

				s sql = "INSERT INTO observation(observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value) "_
					"VALUES("_
					$s(request.observationId="":"null",1:request.observationId)_","_
					$s(request.personId="":"null",1:request.personId)_","_
					$s(request.observationConceptId="":"null",1:request.observationConceptId)_","_
					$s( request.observationDate = "" : "null", 1 : $zdh( request.observationDate, 3 ) )_","_
					$s(request.observationDatetime="":"null",1:"'"_request.observationDatetime_"'")_","_
					$s(request.observationTypeConceptId="":"null",1:request.observationTypeConceptId)_","_
					$s(request.valueAsNumber="":"null",1:request.valueAsNumber)_","_
					$s(request.valueAsString="":"null",1:"'"_$tr(request.valueAsString,"'","")_"'")_","_
					$s(request.valueAsConceptId="":"null",1:request.valueAsConceptId)_","_
					$s(request.qualifierConceptId="":"null",1:request.qualifierConceptId)_","_
					$s(request.unitConceptId="":"null",1:request.unitConceptId)_","_
					$s(request.providerId="":"null",1:request.providerId)_","_
					$s(request.visitOccurrenceId="":"null",1:request.visitOccurrenceId)_","_
					$s(request.visitDetailId="":"null",1:request.visitDetailId)_","_
					$s(request.observationSourceValue="":"null",1:"'"_$tr(request.observationSourceValue,"'","")_"'")_","_
					$s(request.observationSourceConceptId="":"null",1:request.observationSourceConceptId)_","_
					$s(request.unitSourceValue="":"null",1:"'"_$tr(request.unitSourceValue,"'","")_"'")_","_
					$s(request.qualifierSourceValue="":"null",1:"'"_$tr(request.qualifierSourceValue,"'","")_"'")_")"
					
					s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.observationId, request.personId, request.observationConceptId, request.observationDate, request.observationDatetime, request.observationTypeConceptId, request.valueAsNumber, request.valueAsString, request.valueAsConceptId, request.qualifierConceptId, request.unitConceptId, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.observationSourceValue, request.observationSourceConceptId, request.unitSourceValue, request.qualifierSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}

		} elseif request.%IsA(##class(OMOP.Request.saveCareSiteInfoBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.careSiteId, request.careSiteName, request.placeOfServiceConceptId, request.locationId, request.careSiteSourceValue, request.placeOfServiceConceptId)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.careSiteId, request.careSiteName, request.placeOfServiceConceptId, request.locationId, request.careSiteSourceValue, request.placeOfServiceConceptId)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}
		
		}elseif request.%IsA(##class(OMOP.Request.saveCareLocationInfoBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.locationId, request.address1, request.address2, request.city, request.state, request.zip, request.county, request.locationSourceValue)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.locationId, request.address1, request.address2, request.city, request.state, request.zip, request.county, request.locationSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}			
			
		} elseif request.%IsA(##class(OMOP.Request.saveMeasurementBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.measurementId, request.personId, request.measurementConceptId, request.measurementDate, request.measurementDatetime, request.measurementTime, request.measurementTypeConceptId, request.operatorConceptId, request.valueAsNumber, request.valueAsConceptId, request.unitConceptId, request.rangeLow, request.rangeHigh, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.measurementSourceValue, request.measurementSourceConceptId, request.unitSourceValue, request.valueSourceValue)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.measurementId, request.personId, request.measurementConceptId, request.measurementDate, request.measurementDatetime, request.measurementTime, request.measurementTypeConceptId, request.operatorConceptId, request.valueAsNumber, request.valueAsConceptId, request.unitConceptId, request.rangeLow, request.rangeHigh, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.measurementSourceValue, request.measurementSourceConceptId, request.unitSourceValue, request.valueSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}			

		} elseif request.%IsA(##class(OMOP.Request.saveProcedureOccurenceBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.procedureOccurrenceId, request.personId, request.procedureConceptId, request.procedureDate, request.procedureDatetime, request.procedureTypeConceptId, request.modifierConceptId, request.quantity, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.procedureSourceValue, request.procedureSourceConceptId, request.modifierSourceValue)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.procedureOccurrenceId, request.personId, request.procedureConceptId, request.procedureDate, request.procedureDatetime, request.procedureTypeConceptId, request.modifierConceptId, request.quantity, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.procedureSourceValue, request.procedureSourceConceptId, request.modifierSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}			

		} elseif request.%IsA(##class(OMOP.Request.saveDrugExposureBO).%ClassName(1)){
			s localSave = ""
			if $g(localSave) = "" {
				s sql = "INSERT INTO drug_exposure(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason , refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) "_
						"VALUES("_request.drugExposureId_","_request.personId_","_request.drugConceptId_","_
						
						$s( request.drugExposureStartDate = "" : "null", 1 : $zdh( request.drugExposureStartDate, 3 ) )_","_
						$s( request.drugExposureStartDatetime = "" : "null", 1 : "'"_request.drugExposureStartDatetime_"'")_","_
						$s(request.drugExposureEndDate="":"null",1:$zdh(request.drugExposureEndDate,3))_","_
						$s(request.drugExposureEndDatetime="":"null",1:"'"_request.drugExposureEndDatetime_"'")_","_
						$s(request.verbatimEndDate="":"null",1:request.verbatimEndDate)_","_
						$s(request.drugTypeConceptId="":"null",1:request.drugTypeConceptId)_","_
						$s(request.stopReason="":"null",1:"'"_request.stopReason_"'")_","_
						
						$s(request.refills="":"null",1:"'"_$tr(request.refills,"'","")_"'")_","_
						$s(request.quantity="":"null",1:"'"_$tr(request.quantity,"'","")_"'")_","_
						$s(request.daysSupply="":"null",1:"'"_$tr(request.daysSupply,"'","")_"'")_","_
						$s(request.sig="":"null",1:"'"_$tr(request.sig,"'","")_"'")_","_
						$s(request.routeConceptId="":"null",1:request.routeConceptId)_","_
						$s(request.lotNumber="":"null",1:"'"_$tr(request.lotNumber,"'","")_"'")_","_
						$s(request.providerId="":"null",1:request.providerId)_","_
						$s(request.visitOccurrenceId="":"null",1:request.visitOccurrenceId)_","_
						$s(request.visitDetailId="":"null",1:"'"_request.visitDetailId_"'")_","_
						$s(request.drugSourceValue="":"null",1:"'"_$tr(request.drugSourceValue,"'","")_"'")_","_
						$s(request.drugSourceConceptId="":"null",1:request.drugSourceConceptId)_","_
						$s(request.routeSourceValue="":"null",1:"'"_$tr(request.routeSourceValue,"'","")_"'")_","_
						$s( request.doseUnitSourceValue="":"null",1:"'"_$tr(request.doseUnitSourceValue,"'","")_"'")_")"
						
						;$$$TRACE(sql)
						
				;s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql)
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.drugExposureId, request.personId, request.drugConceptId, request.drugExposureStartDate, request.drugExposureStartDatetime, request.drugExposureEndDate, request.drugExposureEndDatetime, request.verbatimEndDate, request.drugTypeConceptId, request.stopReason, request.refills, request.quantity, request.daysSupply, request.sig, request.routeConceptId, request.lotNumber, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.drugSourceValue, request.drugSourceConceptId, request.routeSourceValue, request.doseUnitSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.drugExposureId, request.personId, request.drugConceptId, request.drugExposureStartDate, request.drugExposureStartDatetime, request.drugExposureEndDate, request.drugExposureEndDatetime, request.verbatimEndDate, request.drugTypeConceptId, request.stopReason, request.refills, request.quantity, request.daysSupply, request.sig, request.routeConceptId, request.lotNumber, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.drugSourceValue, request.drugSourceConceptId, request.routeSourceValue, request.doseUnitSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}			

		} elseif request.%IsA(##class(OMOP.Request.saveDeviceExposureBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.deviceExposureId, request.personId, request.deviceConceptId, request.deviceExposureStartDate, request.deviceExposureStartDatetime, request.deviceExposureEndDate, request.deviceExposureEndDatetime, request.deviceTypeConceptId, request.uniqueDeviceId, request.quantity, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.deviceSourceValue, request.deviceSourceConceptId)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.deviceExposureId, request.personId, request.deviceConceptId, request.deviceExposureStartDate, request.deviceExposureStartDatetime, request.deviceExposureEndDate, request.deviceExposureEndDatetime, request.deviceTypeConceptId, request.uniqueDeviceId, request.quantity, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.deviceSourceValue, request.deviceSourceConceptId)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}			

		} elseif request.%IsA(##class(OMOP.Request.saveSpecimenBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.specimenId, request.personId, request.specimenConceptId, request.specimenTypeConceptId, request.specimenDate, request.specimenDatetime, request.quantity, request.unitConceptId, request.anatomicSiteConceptId, request.diseaseStatusConceptId, request.specimenSourceId, request.specimenSourceValue, request.unitSourceValue, request.anatomicSiteSourceValue, request.diseaseStatusSourceValue)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.specimenId, request.personId, request.specimenConceptId, request.specimenTypeConceptId, request.specimenDate, request.specimenDatetime, request.quantity, request.unitConceptId, request.anatomicSiteConceptId, request.diseaseStatusConceptId, request.specimenSourceId, request.specimenSourceValue, request.unitSourceValue, request.anatomicSiteSourceValue, request.diseaseStatusSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}			

		} elseif request.%IsA(##class(OMOP.Request.saveNoteBO).%ClassName(1)){
			s localSave = ""
			if $g(localSave) = "" {
				s sql = "INSERT INTO note(note_id, person_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value)"_
						 "VALUES("_
						 $s( request.noteId = "" : "null", 1 : request.noteId )_","_
						 $s( request.personId = "" : "null", 1 : request.personId )_","_
						 $s( request.noteDate = "" : "null", 1 : $zdh( request.noteDate, 3 ) )_","_
						 $s( request.noteDatetime = "" : "null", 1 : "'"_request.noteDatetime_"'")_","_
						 $s( request.noteTypeConceptId = "" : "null", 1 : request.noteTypeConceptId )_","_
						 $s( request.noteClassConceptId = "" : "null", 1 : request.noteClassConceptId )_","_
						 $s( request.noteTitle="":"null",1:"'"_$tr(request.noteTitle,"'","")_"'")_","_
						 $s( request.noteText="":"null",1:"'"_$tr(request.noteText,"'","")_"'")_","_
						 $s( request.encodingConceptId = "" : "null", 1 : request.encodingConceptId )_","_
						 $s( request.languageConceptId = "" : "null", 1 : request.languageConceptId )_","_
						 $s( request.providerId = "" : "null", 1 : request.providerId )_","_
						 $s( request.visitOccurrenceId = "" : "null", 1 : request.visitOccurrenceId )_","_
						 $s( request.visitDetailId = "" : "null", 1 : request.visitDetailId )_","_
						 $s( request.noteSourceValue="":"null",1:"'"_$tr(request.noteSourceValue,"'","")_"'")_")"
				
				
				;s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql)
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.noteId, request.personId, request.noteDate, request.noteDatetime, request.noteTypeConceptId, request.noteClassConceptId, request.noteTitle, request.noteText, request.encodingConceptId, request.languageConceptId, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.noteSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.noteId, request.personId, request.noteDate, request.noteDatetime, request.noteTypeConceptId, request.noteClassConceptId, request.noteTitle, request.noteText, request.encodingConceptId, request.languageConceptId, request.providerId, request.visitOccurrenceId, request.visitDetailId, request.noteSourceValue)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}	

		} elseif request.%IsA(##class(OMOP.Request.saveFactRelationshipBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.domainConceptId1, request.factId1, request.domainConceptId2, request.factId2, request.relationshipConceptId)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.domainConceptId1, request.factId1, request.domainConceptId2, request.factId2, request.relationshipConceptId)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}

		} elseif request.%IsA(##class(OMOP.Request.saveObservationPeriodBO).%ClassName(1)){
			if $g(localSave) = "" {
				s sc = ..Adapter.ExecuteUpdate(.rowsAffected, sql, request.observationPeriodId, request.personId, request.startDate, request.endDate, request.periodTypeConceptId)
			
			} else {
				set rs=##class(%ResultSet).%New()
				set rs.RuntimeMode=1
				Set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				set sc=rs.Execute(request.observationPeriodId, request.personId, request.startDate, request.endDate, request.periodTypeConceptId)
				quit:$$$ISERR(sc)
				
				d rs.Close()
			}

		} else {
			$$$TRACE("Unknown request: "_request.%ClassName(1))
		}
		
	
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

}

