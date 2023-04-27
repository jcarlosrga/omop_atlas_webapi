/// Base class for data saving in IRIS and PostgreSQL
/// 
Class OMOP.Operation.saveDataCommon Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method saveBulkData(request As OMOP.Proxy.saveDataToIRIS, dataType = "") [ Abstract ]
{
}

Method saveData(sql, request) As %Status [ Abstract ]
{
}

/// return SQL statement
Method getSQL(type, target, sql) As %Status
{
	s sc = $$$OK
	try{
		; s type = $ZCVT(type,"U")
		if type = "savePatientLocation" {
			s sql = "INSERT INTO location"_
					"(location_id,address_1,address_2,city,state,zip,county,location_source_value) "_
					"VALUES "
					_"(?,?,?,?,?,?,?,?)"
					
		} elseif type = "saveCareProviderInfo" {
			s sql = "INSERT INTO provider"_
					"(provider_id, provider_name, NPI, DEA, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) "_
					"VALUES "
					_"(?,?,?,?,?,?,?,?,?,?,?,?,?)"			
				
		} elseif type = "savePerson" {
			s sql = "INSERT INTO person(person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) "_
					"VALUES "_
					"(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
				
		} elseif type = "saveDeath" {
			s sql = "INSERT INTO death(person_id, death_date, death_datetime, death_type_concept_id, cause_concept_id, cause_source_value, cause_source_concept_id) "_
					"VALUES "_
					"(?,?,?,?,?,?,?)"

		} elseif type = "saveVisitOccurence" {
			s sql = "INSERT INTO visit_occurrence(visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitting_source_value, admitting_source_concept_id, discharge_to_concept_id, discharge_to_source_value, preceding_visit_occurrence_id) "_
					 "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

		} elseif type = "saveVisitDetail" {
			s sql = "INSERT INTO visit_detail(visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, discharge_to_concept_id, admitted_from_concept_id, admitted_from_source_value, visit_detail_source_value, visit_detail_source_concept_id, discharge_to_source_value, preceding_visit_detail_id, visit_detail_parent_id, visit_occurrence_id ) "_
					 "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
					 
		} elseif type = "saveEvent" {
			s sql = "INSERT INTO eventTable(encounter, eventConceptId, eventEndTime, eventSourceValue, eventStartTime, modifierConceptId, modifierSourceValue, providerName, qualifierConceptId, qualifierSourceValue, routeConceptId, routeSourceValue, sourceTable, unitConceptId, unitSourceValue, valueAsConceptId, valueSourceValue, personId, note, quantity, sourceId, valueAsNumber, rangeLow, rangeHigh) "_
					 "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

		} elseif type = "saveCondition" {
			s sql = "INSERT INTO condition_occurrence(condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) "_
					 "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
					 
		} elseif type = "saveObservation" {
			s sql = "INSERT INTO observation(observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value) "_
					 "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
				
		} elseif type = "saveCareSite" {
			s sql = "INSERT INTO care_site(care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) "_
					"VALUES "_
					"(?,?,?,?,?,?)"
					
		} elseif type = "saveMeasurement" {
			s sql = "INSERT INTO measurement(measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, value_source_value) "_
					 "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

		} elseif type = "saveProcedureOccurence" {
			s sql = "INSERT INTO procedure_occurrence(procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) "_
					 "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

		} elseif type = "saveDrugExposure" {
			s sql = "INSERT INTO drug_exposure(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) "_
					 "VALUES(?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?)"

		} elseif type = "saveSpecimen" {
			s sql = "INSERT INTO specimen(specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value)"_
					 "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

		} elseif type = "saveDeviceExposure" {
			s sql = "INSERT INTO Device_exposure(device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id)"_
					 "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

		} elseif type = "saveNote" {
			s sql = "INSERT INTO note(note_id, person_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value)"_
					 "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)"

		} elseif type = "saveFactRelationshipBO" {
			s sql = "INSERT INTO fact_relationship(domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id)"_
					 "VALUES(?,?,?,?,?)"

		} elseif type = "saveObservationPeriod" {
			s sql = "INSERT INTO observation_period(observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id)"_
					 "VALUES(?,?,?,?,?)"

		} else {
			s sql = ""	
		}
		
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

Method onBulkRequest(pRequest As OMOP.Proxy.saveDataToIRIS, Output pResponse As OMOP.Response.saveDataCommonBO) As %Status
{
	s sc = $$$OK
	try{
		$$$TRACE("Bulk insert. Records count: "_pRequest.items.Count())
		
		if pRequest.items.Count() > 0 {
			s item = pRequest.items.GetAt(1)
			
			$$$TRACE("item.type "_item.type)
			
			if item.type = "saveObservation" {
				d ..saveBulkData(pRequest, "saveObservation")
			} else {
				for itemCnt = 1:1:pRequest.items.Count(){
					s item = pRequest.items.GetAt(itemCnt)
					d ..onRequest(item, .pResponse)
				}
			}
		}
		
		
		

	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

Method onRequest(pRequest As OMOP.Request.saveDataCommonBO, Output pResponse As OMOP.Response.saveDataCommonBO) As %Status
{
	s sc = $$$OK
	try{
		set target = pRequest.target
		set type = pRequest.type
		set sc = ..getSQL(type, target, .sql)
		q:$$$ISERR(sc)
		
		set sc = ..saveData(sql, pRequest)
		q:$$$ISERR(sc)
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.saveDataCommonBO">
    <Method>onRequest</Method>
  </MapItem>
  <MapItem MessageType="OMOP.Request.savePatientLocationBO">
    <Method>onRequest</Method>
  </MapItem>
  <MapItem MessageType="OMOP.Request.saveCareProviderInfoBO">
    <Method>onRequest</Method>
  </MapItem>
  
  <MapItem MessageType="OMOP.Proxy.saveDataToIRIS">
    <Method>onBulkRequest</Method>
  </MapItem>
  
</MapItems>
}

}

