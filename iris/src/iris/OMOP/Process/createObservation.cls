/// 
/// 20211101 Denis Bulashev
/// Step 14 - Create Observation
/// 
Class OMOP.Process.createObservation Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createObservation, Output pResponse As OMOP.Response.createObservation) As %Status
{
	s sc = $$$OK
	try {
		set saveRemains = +pRequest.saveRemains
		
		#dim saveBulkRequest As OMOP.Proxy.saveDataToIRIS
		set saveBulkRequest = ##class(OMOP.Proxy.saveDataToIRIS).%New()
		
		// 2 - Get data
		// local table
		// no need to call external request
		set tRS=##class(%ResultSet).%New()
		
		if saveRemains {
			Set tSC=tRS.Prepare("SELECT * FROM eventTable "_
							"WHERE "_
							"personId = "_pRequest.patientId)
		} else {
			Set tSC=tRS.Prepare("SELECT * FROM eventTable "_
							"WHERE "_
							"personId = "_pRequest.patientId_" "_
							"AND "_
							"sourceTable<>'HSAA.Medication' "_
							"AND ("_
							"encounter IN  "_
							;"(SELECT visit_occurrence_id  FROM SQLUser.visit_occurrence WHERE person_ID = "_pRequest.patientId_") "_
							"(SELECT visit_source_value FROM SQLUser.visit_occurrence WHERE person_ID = "_pRequest.patientId_") "_
							"OR "_
							"encounter is NULL )")
		}
							
		quit:$$$ISERR(tSC)
		set tSC=tRS.Execute() 
		quit:$$$ISERR(tSC)
		While tRS.%Next() {

			if 'saveRemains {
				if tRS.GetDataByName("eventConceptId") '= ""{
					s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("observation","observation_concept_id",tRS.GetDataByName("eventConceptId"))
				} else {
					s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("observation","observation_concept_id","",tRS.GetDataByName("eventSourceValue"))
				}
				continue:processFlag=""
			}
 
			
			s observationItem = ##class(OMOP.Proxy.ObservationItem).%New()
			s observationItem.ID = tRS.GetDataByName("ID")
			s observationItem.encounter = tRS.GetDataByName("encounter")
			s observationItem.eventConceptId = tRS.GetDataByName("eventConceptId")
			s observationItem.eventEndTime = tRS.GetDataByName("eventEndTime")
			s observationItem.eventSourceValue = tRS.GetDataByName("eventSourceValue")
			s observationItem.eventStartTime = tRS.GetDataByName("eventStartTime")
			s observationItem.modifierConceptId = tRS.GetDataByName("modifierConceptId")
			s observationItem.modifierSourceValue = tRS.GetDataByName("modifierSourceValue")
			s observationItem.providerName = tRS.GetDataByName("providerName")
			s observationItem.qualifierConceptId = tRS.GetDataByName("qualifierConceptId")
			s observationItem.qualifierSourceValue = tRS.GetDataByName("qualifierSourceValue")
			s observationItem.routeConceptId = tRS.GetDataByName("routeConceptId")
			s observationItem.routeSourceValue = tRS.GetDataByName("routeSourceValue")
			s observationItem.sourceTable = tRS.GetDataByName("sourceTable")
			s observationItem.unitConceptId = tRS.GetDataByName("unitConceptId")
			s observationItem.unitSourceValue = tRS.GetDataByName("unitSourceValue")
			s observationItem.valueAsConceptId = tRS.GetDataByName("valueAsConceptId")
			s observationItem.valueSourceValue = tRS.GetDataByName("valueSourceValue")
			s observationItem.eventEnteredonDate = tRS.GetDataByName("event_enteredon_date")
			s observationItem.personId = pRequest.patientId
			s observationItem.sourceId = tRS.GetDataByName("sourceId")
			
			// transform data
			# dim saveObservationRequest As OMOP.Request.saveObservationBO
			set saveObservationRequest = ##class(OMOP.Request.saveObservationBO).%New()
			s sc = ##class(OMOP.Transform.saveObservation).Transform(observationItem, .saveObservationRequest)
			q:$$$ISERR(sc)
			
			s saveObservationRequest.personId = pRequest.patientId
			s saveObservationRequest.observationId = ..getNewId("observation")
			s saveObservationRequest.providerId = pRequest.providerId
			s saveObservationRequest.visitDetailId = pRequest.visitDetailId
			s saveObservationRequest.visitOccurrenceId = pRequest.visitOccurrenceId

			if saveRemains set saveObservationRequest.observationConceptId = "4129922"
			
			;// !!! NEW
			;s sc = saveBulkRequest.items.Insert(saveObservationRequest)
			;q:$$$ISERR(sc)
			
			
			// 1 - save data to IRIS
			set saveObservationRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveObservationRequest, .saveObservationResponse)
			q:$$$ISERR(sc)
			
			// 1 - save data to PostgreSQL
			set saveObservationRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveObservationRequest, .saveObservationResponse)
			q:$$$ISERR(sc)
			
		
			// delete processed row
			d ##class(User.eventTable).%DeleteId(tRS.GetDataByName("ID"))	

 
		}
		
 
 		;if ($g(saveObservationRequest)'="") && ($isobject(saveObservationRequest)){
		;	// 1 - save data to IRIS
		;	set saveObservationRequest.target = "IRIS"
		;	set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveBulkRequest, .saveBulkResponse)
		;	q:$$$ISERR(sc)
 		;}
 
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}

