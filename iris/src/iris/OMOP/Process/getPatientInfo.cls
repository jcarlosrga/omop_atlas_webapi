/// Step 0
/// BP - general process for data collecting and saving in OMOP format
Class OMOP.Process.getPatientInfo Extends Ens.BusinessProcess [ ClassType = persistent ]
{

/// drop all data
/// d ##class(OMOP.Utils.database).clearOMOPData()
/// k ^BUL
/// 
/// drop processing queue
/// UPDATE OMOP_Storage.PatientId SET processed = 0
/// 
/// CREATE INDEX Tbl_name_indx ON lookUpTbl(Tbl_name)
/// CREATE INDEX column_name_indx ON lookUpTbl(column_name)
/// CREATE INDEX source_code_indx ON lookUpTbl(source_code)
/// CREATE INDEX source_value_indx ON lookUpTbl(source_value)
/// CREATE INDEX concept_id_indx ON lookUpTbl(concept_id)
/// CREATE INDEX concept_value_indx ON lookUpTbl(concept_value)
/// CREATE INDEX domain_indx ON lookUpTbl("domain")
/// 
/// CREATE INDEX person_id_indx ON eventTable(personid)
/// ob
Property empty As %String;

/// The number of records which will be processed during one session
Property recordLimit As %Integer [ InitialExpression = 1 ];

Parameter SETTINGS = "recordLimit";

Method clearEventTable(personId)
{

	d ##class(OMOP.Storage.PatientId).%KillExtent()
	// local table
	// no need to call external request
	set tRS=##class(%ResultSet).%New()
	set sc=tRS.Prepare("DELETE FROM eventTable WHERE personId = ?")
	q:$$$ISERR(sc)
	set sc=tRS.Execute(personId)
	q:$$$ISERR(sc)
}

/// remove all data for patient with patient id = pId from database
Method clearPatientData(pId = "")
{
	q:pId=""
	
	// get personID and clean person table
	set tRS = ##class(%ResultSet).%New()
	set SQL = "SELECT person_id FROM person WHERE person_source_value LIKE '"_pId_"|%'" 
	set tSC = tRS.Prepare(SQL)
	q:$$$ISERR(tSC)
	
	set tSC = tRS.Execute()
	while (tRS.Next(.tSC)) {
		q:$$$ISERR(tSC)
		
		s personID = tRS.Data("person_id")
		continue:personID=""
		
		; delete records from other tables
		for tblName = "visit_occurrence", "visit_detail", "specimen", "procedure_occurrence", "payer_plan_period", "observation_period", "observation", "note", "measurement", "drug_exposure", "device_exposure", "death", 
			"cost", "condition_occurrence", "condition_era" {
			set tRS2 = ##class(%ResultSet).%New()
			set SQL2 = "DELETE FROM "_tblName_" WHERE person_id = "_personID
			set tSC2 = tRS2.Prepare(SQL2)
			q:$$$ISERR(tSC2)
			
			set tSC2 = tRS2.Execute()
			q:$$$ISERR(tSC2)
			
			d tRS2.Close()
		}
		
		; eventTable -> personId
		set tRS2 = ##class(%ResultSet).%New()
		set SQL2 = "DELETE FROM eventTable WHERE personId = "_personID
		set tSC2 = tRS2.Prepare(SQL2)
		q:$$$ISERR(tSC2)
		set tSC2 = tRS2.Execute()
		q:$$$ISERR(tSC2)
		d tRS2.Close()
	}
	
	d tRS.Close()

	set SQL = "DELETE FROM person WHERE person_source_value LIKE '"_pId_"|%'" 
	set tSC = tRS.Prepare(SQL)
	q:$$$ISERR(tSC)
	set tSC = tRS.Execute()
	q:$$$ISERR(tSC)

	d tRS.Close()
}

/// returns next patiend Id from the queue for processing
/// d ##class(OMOP.Process.getPatientInfo).getNextPatientId()
ClassMethod getNextPatientId() As %String
{
	s sc = $$$OK
	try {
		lock +^getNextPatientId:15
		set ret = ""
		
		// get patient ID for processing
		set tRS = ##class(%ResultSet).%New()
		set SQL = "SELECT TOP 1 pId, ID FROM OMOP_Storage.patientId WHERE processed = 0 ORDER BY pId DESC" 
		
		set tSC = tRS.Prepare(SQL)
		if $$$ISERR(tSC) {
			lock -^getNextPatientId
		}
		
		set tSC = tRS.Execute()  
		if $$$ISERR(tSC) {
			lock -^getNextPatientId
		}
		
		while (tRS.Next(.tSC)) { 
				q:$$$ISERR(tSC)
				
				; mark patient as processed
				s patientCls = ##class(OMOP.Storage.PatientId).%OpenId(tRS.Data("ID"))
				s patientCls.processed = 1
				s err = patientCls.%Save()
				s ret = tRS.Data("pId")
		}
		
		if $$$ISERR(tSC) {
			lock -^getNextPatientId
		}
		
		lock -^getNextPatientId

	} catch e {
		s sc = e.AsStatus()
		lock -^getNextPatientId
	}
	
	q ret
}

Method OnRequest(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{
	s sc = $$$OK
	try {
		set startTime = $zh
		$$$TRACE(" >>> start "_$j)
		
		; set recordLimit = 1
		
		; !!! DEBUG !!!
		; clear all previously loaded data
		; d ##class(OMOP.Utils.database).clearOMOPData()
		
		Set n=0  
		while n < ..recordLimit { 
			set n = n+1
			s patientId = ..getNextPatientId()
			q:patientId=""
			$$$TRACE("Processing patient (ID = "_patientId_")")
			
			
			//Check if patient exists and clear data if so
			#dim clearPatientDataRequest As OMOP.Request.clearPatientDataBP
			set clearPatientDataRequest = ##class(OMOP.Request.clearPatientDataBP).%New()
			set clearPatientDataRequest.patientId = patientId
			s sc = ..SendRequestSyncDebug("Process.clearPatientData", clearPatientDataRequest, .clearPatientDataRespons)
			
			; d ..clearPatientData(patientId)
			
			// get patient info
			#dim patientInfoRequest As OMOP.Request.getPatientInfo
			#dim patientInfoResponse As OMOP.Response.getPatientInfo
			set patientInfoRequest = ##class(OMOP.Request.getPatientInfo).%New()
			set patientInfoRequest.patientId = patientId
			set sc = ..SendRequestSyncDebug("Operation.getPatientInfo", patientInfoRequest, .patientInfoResponse)
			continue:$$$ISERR(sc)
			
			if patientInfoResponse.id = "" { // empty patient
				// ??? LOG ERROR
				continue	
			}
			
			
			
			// 4 - create patient location
			#dim getPatientLocationRequest As OMOP.Request.getPatientLocationBO
			#dim getPatientLocationResponse As OMOP.Response.getPatientLocationBP
			set getPatientLocationRequest = ##class(OMOP.Request.getPatientLocationBP).%New()
			set getPatientLocationRequest.patientId = patientInfoResponse.id
			set sc = ..SendRequestSyncDebug("Process.getPatientLocation", getPatientLocationRequest, .getPatientLocationResponse)
			continue:$$$ISERR(sc)
			set locationIdIRIS = getPatientLocationResponse.locationId

			


			// 5 - Find CareProvider using patient_id and keep care_provider_id
			// Dont mess it with step 8 - Create/check provide !!!
			#dim getCareProviderRequest As OMOP.Request.getCareProviderBO
			#dim getCareProviderResponse As OMOP.Response.getCareProviderBO
			set getCareProviderRequest = ##class(OMOP.Request.getCareProviderBO).%New()
			set getCareProviderRequest.patientId = patientId
			set sc = ..SendRequestSyncDebug("Operation.getCareProvider", getCareProviderRequest, .getCareProviderResponse)
			continue:$$$ISERR(sc)
			set careProviderId = getCareProviderResponse.CareProviderId



			
			// only if provider was found
			if careProviderId'=""{
				
				// 6 - Find care site using provider data and keep site_id
				#dim getCareSiteRequest As OMOP.Request.getCareSiteBO
				#dim getCareSiteResponse As OMOP.Response.getCareSiteBO
				set getCareSiteRequest = ##class(OMOP.Request.getCareSiteBO).%New()
				set getCareSiteRequest.careProviderId = careProviderId
				set sc = ..SendRequestSyncDebug("Operation.getCareSite", getCareSiteRequest, .getCareSiteResponse)
				continue:$$$ISERR(sc)
				set careSiteId = getCareSiteResponse.CareSiteId
				

				if careSiteId '= ""{
					// 7 - Create / check Care site + Location 
					#dim checkCreateCareSiteRequest As OMOP.Request.createCheckCareSiteBP
					#dim checkCreateCareSiteResponse As OMOP.Response.createCheckCareSiteBP
					set checkCreateCareSiteRequest = ##class(OMOP.Request.createCheckCareSiteBP).%New()
					set checkCreateCareSiteRequest.careProviderId = careProviderId
					set sc = ..SendRequestSyncDebug("Process.checkCreateCareSite", checkCreateCareSiteRequest, .checkCreateCareSiteResponse)
					continue:$$$ISERR(sc)
					set careSiteIdIRIS = checkCreateCareSiteResponse.careSiteId
					set careSiteLocationIdIRIS = checkCreateCareSiteResponse.careLocationId

					
					
					
					// 8 - Create / check provider
					#dim checkCreateCareProviderRequest As OMOP.Request.createCheckCareProviderBP
					#dim checkCreateCareProviderResponse As OMOP.Response.createCheckCareProviderBP
					set checkCreateCareProviderRequest = ##class(OMOP.Request.createCheckCareProviderBP).%New()
					set checkCreateCareProviderRequest.careProviderId = careProviderId
					set checkCreateCareProviderRequest.careSiteIdIRIS = careSiteIdIRIS
					
					set sc = ..SendRequestSyncDebug("Process.checkCreateCareProvider", checkCreateCareProviderRequest, .checkCreateCareProviderResponse)
					set careProviderIdIRIS = checkCreateCareProviderResponse.providerId
					continue:$$$ISERR(sc)
					
					
					
				} else {
					set careSiteId = ""
					set careProviderId = ""
					// go to step 9
				}
				
				
			} else {
				set careSiteId = ""
				set careProviderId = ""
				// go to step 9
			}
			
			
			
			s patientId = $g(patientId)
			s locationIdIRIS = $g(locationIdIRIS)
			s careProviderIdIRIS = $g(careProviderIdIRIS)
			s careSiteIdIRIS = $g(careSiteIdIRIS)
			
			
			// 9 - Create PERSON (patient) in OMOP
			#dim createPersonRequest As OMOP.Request.createPersonBP
			#dim createPersonResponse As OMOP.Response.createPersonBP
			set createPersonRequest = ##class(OMOP.Request.createPersonBP).%New()
			set createPersonRequest.patinetId = $g(patientId)
			set createPersonRequest.locationId = $g(locationIdIRIS)			; createPatientLocationResponse.locationIdI
			set createPersonRequest.providerId = $g(careProviderIdIRIS)		; getCareProviderResponse.CareProviderId
			set createPersonRequest.careSiteId = $g(careSiteIdIRIS)			; checkCreateCareProviderResponse.providerId		;!!!
			set sc = ..SendRequestSyncDebug("Process.createPerson", createPersonRequest, .createPersonResponse)
			continue:$$$ISERR(sc)
			set personIdIRIS = createPersonResponse.personId
			
			
			

			// 10 - Create Death 
			#dim createDeathRequest As OMOP.Request.createDeathBP
			#dim createDeathResponse As OMOP.Response.createDeathBP
			set createDeathRequest = ##class(OMOP.Request.createDeathBP).%New()
			set createDeathRequest.patientId = patientId
			set createDeathRequest.personId = personIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createDeath", createDeathRequest, .createDeathResponse)
			continue:$$$ISERR(sc)
			
			
			
			
			// 11 - Create Visit_occurrence using patient_id for each encounter
			#dim createVisitOccurenceRequestBP As OMOP.Request.createVisitOccurenceBP
			#dim createVisitOccurenceResponseBP As OMOP.Response.createVisitOccurenceBP
			set createVisitOccurenceRequestBP = ##class(OMOP.Request.createVisitOccurenceBP).%New()
			set createVisitOccurenceRequestBP.careSiteId = careSiteIdIRIS
			set createVisitOccurenceRequestBP.patientId = patientId				// bayState
			set createVisitOccurenceRequestBP.personId = personIdIRIS			// IRIS OMOP
			set createVisitOccurenceRequestBP.providerId = careProviderIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createVisitOccurence", createVisitOccurenceRequestBP, .createVisitOccurenceResponseBP)
			continue:$$$ISERR(sc)
			set visitOccurrenceIdIRIS = createVisitOccurenceResponseBP.visitOccurrenceId
			set visitDetailIdIRIS = createVisitOccurenceResponseBP.visitDetailId
						
						
			
			// 12.0  - clear all event data for this person ID
			// local table
			// no need to call external request
			set tRS=##class(%ResultSet).%New()
			Set sc=tRS.Prepare("DELETE FROM eventTable "_
								"WHERE "_
								"personId = "_personIdIRIS)
			continue:$$$ISERR(sc)
			set sc=tRS.Execute()
			continue:$$$ISERR(sc)
			
			
			// 12.0 - Create tmp table to store all visits information for patient
			// Creat event_table from HSAA tables using patient_id 
			#dim createEventTableRequest As OMOP.Request.createEventTable
			#dim createEventTableResponse As OMOP.Response.createEventTable
			set createEventTableRequest = ##class(OMOP.Request.createEventTable).%New()
			set createEventTableRequest.patientId = patientId
			set createEventTableRequest.personId = personIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createEventTable", createEventTableRequest, .createEventTableResponse)
			continue:$$$ISERR(sc)
			
			// process all encounters by patient ID
			; 13 - condition
			#dim createConditionRequest As OMOP.Request.createCondition
			#dim createConditionResponse As OMOP.Response.createCondition
			set createConditionRequest = ##class(OMOP.Request.createCondition).%New()
			set createConditionRequest.patientId = personIdIRIS
			set createConditionRequest.providerId = careProviderIdIRIS
			set createConditionRequest.visitDetailId = visitDetailIdIRIS
			set createConditionRequest.visitOccurrenceId = visitOccurrenceIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createCondition", createConditionRequest, .createConditionResponse)
			;continue:$$$ISERR(sc)
			

			; 14 - obsevation
			#dim createObservationRequest AS OMOP.Request.createObservation
			#dim createObservationResponse AS OMOP.Response.createObservation
			set createObservationRequest = ##class(OMOP.Request.createObservation).%New()
			//set createObservationRequest.encounterId = encounterID
			set createObservationRequest.patientId = personIdIRIS
			set createObservationRequest.providerId = careProviderIdIRIS
			set createObservationRequest.visitDetailId = visitDetailIdIRIS
			set createObservationRequest.visitOccurrenceId = visitOccurrenceIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createObservation", createObservationRequest, .createObservationResponse)
			;continue:$$$ISERR(sc)
			

			; 15 - measurement
			#dim createmeasurementRequest AS OMOP.Request.createMeasurement
			#dim createmeasurementResponse AS OMOP.Response.createMeasurement
			set createmeasurementRequest = ##class(OMOP.Request.createMeasurement).%New()
			set createmeasurementRequest.patientId = personIdIRIS
			set createmeasurementRequest.providerId = careProviderIdIRIS
			set createmeasurementRequest.visitDetailId = visitDetailIdIRIS
			set createmeasurementRequest.visitOccurrenceId = visitOccurrenceIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createMeasurement", createmeasurementRequest, .createmeasurementResponse)
			;continue:$$$ISERR(sc)
			
						
						
			; 16 - procedure_occurence
			#dim createProcedureOccurenceRequest AS OMOP.Request.createProcedureOccurence
			#dim createProcedureOccurenceResponse AS OMOP.Response.createProcedureOccurence
			set createProcedureOccurenceRequest = ##class(OMOP.Request.createProcedureOccurence).%New()
			set createProcedureOccurenceRequest.patientId = personIdIRIS
			set createProcedureOccurenceRequest.providerId = careProviderIdIRIS
			set createProcedureOccurenceRequest.visitDetailId = visitDetailIdIRIS
			set createProcedureOccurenceRequest.visitOccurrenceId = visitOccurrenceIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createProcedureOccurence", createProcedureOccurenceRequest, .createProcedureOccurenceResponse)
			;continue:$$$ISERR(sc)
			
		
 			; 17 - DrugExposure
			#dim createDrugExposureRequest AS OMOP.Request.createDrugExposure
			#dim createDrugExposureResponse AS OMOP.Response.createDrugExposure
			set createDrugExposureRequest = ##class(OMOP.Request.createDrugExposure).%New()
			set createDrugExposureRequest.patientId = personIdIRIS
			set createDrugExposureRequest.providerId = careProviderIdIRIS
			set createDrugExposureRequest.visitDetailId = visitDetailIdIRIS
			set createDrugExposureRequest.visitOccurrenceId = visitOccurrenceIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createDrugExposure", createDrugExposureRequest, .createDrugExposureResponse)
			;continue:$$$ISERR(sc)
			

						
			; 18 - DeviceExposure
			#dim createDeviceExposureRequest AS OMOP.Request.createDeviceExposure
			#dim createDeviceExposureResponse AS OMOP.Response.createDeviceExposure
			set createDeviceExposureRequest = ##class(OMOP.Request.createDeviceExposure).%New()
			set createDeviceExposureRequest.patientId = personIdIRIS
			set createDeviceExposureRequest.providerId = careProviderIdIRIS
			set createDeviceExposureRequest.visitDetailId = visitDetailIdIRIS
			set createDeviceExposureRequest.visitOccurrenceId = visitOccurrenceIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createDeviceExposure", createDeviceExposureRequest, .createDeviceExposureResponse)
			;continue:$$$ISERR(sc)
						
			
			
			; 19 - specimen
			#dim createSpecimenRequest AS OMOP.Request.createSpecimen
			#dim createSpecimenResponse AS OMOP.Response.createSpecimen
			set createSpecimenRequest = ##class(OMOP.Request.createSpecimen).%New()
			set createSpecimenRequest.patientId = personIdIRIS
			set createSpecimenRequest.providerId = careProviderIdIRIS
			set createSpecimenRequest.visitDetailId = visitDetailIdIRIS
			set createSpecimenRequest.visitOccurrenceId = visitOccurrenceIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createSpecimen", createSpecimenRequest, .createSpecimenResponse)
			;continue:$$$ISERR(sc)


			
			; 20 - note
			#dim createNoteRequest AS OMOP.Request.createNote
			#dim createNoteResponse AS OMOP.Response.createNote
			set createNoteRequest = ##class(OMOP.Request.createNote).%New()
			set createNoteRequest.patientId = personIdIRIS
			set createNoteRequest.providerId = careProviderIdIRIS
			set createNoteRequest.visitDetailId = visitDetailIdIRIS
			set createNoteRequest.visitOccurrenceId = visitOccurrenceIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createNote", createNoteRequest, .createNoteResponse)
			;continue:$$$ISERR(sc)


			
			;; work slow - debug
			;; !!! save the rest of the records from the eventTable to the observation table
			;; 14 - observation
			;set createObservationRequest = ##class(OMOP.Request.createObservation).%New()
			;//set createObservationRequest.encounterId = encounterID
			;set createObservationRequest.patientId = personIdIRIS
			;set createObservationRequest.providerId = careProviderIdIRIS
			;set createObservationRequest.visitDetailId = visitDetailIdIRIS
			;set createObservationRequest.visitOccurrenceId = visitOccurrenceIdIRIS
			;set createObservationRequest.saveRemains = 1
			;set sc = ..SendRequestSyncDebug("Process.createObservation", createObservationRequest, .createObservationResponse)
			;continue:$$$ISERR(sc)
			
			
			// no need to call external request
			set tRS=##class(%ResultSet).%New()
			Set sc=tRS.Prepare("DELETE FROM eventTable "_
								"WHERE "_
								"personId = "_personIdIRIS)
			continue:$$$ISERR(sc)
			set sc=tRS.Execute()
			continue:$$$ISERR(sc)
		/// }  old end of while cycle
		
		
		; 21 - fact relationship
			#dim createFactRelationshipRequest AS OMOP.Request.createFactRelationshipConceptId
		#dim createFactRelationshipResponse AS Ens.Response
			set createFactRelationshipRequest = ##class(OMOP.Request.createFactRelationshipConceptId).%New()
			set createFactRelationshipRequest.personId = personIdIRIS
		set sc = ..SendRequestSyncDebug("Process.createFactRelationshipConceptId", createFactRelationshipRequest, .createFactRelationshipResponse)
		quit:$$$ISERR(sc)
		

			; 22 - observation period
			#dim createObservationPeriodRequest As OMOP.Request.createObservationPeriod
			set createObservationPeriodRequest = ##class(OMOP.Request.createObservationPeriod).%New()
			set createObservationPeriodRequest.personId = personIdIRIS
			set sc = ..SendRequestSyncDebug("Process.createObservationPeriod", createObservationPeriodRequest, .createObservationPeriodResponse)
			quit:$$$ISERR(sc)
		
		}
		
		set stopTime = $zh
		set workingTime = stopTime - startTime
		$$$TRACE(" >>> stop "_$j_" working time "_workingTime)
		
		
		s pLog = ##class(User.processingMonitor).%New()
		s pLog.personid = patientId
		s pLog.processingTime = workingTime
		s pLog.grp = "totalTime"
		s pLog.dateTime = $tr($zdt($h,3,1),"- :")
		d pLog.%Save()

	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

/// debug method
/// ..SendRequestSyncDebug( -> ..SendRequestSyncDebug(
/// k ^BUL
/// d ##class(OMOP.Utils.database).profilerParse()
Method SendRequestSyncDebug(pName, pRequest, pResponse)
{
	s sc = $$$OK
	
	try {
		set startTime = $zh
		
		set sc = ..SendRequestSync(pName, pRequest, .pResponse)
		
		set stopTime = $zh
		set workingTime = stopTime - startTime

		s pLog = ##class(User.processingMonitor).%New()
		s pLog.personid = 1
		s pLog.processingTime = workingTime
		s pLog.grp = pName
		s pLog.dateTime = $tr($zdt($h,3,1),"- :")
		d pLog.%Save()
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

Storage Default
{
<Data name="getPatientInfoDefaultData">
<Subscript>"getPatientInfo"</Subscript>
<Value name="1">
<Value>recordLimit</Value>
</Value>
<Value name="2">
<Value>empty</Value>
</Value>
</Data>
<DefaultData>getPatientInfoDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
