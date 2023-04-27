/// 
/// 20211005 Denis Bulashev
/// Step 0 load care site, provider, location
/// 
Class OMOP.Process.doPresteps Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{
	s sc = $$$OK
	try {

		s pResponse = ##class(Ens.Response).%New()
		q:$$$ISERR(sc)
		
		// 2 - get site and location info
		#dim getSiteAndLocationDataRequest As Ens.Request
		#dim getSiteAndLocationDataResponse As OMOP.Response.prestepsGetLocationAndSiteDataBP
		set getSiteAndLocationDataRequest = ##class(Ens.Request).%New()
		set getSiteAndLocationDataResponse = ##class(OMOP.Response.prestepsGetLocationAndSiteDataBP).%New()
		set sc = ..SendRequestSync("Operation.prestepsGetLocationAndSiteData", getSiteAndLocationDataRequest, .getSiteAndLocationDataResponse)
		q:$$$ISERR(sc)
		
		set tRS=##class(%ResultSet).%New()
		
		#dim item As OMOP.Proxy.prestepsGetLocationAndSiteDataItem
		
		$$$TRACE("Creating care_site and location tables")
		
		set totalItems = 0
		set existsItems = 0
		set newItems = 0
		
		for itemNum = 1:1:getSiteAndLocationDataResponse.items.Count(){
			set item = getSiteAndLocationDataResponse.items.GetAt(itemNum)
			
			set totalItems = totalItems + 1
			
			; first create location
			; then care site			
			
			; check if we already have this location in OMOP
			
			set locationSourceValue = $e("s"_item.ID_"|",1,50)
			
			set tSC=tRS.Prepare("SELECT TOP 1 location_id FROM location "_
								"WHERE location_source_value LIKE '"_locationSourceValue_"%'")
								
			quit:$$$ISERR(tSC)
			set tSC=tRS.Execute() 
			quit:$$$ISERR(tSC)
			
			set locationIRISId = ""
			do tRS.%Next(.tSC)
			quit:$$$ISERR(tSC)
				
			set locationIRISId = tRS.GetDataByName("location_id")
			
			; we do not have this location in IRIS - create it
			if locationIRISId = "" {
					set newItems = newItems + 1
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
			} else {
				set existsItems = existsItems + 1	
			}
			d tRS.Close()
			
			
			
			
			; check if we already have this care site in OMOP
			set tSC=tRS.Prepare("SELECT TOP 1 care_site_id FROM care_site "_
								"WHERE care_site_source_value = ? ")
								
			quit:$$$ISERR(tSC)
			set tSC=tRS.Execute(item.ID)
			quit:$$$ISERR(tSC)
			
			set locationIRISId = ""
			do tRS.%Next(.tSC)
			quit:$$$ISERR(tSC)
			
			
			set careSiteIRISId = tRS.GetDataByName("care_site_id")
			
			if careSiteIRISId = "" {
				; create Care Site
				# dim saveCareSiteRequest As OMOP.Request.saveCareSiteInfoBO
				set saveCareSiteRequest = ##class(OMOP.Request.saveCareSiteInfoBO).%New()
				set saveCareSiteRequest.careSiteId = ..getNewId("careSite")
				set careSiteIdIRIS = saveCareSiteRequest.careSiteId
				set saveCareSiteRequest.careSiteName = item.RawName
				set saveCareSiteRequest.locationId = locationIRISId
				set saveCareSiteRequest.careSiteSourceValue = item.ID
				set saveCareSiteRequest.type = "saveCareSite"
				
				
				// 3 - save care Location information in IRIS
				set saveCareSiteRequest.target = "IRIS"
				set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveCareSiteRequest, .saveCareSiteResponsequest)
				q:$$$ISERR(sc)
				
				// 3 - save care Location information in PostgreSQL
				set saveCareSiteRequest.target = "PostgreSQL"
				set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveCareSiteRequest, .saveCareSiteResponsequest)
				q:$$$ISERR(sc)
			} else {
				
			}
			
			d tRS.Close()
		}
		
		
		
		$$$TRACE("Care_site and location tables were created")
		$$$TRACE("Total items "_totalItems)
		$$$TRACE("Exists items "_existsItems)
		$$$TRACE("New items "_newItems)
		


		
		
		$$$TRACE("Creating care_provider table")
		
		set totalItems = 0
		set existsItems = 0
		set newItems = 0

		#dim providerItem As OMOP.Proxy.prestepsGetProviderDataItem
		
		#dim getProviderDataRequest As Ens.Request
		#dim getProviderDataResponse As OMOP.Response.prestepsGetProviderDataBP
		set getProviderDataRequest = ##class(Ens.Request).%New()
		set getProviderDataResponse = ##class(OMOP.Response.prestepsGetProviderDataBP).%New()
		set sc = ..SendRequestSync("Operation.prestepsGetProviderData", getProviderDataRequest, .getProviderDataResponse)
		q:$$$ISERR(sc)
		
		
		set BHSID = ""
		for itemNum = 1:1:getProviderDataResponse.items.Count(){
			set providerItem = getProviderDataResponse.items.GetAt(itemNum)
			
			; import only the first record from table
			continue:BHSID=providerItem.BHSID
			set BHSID=providerItem.BHSID
			
			
			set totalItems = totalItems + 1
			
			; check if provider exists in IRIS
			
			set providerSourceValue = providerItem.BHSID_"|"_providerItem.SDACode
			
			set tSC=tRS.Prepare("SELECT provider_id FROM provider WHERE provider_source_value =  ? ")
			quit:$$$ISERR(tSC)
			
			set tSC=tRS.Execute(providerSourceValue)
			quit:$$$ISERR(tSC)
			
			set providerSourceValue = ""
			do tRS.%Next(.tSC)
			quit:$$$ISERR(tSC)
			
			set providerSourceValue = tRS.GetDataByName("provider_id")
			
			
			if providerSourceValue = "" {
				set newItems = newItems + 1
				
				#dim saveCareProviderInfoRequest As OMOP.Request.saveCareProviderInfoBO
				set sc = ##class(OMOP.Transform.prestepsCreateProvider).Transform(providerItem, .saveCareProviderInfoRequest)
				q:$$$ISERR(sc)
				set saveCareProviderInfoRequest.providerId = ..getNewId("provider")
				
				
				set saveCareProviderInfoRequest.target = "IRIS"
				set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveCareProviderInfoRequest, .saveCareProviderInfoResponse)
				q:$$$ISERR(sc)		
				
				// 3 - save care provider information in PostgreSQL
				set saveCareProviderInfoRequest.target = "PostgreSQL"
				set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveCareProviderInfoRequest, .saveCareProviderInfoResponse)
				q:$$$ISERR(sc)
				
				
			} else {
				set existsItems = existsItems + 1
			}
			
			d tRS.Close()
		}
		
		$$$TRACE("Provider table was created")
		$$$TRACE("Total items "_totalItems)
		$$$TRACE("Exists items "_existsItems)
		$$$TRACE("New items "_newItems)

		
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
