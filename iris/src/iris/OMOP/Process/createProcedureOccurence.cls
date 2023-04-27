/// 
/// 20211111Denis Bulashev
/// Step 16 - Create Procedure Occurence
/// 
Class OMOP.Process.createProcedureOccurence Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createProcedureOccurence, Output pResponse As OMOP.Response.createProcedureOccurence) As %Status
{
	s sc = $$$OK
	try {
		// 2 - Get data
		#dim getObservationDataRequest As OMOP.Request.getProcedureOccurenceDataBO 
		#dim getObservationResponse As OMOP.Response.getProcedureOccurenceBO
		set getProcedureOccurenceDataRequest = ##class(OMOP.Request.getProcedureOccurenceDataBO).%New()
		

		// local table
		// no need to call external request
		set tRS=##class(%ResultSet).%New()
		Set tSC=tRS.Prepare("SELECT * FROM eventTable "_
							"WHERE "_
							"personId = "_pRequest.patientId_" "_
							"AND "_
							"sourceTable IN ('HSAA.Medication', 'Procedure') "_
							"AND ("_
							"encounter IN  "_
							;"(SELECT visit_occurrence_id  FROM SQLUser.visit_occurrence WHERE person_ID = "_pRequest.patientId_") "_
							"(SELECT visit_source_value FROM SQLUser.visit_occurrence WHERE person_ID = "_pRequest.patientId_") "_
							"OR "_
							"encounter is NULL )")
		quit:$$$ISERR(tSC)
		set tSC=tRS.Execute() 
		quit:$$$ISERR(tSC)
		
		While tRS.%Next() {
			
			; NEW check if we need to process this record
			if tRS.GetDataByName("eventConceptId") '= ""{
				s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("procedure_occurrence","procedure_concept_id",tRS.GetDataByName("eventConceptId"))
			} else {
				s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("procedure_occurrence","procedure_concept_id","",tRS.GetDataByName("eventSourceValue"))
			}
			continue:processFlag=""
			
			s measurementItem = ##class(OMOP.Proxy.MeasurementItem).%New()
			s measurementItem.ID = tRS.GetDataByName("ID")
			
			s measurementItem.encounter = tRS.GetDataByName("encounter")
			s measurementItem.eventConceptId = tRS.GetDataByName("eventConceptId")
			s measurementItem.eventEndTime = tRS.GetDataByName("eventEndTime")
			s measurementItem.eventSourceValue = tRS.GetDataByName("eventSourceValue")
			s measurementItem.eventStartTime = tRS.GetDataByName("eventStartTime")
			s measurementItem.modifierConceptId = tRS.GetDataByName("modifierConceptId")
			s measurementItem.modifierSourceValue = tRS.GetDataByName("modifierSourceValue")
			s measurementItem.providerName = tRS.GetDataByName("providerName")
			s measurementItem.qualifierConceptId = tRS.GetDataByName("qualifierConceptId")
			s measurementItem.qualifierSourceValue = tRS.GetDataByName("qualifierSourceValue")
			s measurementItem.routeConceptId = tRS.GetDataByName("routeConceptId")
			s measurementItem.routeSourceValue = tRS.GetDataByName("routeSourceValue")
			s measurementItem.sourceTable = tRS.GetDataByName("sourceTable")
			s measurementItem.unitConceptId = tRS.GetDataByName("unitConceptId")
			s measurementItem.unitSourceValue = tRS.GetDataByName("unitSourceValue")
			s measurementItem.valueAsConceptId = tRS.GetDataByName("valueAsConceptId")
			s measurementItem.valueSourceValue = tRS.GetDataByName("valueSourceValue")
			s measurementItem.eventEnteredonDate = tRS.GetDataByName("event_enteredon_date")
			s measurementItem.personId = pRequest.patientId
			

			// transform data
			# dim saveProcedureOccurenceRequest As OMOP.Request.saveProcedureOccurenceBO
			set saveProcedureOccurenceRequest = ##class(OMOP.Request.saveProcedureOccurenceBO).%New()
			s sc = ##class(OMOP.Transform.saveProcedureOccurenceBO).Transform(measurementItem, .saveProcedureOccurenceRequest)
			
			s saveProcedureOccurenceRequest.personId = pRequest.patientId
			s saveProcedureOccurenceRequest.procedureOccurrenceId = ..getNewId("procedure")
			s saveProcedureOccurenceRequest.visitDetailId = pRequest.visitDetailId
			s saveProcedureOccurenceRequest.visitOccurrenceId = pRequest.visitOccurrenceId
			s saveProcedureOccurenceRequest.providerId = pRequest.providerId
			
			// 1 - save data to IRIS
			set saveProcedureOccurenceRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveProcedureOccurenceRequest, .saveProcedureOccurenceResponse)
			q:$$$ISERR(sc)
			
			// 1 - save data to PostgreSQL
			set saveProcedureOccurenceRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveProcedureOccurenceRequest, .saveProcedureOccurenceResponse)
			q:$$$ISERR(sc)
			
			// delete processed row
			d ##class(User.eventTable).%DeleteId(tRS.GetDataByName("ID"))
			
		}
		
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

