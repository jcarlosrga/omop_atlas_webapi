/// 
/// 20211026 Denis Bulashev
/// Step 13 - Create condition
/// 
Class OMOP.Process.createCondition Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createCondition, Output pResponse As OMOP.Response.createCondition) As %Status
{
	s sc = $$$OK
	try {
		// local table
		// no need to call external request
		Set tRS=##class(%ResultSet).%New()
		
		Set tSC=tRS.Prepare("SELECT * FROM eventTable "_
							"WHERE "_
							"personId = "_pRequest.patientId_" "_
							"AND "_
							"sourceTable='Problem' "_  ;"sourceTable<>'HSAA.Medication' "_
							"AND ("_
							"encounter IN  "_
							"(SELECT visit_source_value FROM SQLUser.visit_occurrence WHERE person_ID = "_pRequest.patientId_") "_
							"OR "_
							"encounter is NULL )")
		
		
		Quit:$$$ISERR(tSC)
		Set tSC=tRS.Execute() 
		Quit:$$$ISERR(tSC)
		s cnt = 0
		
		While tRS.%Next() {
			; NEW check if we need to process this record
			s processFlag = ""
			
			if tRS.GetDataByName("eventConceptId")'="" {
				s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("condition_occurrence","condition_concept_id",tRS.GetDataByName("eventConceptId"))
			} else {
				s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("condition_occurrence","condition_concept_id","",tRS.GetDataByName("eventSourceValue"))
			}
			
			continue:processFlag=""
			
			s conditionItem = ##class(OMOP.Proxy.conditionItem).%New()
			s conditionItem.ID = tRS.GetDataByName("ID")
			s conditionItem.encounter = tRS.GetDataByName("encounter")
			s conditionItem.eventConceptId = tRS.GetDataByName("eventConceptId")
			s conditionItem.eventSourceValue = tRS.GetDataByName("eventSourceValue")			
			s conditionItem.eventStartTime = tRS.GetDataByName("eventStartTime")
			s conditionItem.eventEndTime = tRS.GetDataByName("eventEndTime")
			s conditionItem.eventEnteredonDate = tRS.GetDataByName("eventEnteredonDate")			
			s conditionItem.providerName = tRS.GetDataByName("providerName")
			s conditionItem.qualifierConceptId = tRS.GetDataByName("qualifierConceptId")
			s conditionItem.qualifierSourceValue = tRS.GetDataByName("qualifierSourceValue")			
			s conditionItem.unitConceptId = tRS.GetDataByName("unitConceptId")
			s conditionItem.unitSourceValue = tRS.GetDataByName("unitSourceValue")
			s conditionItem.routeSourceValue = tRS.GetDataByName("routeSourceValue")
			s conditionItem.valueAsConceptId = tRS.GetDataByName("valueAsConceptId")
			s conditionItem.valueSourceValue = tRS.GetDataByName("valueSourceValue")
			s conditionItem.quantity = tRS.GetDataByName("quantity")
			s conditionItem.sourceTable = tRS.GetDataByName("sourceTable")
			s conditionItem.sourceId =  tRS.GetDataByName("sourceId")
			s conditionItem.note =  tRS.GetDataByName("note")
			s conditionItem.personId = pRequest.patientId
			
			
			// transform data
			# dim saveConditionRequest As OMOP.Request.saveConditionBO
			set saveEventRequest = ##class(OMOP.Request.saveConditionBO).%New()
			s sc = ##class(OMOP.Transform.saveCondition).Transform(conditionItem, .saveConditionRequest)
			q:$$$ISERR(sc)
			
			
			s saveConditionRequest.personId = pRequest.patientId
			s saveConditionRequest.conditionOccurrenceId = ..getNewId("condition")
			s saveConditionRequest.providerId = pRequest.providerId
			;s saveConditionRequest.visitOccurrenceId = pRequest.visitOccurrenceId
			;s saveConditionRequest.visitDetailId = pRequest.visitDetailId
			
			
			// 1 - save data to IRIS
			set saveConditionRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveConditionRequest, .saveConditionResponse)
			q:$$$ISERR(sc)
			
			// 1 - save data to PostgreSQL
			set saveConditionRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveConditionRequest, .saveConditionResponse)
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

