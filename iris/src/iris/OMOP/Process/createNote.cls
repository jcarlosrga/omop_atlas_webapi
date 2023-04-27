/// 
/// 2021223 Denis Bulashev
/// Step 20 - Create Note
/// 
Class OMOP.Process.createNote Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createNote, Output pResponse As OMOP.Response.createNote) As %Status
{
	s sc = $$$OK
	try {
		// local table
		// no need to call external request
		set tRS=##class(%ResultSet).%New()
		Set tSC=tRS.Prepare("SELECT * FROM eventTable "_
							"WHERE "_
							"personId = "_pRequest.patientId_" ")

		quit:$$$ISERR(tSC)
		set tSC=tRS.Execute() 
		quit:$$$ISERR(tSC)
		
		While tRS.%Next() {
			
			; NEW check if we need to process this record
			if tRS.GetDataByName("eventConceptId") '= ""{
				s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("note","note_class_concept_id",tRS.GetDataByName("eventConceptId"))
			} else {
				s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("note","note_class_concept_id","",tRS.GetDataByName("eventSourceValue"))
			}
			
			continue:processFlag=""
			
			s eventItem = ##class(OMOP.Proxy.eventItem).%New()
			s eventItem.ID = tRS.GetDataByName("ID")
			s eventItem.encounter = tRS.GetDataByName("encounter")
			s eventItem.eventConceptId = tRS.GetDataByName("eventConceptId")
			s eventItem.eventEndTime = tRS.GetDataByName("eventEndTime")
			s eventItem.eventSourceValue = tRS.GetDataByName("eventSourceValue")
			s eventItem.eventStartTime = tRS.GetDataByName("eventStartTime")
			s eventItem.modifierConceptId = tRS.GetDataByName("modifierConceptId")
			s eventItem.modifierSourceValue = tRS.GetDataByName("modifierSourceValue")
			s eventItem.providerName = tRS.GetDataByName("providerName")
			s eventItem.qualifierConceptId = tRS.GetDataByName("qualifierConceptId")
			s eventItem.qualifierSourceValue = tRS.GetDataByName("qualifierSourceValue")
			s eventItem.routeConceptId = tRS.GetDataByName("routeConceptId")
			s eventItem.routeSourceValue = tRS.GetDataByName("routeSourceValue")
			s eventItem.sourceTable = tRS.GetDataByName("sourceTable")
			s eventItem.unitConceptId = tRS.GetDataByName("unitConceptId")
			s eventItem.unitSourceValue = tRS.GetDataByName("unitSourceValue")
			s eventItem.valueAsConceptId = tRS.GetDataByName("valueAsConceptId")
			s eventItem.valueSourceValue = tRS.GetDataByName("valueSourceValue")
			s eventItem.patientId = pRequest.patientId
			s eventItem.note = tRS.GetDataByName("note")
			

			// transform data
			# dim saveNoteRequest As OMOP.Request.saveNoteBO
			
			
			set saveNoteRequest = ##class(OMOP.Request.saveNoteBO).%New()
			s sc = ##class(OMOP.Transform.saveNoteBO).Transform(eventItem, .saveNoteRequest)
			
			s saveNoteRequest.personId = pRequest.patientId
			s saveNoteRequest.noteId = ..getNewId("note")
			s saveNoteRequest.visitDetailId = pRequest.visitDetailId
			s saveNoteRequest.visitOccurrenceId = pRequest.visitOccurrenceId
			s saveNoteRequest.providerId = pRequest.providerId
			
			// 1 - save data to IRIS
			set saveNoteRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveNoteRequest, .saveNoteResponse)
			q:$$$ISERR(sc)
			
			// 1 - save data to PostgreSQL
			set saveNoteRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveNoteRequest, .saveNoteResponse)
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

