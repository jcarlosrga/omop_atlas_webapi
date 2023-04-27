/// 
/// 20211111Denis Bulashev
/// Step 15 - Create Measurement
/// 
Class OMOP.Process.createMeasurement Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createMeasurement, Output pResponse As OMOP.Response.createMeasurement) As %Status
{
	s sc = $$$OK
	try {

		// 2 - Get data
		#dim getObservationDataRequest As OMOP.Request.getMeasurementDataBO 
		#dim getObservationResponse As OMOP.Response.getMeasurementDataBO
		
		set getMeasurementDataRequest = ##class(OMOP.Request.getMeasurementDataBO).%New()
		
		
		// local table
		// no need to call external request
		set tRS=##class(%ResultSet).%New()
		Set tSC=tRS.Prepare("SELECT * FROM eventTable "_
							"WHERE "_
							"personId = "_pRequest.patientId_" "_
							"AND ("_
							"encounter IN  "_
							; "(SELECT visit_occurrence_id  FROM SQLUser.visit_occurrence WHERE person_ID = "_pRequest.patientId_") "_
							"(SELECT visit_source_value  FROM SQLUser.visit_occurrence WHERE person_ID = "_pRequest.patientId_") "_
							"OR "_
							"encounter is NULL )")
		quit:$$$ISERR(tSC)
		set tSC=tRS.Execute() 
		quit:$$$ISERR(tSC)
		
		While tRS.%Next() {
			; there is no measurement table in event select
			; continue:$zcvt(tRS.GetDataByName("sourceTable"),"L")'="measurement"
			;continue:$zcvt(tRS.GetDataByName("sourceTable"),"L")'="observation"
			

			; NEW check if we need to process this record
			if tRS.GetDataByName("eventConceptId") '= ""{
				s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("measurement","measurement_concept_id",tRS.GetDataByName("eventConceptId"))
			} else {
				s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("measurement","measurement_concept_id","",tRS.GetDataByName("eventSourceValue"))
			}
			continue:processFlag=""
			
			# dim saveMeasurementRequest As OMOP.Request.saveMeasurementBO
			
			if $zcvt(tRS.GetDataByName("sourceTable"),"L")="observation" {
				s sc = ..getMeasurement4Observation(pRequest, tRS, .saveMeasurementRequest)
			}
			elseif $zcvt(tRS.GetDataByName("sourceTable"),"L")="labresult" {
				s sc = ..getMeasurement4LabResult(pRequest, tRS, .saveMeasurementRequest)
			}
			else  {
				set saveMeasurementRequest = "" ;##class(OMOP.Request.saveMeasurementBO).%New()
			}
			
			if $IsObject(saveMeasurementRequest) {
				// 1 - save data to IRIS
				set saveMeasurementRequest.target = "IRIS"
				set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveMeasurementRequest, .saveMeasurementResponse)
				q:$$$ISERR(sc)
				
				// 1 - save data to PostgreSQL
				set saveMeasurementRequest.target = "PostgreSQL"
				set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveMeasurementRequest, .saveMeasurementResponse)
				q:$$$ISERR(sc)
			}
			
			// delete processed row
			d ##class(User.eventTable).%DeleteId(tRS.GetDataByName("ID"))
		}

	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

Method getMeasurement4Observation(pRequest As OMOP.Request.createMeasurement, tRS As %ResultSet, Output saveMeasurementRequest As OMOP.Request.saveMeasurementBO) As %Status [ Private ]
{
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
			//# dim saveMeasurementRequest As OMOP.Request.saveMeasurementBO
			set saveMeasurementRequest = ##class(OMOP.Request.saveMeasurementBO).%New()
			s sc = ##class(OMOP.Transform.saveMeasurement).Transform(measurementItem, .saveMeasurementRequest)
			
			s saveMeasurementRequest.personId = pRequest.patientId
			s saveMeasurementRequest.measurementId = ..getNewId("measurement")
			s saveMeasurementRequest.providerId = pRequest.providerId
			s saveMeasurementRequest.visitOccurrenceId = pRequest.visitOccurrenceId
			s saveMeasurementRequest.visitDetailId = pRequest.visitDetailId	
			
			Quit sc
}

Method getMeasurement4LabResult(pRequest As OMOP.Request.createMeasurement, tRS As %ResultSet, Output saveMeasurementRequest As OMOP.Request.saveMeasurementBO) As %Status [ Private ]
{
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
			//# dim saveMeasurementRequest As OMOP.Request.saveMeasurementBO
			set saveMeasurementRequest = ##class(OMOP.Request.saveMeasurementBO).%New()
			s sc = ##class(OMOP.Transform.saveMeasurement).Transform(measurementItem, .saveMeasurementRequest)
			
			s saveMeasurementRequest.personId = pRequest.patientId
			s saveMeasurementRequest.measurementId = ..getNewId("measurement")
			s saveMeasurementRequest.providerId = pRequest.providerId
			s saveMeasurementRequest.visitOccurrenceId = pRequest.visitOccurrenceId
			s saveMeasurementRequest.visitDetailId = pRequest.visitDetailId	
			
			Quit sc
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}

