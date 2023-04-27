/// 
/// 20211108 Denis Bulashev
/// Step 7 - Create / check site + location
/// 
Class OMOP.Process.checkCreateCareSite Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createCheckCareSiteBP, Output pResponse As OMOP.Response.createCheckCareSiteBP) As %Status
{
	s sc = $$$OK
	try {
		s sc = pRequest.NewResponse(.pResponse)
		q:$$$ISERR(sc)
		
		// 1 - transform data for BO

		
		// 2 - get care site data from database
		#dim getCareSiteInfoRequest As OMOP.Request.getCareSiteInfoBO
		#dim getCareSiteInfoResponse As OMOP.Response.getCareSiteInfoBO
		set getCareSiteInfoRequest = ##class(OMOP.Request.getCareSiteInfoBO).%New()
		set getCareSiteInfoRequest.careProviderId = pRequest.careProviderId
		set sc = ..SendRequestSync("Operation.getCareSiteInfo", getCareSiteInfoRequest, .getCareSiteInfoResponse)
		q:$$$ISERR(sc)
			

		// transform data from Operation.getCareLocationInfo
		#dim saveCareLocationInfoRequest As OMOP.Request.saveCareLocationInfoBO
		set getCareSiteInfoResponse.src = pRequest.source
		set sc = ##class(OMOP.Transform.getCareLocationInfoBO).Transform(getCareSiteInfoResponse, .saveCareLocationInfoRequest)
		q:$$$ISERR(sc)
		
		
		// check if we already have this location if OMOP database
		#dim checkCareSiteLocationResponse As OMOP.Response.checkCareLocationInfoBO
		set sc = ..SendRequestSync("Operation.checkCareSiteLocationInfoInIRIS", saveCareLocationInfoRequest, .checkCareSiteLocationResponse)
		set locationId = checkCareSiteLocationResponse.locationId
		if locationId = "" {
			set locationId = ..getNewId("location")
			set saveCareLocationInfoRequest.locationId = locationId

			// 3 - save care Location information in IRIS
			set saveCareLocationInfoRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveCareLocationInfoRequest, .saveCareLocationInfoResponse)
			q:$$$ISERR(sc)
			
			// 3 - save care Location information in PostgreSQL
			set saveCareLocationInfoRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveCareLocationInfoRequest, .saveCareProviderInfoResponse)
			q:$$$ISERR(sc)
		}
		
		
		// check if we already have this care_site in OMOP database
		s checkCareSiteInIrisRequest = ##class(OMOP.Request.checkCareSiteInIrisBO).%New()
		s checkCareSiteInIrisRequest.sourceValue = pRequest.careProviderId	; !!!!
		# dim checkCareSiteInIrisResponse AS OMOP.Response.checkCareSiteInIrisBO
		set sc = ..SendRequestSync("Operation.checkCareSiteInIRIS", checkCareSiteInIrisRequest, .checkCareSiteInIrisResponse)
		q:$$$ISERR(sc)
		
		if checkCareSiteInIrisResponse.careSiteId = 0 {
			// create care site
			# dim saveCareSiteRequest As OMOP.Request.saveCareSiteInfoBO
			set sc = ##class(OMOP.Transform.saveCareSiteBO).Transform(saveCareLocationInfoRequest, .saveCareSiteRequest)
			set saveCareSiteRequest.careSiteSourceValue = pRequest.careProviderId ; !!!!
			set saveCareSiteRequest.careSiteId = ..getNewId("careSite")
			set saveCareSiteRequest.locationId = saveCareLocationInfoRequest.locationId
			
			// 3 - save care Location information in IRIS
			set saveCareSiteRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveCareSiteRequest, .saveCareSiteResponsequest)
			q:$$$ISERR(sc)
			
			// 3 - save care Location information in PostgreSQL
			set saveCareSiteRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveCareSiteRequest, .saveCareSiteResponsequest)
			q:$$$ISERR(sc)
			
			set pResponse.careSiteId = saveCareSiteRequest.careSiteId
		
		} else {
			set pResponse.careSiteId = checkCareSiteInIrisResponse.careSiteId
			
		}
		
		
		set pResponse.careLocationId = locationId
		
		
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
