/// 
/// 20211005 Denis Bulashev
/// Step 11 - Create Visit_occurrence
/// 
Class OMOP.Process.createVisitOccurence Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createVisitOccurenceBP, Output pResponse As OMOP.Response.createVisitOccurenceBP) As %Status
{
	s sc = $$$OK
	try {

		set sc = pRequest.NewResponse(.pResponse)
		q:$$$ISERR(sc)
		
		// 2 - Get data
		#dim getVisitOccurenceRequest As OMOP.Request.getVisitOccurenceBO 
		#dim getVisitOccurenceResponse As OMOP.Response.getVisitOccurenceBO
		set getVisitOccurenceRequest = ##class(OMOP.Request.getVisitOccurenceBO).%New()
		set getVisitOccurenceRequest.patientId = pRequest.patientId
		
		set sc = ..SendRequestSync("Operation.getVisitOccurence", getVisitOccurenceRequest, .getVisitOccurenceResponse)
		q:$$$ISERR(sc)
		
	
		// for each encounter
		for visitOccurenceNum = 1:1:getVisitOccurenceResponse.occurencies.Count(){
			set visitOccurence = getVisitOccurenceResponse.occurencies.GetAt(visitOccurenceNum)
 
			// transform data
			#dim saveVisitOccurenceRequest As OMOP.Request.saveVisitOccurence
			set saveVisitOccurenceRequest = ##class(OMOP.Request.saveVisitOccurence).%New()
			set visitOccurence.patient = pRequest.personId
			
			set sc = ##class(OMOP.Transform.getVisitOccurrence).Transform(visitOccurence, .saveVisitOccurenceRequest)
			set saveVisitOccurenceRequest.visitOccurrenceId = ..getNewId("visitOccurence")
			
			; steps 6 7 8
			
			// check provider id
			// FIND  AttendingClinician_Code | AttendingClinician_SDACodingStandard in provider_source_value field in OMOP.Provider table
			set tRS=##class(%ResultSet).%New()
			
			Set tSC=tRS.Prepare("SELECT provider_id FROM provider "_
								"WHERE provider_source_value LIKE '"_visitOccurence.attendingClinicianCode_"|"_visitOccurence.attendingClinicianSDACodingStandard_"%'")
			
			quit:$$$ISERR(tSC)
			set tSC=tRS.Execute() 
			quit:$$$ISERR(tSC)
			
			s providerId = ""
			d tRS.%Next(.tSC)
			quit:$$$ISERR(tSC)
			set providerId = tRS.GetDataByName("provider_id")
			d tRS.Close()
			
			
			; if provider not found in iris
			; disabled
 			if 0 && providerId = "" {
				
				// do to steps 6 7 8
				$$$LOGALERT("Care provider IRIS ID is empty")
				
				; get info to create care site and location
				Set tSC=tRS.Prepare("SELECT TOP 1 "_
						"cp.id, cp.code as BHSID, cp.description as Provider, cp.SDACodingStandard as SDACode, "_
						"cps.startdate, cps.enddate, cps.lastupdated, "_
						"s.id as SiteID, s.rawname as Site, "_
						"hcf.code as HCFID, hcf.description as HCFacility, hcf.rawname as HCFName "_
						"FROM hsaa.careprovider cp "_
						"INNER JOIN hsaa.careprovidersite cps "_
						"ON cp.id = cps.careprovider "_
							"INNER JOIN (select careprovider, max(lastupdated) as lastupdated from hsaa.careprovidersite group by careprovider) cps_max "_
						  	"ON cps.careprovider = cps_max.careprovider "_
						  	"AND cps.lastupdated = cps_max.lastupdated "_
							"INNER JOIN hsaa.site s "_
						  	"ON cps.site = s.id "_
								"INNER JOIN hsaa.healthcarefacility hcf "_
						  		"ON s.healthcarefacility = hcf.id "_
								"WHERE "_
								"cp.code != cp.description "_
								"AND cp.code='"_visitOccurence.attendingClinicianCode_"' "_
								"AND cp.SDACodingStandard ='"_visitOccurence.attendingClinicianSDACodingStandard_"' "_
								"ORDER BY BHSID, lastupdated DESC")

				quit:$$$ISERR(tSC)
				
				set tSC=tRS.Execute() 
				quit:$$$ISERR(tSC)
				
				s careSiteId = ""
				d tRS.%Next(.tSC)
				quit:$$$ISERR(tSC)
				
				set careSiteId = tRS.GetDataByName("SiteID")
				
				d tRS.Close()
				
				
				; if care site was found in bay state database
				if careSiteId '= ""{
					
					; 1 check if we already have this location in IRIS
					set locationSourceValue = $e("s"_careSiteId_"|",1,50)
					
					set tSC=tRS.Prepare("SELECT TOP 1 location_id FROM location "_
										"WHERE location_source_value LIKE '"_locationSourceValue_"%'")
										
					quit:$$$ISERR(tSC)
					set tSC=tRS.Execute() 
					quit:$$$ISERR(tSC)
					
					set locationIRISId = ""
					do tRS.%Next(.tSC)
					quit:$$$ISERR(tSC)
						
					set locationIRISId = tRS.GetDataByName("location_id")
					
					d tRS.Close()
					
					; if we do not have this location in OMOP - create new one
					if locationIRISId=""{
						; create new location
						#dim saveCareLocationInfoRequest As OMOP.Request.saveCareLocationInfoBO
						set saveCareLocationInfoRequest = ##class(OMOP.Request.saveCareLocationInfoBO).%New()
						set saveCareLocationInfoRequest.locationId = ..getNewId("location")
						set locationIRISId = saveCareLocationInfoRequest.locationId
						set saveCareLocationInfoRequest.locationSourceValue = locationSourceValue
						set saveCareLocationInfoRequest.type = "savePatientLocation"
						
						
						// 3 - save care Location information in IRIS
						set saveCareLocationInfoRequest.target = "IRIS"
						set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveCareLocationInfoRequest, .saveCareLocationInfoResponse)
						q:$$$ISERR(sc)
						
						// 3 - save care Location information in PostgreSQL
						set saveCareLocationInfoRequest.target = "PostgreSQL"
						set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveCareLocationInfoRequest, .saveCareProviderInfoResponse)
						q:$$$ISERR(sc)
					}
					
					; check / create location
					; check if we already have this care site in IRIS
					; check if care site not exists in IRIS
					Set tSC=tRS.Prepare("SELECT TOP 1 care_site_id FROM care_site "_
										"WHERE location_id = '"_locationIRISId_"' "_
										"AND care_site_source_value = '"_careSiteId_"'")
											
					quit:$$$ISERR(tSC)
					
					set tSC=tRS.Execute() 
					quit:$$$ISERR(tSC)
						
					s careSiteIdIRIS = ""
					d tRS.%Next(.tSC)
					quit:$$$ISERR(tSC)
					
					set careSiteIdIRIS = tRS.GetDataByName("care_site_id")
					
					d tRS.Close()
						
					; if we do not have this care site in iris - create it
					if careSiteIdIRIS = "" {
						# dim saveCareSiteRequest As OMOP.Request.saveCareSiteInfoBO
						set saveCareSiteRequest = ##class(OMOP.Request.saveCareSiteInfoBO).%New()
						set saveCareSiteRequest.careSiteId = ..getNewId("careSite")
						set careSiteIdIRIS = saveCareSiteRequest.careSiteId
						set saveCareSiteRequest.careSiteName = $g(rawName)
						set saveCareSiteRequest.locationId = locationIRISId
						set saveCareSiteRequest.careSiteSourceValue = careSiteId
						set saveCareSiteRequest.type = "saveCareSite"
						
						
						// 3 - save care Location information in IRIS
						set saveCareSiteRequest.target = "IRIS"
						set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveCareSiteRequest, .saveCareSiteResponsequest)
						q:$$$ISERR(sc)
						
						// 3 - save care Location information in PostgreSQL
						set saveCareSiteRequest.target = "PostgreSQL"
						set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveCareSiteRequest, .saveCareSiteResponsequest)
						q:$$$ISERR(sc)
					}
					
					
					; now we have care site and care location
					; create care provider
					; we do not have this care provider in IRIS it was checked at the begining of this method
					Set tSC=tRS.Prepare("SELECT distinct p.ID, p.Code, p.Description, p.SDACodingStandard, p.NationalProviderID, p.DEANumber, p.Specialty, p.LastUpdated FROM  HSAA.CareProvider p "_
								"WHERE p.code='"_visitOccurence.attendingClinicianCode_"' "_
								"AND p.SDACodingStandard ='"_visitOccurence.attendingClinicianSDACodingStandard_"'")
					
					quit:$$$ISERR(tSC)
					
					set tSC=tRS.Execute() 
					quit:$$$ISERR(tSC)
						
					d tRS.%Next(.tSC)
					quit:$$$ISERR(tSC)
					
					; prepare care provider data
					#dim saveCareProviderInfoRequest As OMOP.Request.saveCareProviderInfoBO
					set saveCareProviderInfoRequest = ##class(OMOP.Request.saveCareProviderInfoBO).%New()
					
					set saveCareProviderInfoRequest.type = "saveCareProviderInfo"
					set saveCareProviderInfoRequest.providerId = ..getNewId("provider")
					set careProviderIdIRIS = saveCareProviderInfoRequest.providerId
					set saveCareProviderInfoRequest.providerName = tRS.GetDataByName("Description")
					set saveCareProviderInfoRequest.npi = tRS.GetDataByName("NationalProviderID")
					set saveCareProviderInfoRequest.dea = tRS.GetDataByName("DEANumber")
					set saveCareProviderInfoRequest.specialtyConceptId = ""	;..getLookUpTblValue("provider","specialty_concept_id",source.Specialty)
					set saveCareProviderInfoRequest.careSiteId = careSiteIdIRIS
					set saveCareProviderInfoRequest.yearOfBirth = ""
					set saveCareProviderInfoRequest.genderConceptId = 0
					set saveCareProviderInfoRequest.providerSourceValue = tRS.GetDataByName("Code")_"|"_tRS.GetDataByName("SDACodingStandard")_"|"_tRS.GetDataByName("LastUpdated")
					set saveCareProviderInfoRequest.specialtySourceValue = tRS.GetDataByName("Specialty")
					set saveCareProviderInfoRequest.specialtySourceConceptId = 0
					set saveCareProviderInfoRequest.genderSourceConceptId = 0

					set saveCareProviderInfoRequest.target = "IRIS"
					set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveCareProviderInfoRequest, .saveCareProviderInfoResponse)
					q:$$$ISERR(sc)		
					
					// 3 - save care provider information in PostgreSQL
					set saveCareProviderInfoRequest.target = "PostgreSQL"
					set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveCareProviderInfoRequest, .saveCareProviderInfoResponse)
					q:$$$ISERR(sc)
					
					d tRS.Close()
				}
 			} else {
	 			set careProviderIdIRIS = providerId	
 			}
 			
			



			; check if we already have this care site in IRIS
			// check provider id
			// FIND  AttendingClinician_Code | AttendingClinician_SDACodingStandard in provider_source_value field in OMOP.Provider table
			set tRS=##class(%ResultSet).%New()
			s careSiteIdIRIS = ""
			Set tSC=tRS.Prepare("SELECT care_site_id FROM care_site "_
								"WHERE care_site_source_value = ?")
			
			quit:$$$ISERR(tSC)
			set tSC=tRS.Execute(saveVisitOccurenceRequest.careSiteId) 
			quit:$$$ISERR(tSC)
			
			while tRS.%Next() {
				set careSiteIdIRIS = tRS.GetDataByName("care_site_id")
			}
			d tRS.Close()
			
			; if care_site_id was not found in iris
			; disabled
			if 0 && $g(careSiteIdIRIS)="" {
					; STEP 7 !!!
					; get info to create care site and location
					Set tSC=tRS.Prepare("select TOP 1 "_
						"cp.id, cp.code as BHSID, cp.description as Provider, cp.SDACodingStandard as SDACode, "_
						"cps.startdate, cps.enddate, cps.lastupdated, "_
						"s.id as SiteID, s.rawname as Site, "_
						"hcf.code as HCFID, hcf.description as HCFacility, hcf.rawname as HCFName "_
						"from hsaa.careprovider cp "_
							"inner join hsaa.careprovidersite cps "_
							"on cp.id = cps.careprovider "_
								"inner join (select careprovider, max(lastupdated) as lastupdated from hsaa.careprovidersite group by careprovider) cps_max "_
						  		"on cps.careprovider = cps_max.careprovider "_
						  		"and cps.lastupdated = cps_max.lastupdated "_
									"inner join hsaa.site s "_
						  			"on cps.site = s.id	 "_
										"inner join hsaa.healthcarefacility hcf "_
						  				"on s.healthcarefacility = hcf.id "_
										"where cp.code != cp.description and s.id="_saveVisitOccurenceRequest.careSiteId_" "_
										"order by BHSID, lastupdated desc")
				
					
					quit:$$$ISERR(tSC)
					set tSC=tRS.Execute() 
					quit:$$$ISERR(tSC)
					
					s careSiteId2 = ""
					While tRS.%Next() {
						; ???
						set careSiteId2 = tRS.GetDataByName("ID")
						set rawName = tRS.GetDataByName("Site")
					}
					
					d tRS.Close()
					
					if careSiteId2 '= ""{
						; save location
						; 1 check if we already have such location in IRIS
						
						set locationSourceValue = $e("s"_saveVisitOccurenceRequest.careSiteId_"|",1,50)
						set locationIRISId = ""
						
						Set tSC=tRS.Prepare("SELECT * FROM location "_
											"WHERE location_source_value = '"_locationSourceValue_"'")
						quit:$$$ISERR(tSC)
						set tSC=tRS.Execute() 
						quit:$$$ISERR(tSC)
						
						s careSiteId2 = ""
						
						While tRS.%Next() {
							; ???
							set locationIRISId = tRS.GetDataByName("location_id")
						}
						d tRS.Close()
						
						
						if locationIRISId=""{
							; create new location
							set saveCareLocationInfoRequest = ##class(OMOP.Request.saveCareLocationInfoBO).%New()
							set saveCareLocationInfoRequest.locationId = ..getNewId("location")
							set locationIRISId = saveCareLocationInfoRequest.locationId
							set saveCareLocationInfoRequest.locationSourceValue = locationSourceValue
							set saveCareLocationInfoRequest.type = "savePatientLocation"
							
							
							// 3 - save care Location information in IRIS
							set saveCareLocationInfoRequest.target = "IRIS"
							set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveCareLocationInfoRequest, .saveCareLocationInfoResponse)
							q:$$$ISERR(sc)
							
							// 3 - save care Location information in PostgreSQL
							set saveCareLocationInfoRequest.target = "PostgreSQL"
							set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveCareLocationInfoRequest, .saveCareProviderInfoResponse)
							q:$$$ISERR(sc)
							
							
						}

						
						; create care site
						; need to check if exists ???
						set saveCareSiteRequest = ##class(OMOP.Request.saveCareSiteInfoBO).%New()
						set saveCareSiteRequest.careSiteId = ..getNewId("careSite")
						set careSiteIdIRIS = saveCareSiteRequest.careSiteId
						set saveCareSiteRequest.careSiteName = $g(rawName)
						set saveCareSiteRequest.locationId = locationIRISId
						set saveCareSiteRequest.careSiteSourceValue = saveVisitOccurenceRequest.careSiteId
						set saveCareSiteRequest.type = "saveCareSite"
						
						
						// 3 - save care Location information in IRIS
						set saveCareSiteRequest.target = "IRIS"
						set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveCareSiteRequest, .saveCareSiteResponsequest)
						q:$$$ISERR(sc)
						
						// 3 - save care Location information in PostgreSQL
						set saveCareSiteRequest.target = "PostgreSQL"
						set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveCareSiteRequest, .saveCareSiteResponsequest)
						q:$$$ISERR(sc)
						
			
					}

			}
			
			
			set saveVisitOccurenceRequest.careSiteId = $s($g(careSiteIdIRIS)'="":careSiteIdIRIS,1:pRequest.careSiteId)		; $g(careSiteIdIRIS)
			set saveVisitOccurenceRequest.providerId = $s($g(careProviderIdIRIS)'="":careProviderIdIRIS,1:pRequest.providerId)	; $g(careProviderIdIRIS)	;	pRequest.providerId
			//set saveVisitOccurenceRequest.personId = pRequest.personId
			set saveVisitOccurenceRequest.visitOccurrenceId = saveVisitOccurenceRequest.visitOccurrenceId	;visitOccurence.id	;..getNewId("visitOccurence")
			
			set saveVisitOccurenceRequest.visitDetailId = ..getNewId("visitDetail")
			
			set pResponse.visitDetailId = saveVisitOccurenceRequest.visitDetailId
			set pResponse.visitOccurrenceId = saveVisitOccurenceRequest.visitOccurrenceId

			// visit occurrence
			// 1 - save data to IRIS
			set saveVisitOccurenceRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveVisitOccurenceRequest, .saveVisitOccurenceResponse)
			q:$$$ISERR(sc)
			
			// 3 - save care provider information in PostgreSQL
			set saveVisitOccurenceRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveVisitOccurenceRequest, .saveVisitOccurenceResponse)
			q:$$$ISERR(sc)
			
			// visit detail
			// 1 - save data to IRIS
			set saveVisitOccurenceRequest.type = "saveVisitDetail"
			set saveVisitOccurenceRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveVisitOccurenceRequest, .saveVisitOccurenceResponse)
			q:$$$ISERR(sc)
			
			// 3 - save care provider information in PostgreSQL
			set saveVisitOccurenceRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveVisitOccurenceRequest, .saveVisitOccurenceResponse)
			q:$$$ISERR(sc)

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
