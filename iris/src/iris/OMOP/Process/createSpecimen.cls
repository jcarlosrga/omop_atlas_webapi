/// 
/// 2021119 Denis Bulashev
/// Step 19 - Create Specimen
/// 
Class OMOP.Process.createSpecimen Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createSpecimen, Output pResponse As OMOP.Response.createSpecimen) As %Status
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
				s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("specimen","specimen_concept_id",tRS.GetDataByName("eventConceptId"))
			} else {
				s processFlag = ##class(OMOP.Common.DataTransform).getLookUpTblValue("specimen","specimen_concept_id","",tRS.GetDataByName("eventSourceValue"))
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
			s measurementItem.personId = pRequest.patientId
			

			// transform data
			# dim saveSpecimenRequest As OMOP.Request.saveSpecimenBO
			set saveSpecimenRequest = ##class(OMOP.Request.saveSpecimenBO).%New()
			s sc = ##class(OMOP.Transform.saveSpecimenExposureBO).Transform(measurementItem, .saveSpecimenRequest)
			
			s saveSpecimenRequest.personId = pRequest.patientId
			s saveSpecimenRequest.specimenId = ..getNewId("specimen")
			
			// 1 - save data to IRIS
			set saveSpecimenRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveSpecimenRequest, .saveSpecimenResponse)
			q:$$$ISERR(sc)
			
			// 1 - save data to PostgreSQL
			set saveSpecimenRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveSpecimenRequest, .saveSpecimenResponse)
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

