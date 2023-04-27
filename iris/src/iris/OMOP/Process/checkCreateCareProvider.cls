/// 
/// 20211005 Denis Bulashev
/// Step 8 - Create / check provider
/// 
Class OMOP.Process.checkCreateCareProvider Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createCheckCareProviderBP, Output pResponse As OMOP.Response.createCheckCareProviderBP) As %Status
{
	s sc = $$$OK
	try {
		s sc = pRequest.NewResponse(.pResponse)
		q:$$$ISERR(sc)
		
		
		// 1 - transform data for BO
		
		// 2 - get care provider date from database
		#dim getCareProviderInfoRequest As OMOP.Request.getCareProviderInfoBO
		#dim getCareProviderInfoResponse As OMOP.Response.getCareProviderInfoBO
		set getCareProviderInfoRequest = ##class(OMOP.Request.getCareProviderInfoBO).%New()
		set getCareProviderInfoRequest.careProviderId = pRequest.careProviderId
		set sc = ..SendRequestSync("Operation.getCareProviderInfo", getCareProviderInfoRequest, .getCareProviderInfoResponse)
		q:$$$ISERR(sc)
		
		
		q:(getCareProviderInfoResponse.Description = "") ; !!!
		
		// transform data from Operation.getCareProviderInfo
		#dim saveCareProviderInfoRequest As OMOP.Request.saveCareProviderInfoBO
		set sc = ##class(OMOP.Transform.getCareProviderInfoBO).Transform(getCareProviderInfoResponse, .saveCareProviderInfoRequest)
		q:$$$ISERR(sc)
		
		
		
		// check if we already have this care provider in IRIS
		s checkCareProviderInIrisRequest = ##class(OMOP.Request.checkCareProviderInIrisBO).%New()
		s checkCareProviderInIrisRequest.providerSourceValue = saveCareProviderInfoRequest.providerSourceValue
		#dim checkCareProviderInIrisResponse As OMOP.Response.checkCareProviderInIrisBO
		
		set sc = ..SendRequestSync("Operation.checkCareProviderInIris", checkCareProviderInIrisRequest, .checkCareProviderInIrisResponse)
		q:$$$ISERR(sc)
		
		if checkCareProviderInIrisResponse.careProviderId =0 {
			
			// 3 - save care provider information in IRIS
			set careProviderId = ..getNewId("provider")
			set pResponse.providerId = careProviderId
		
			q:(saveCareProviderInfoRequest.providerSourceValue = "||") ; !!!
			
			// overwrite careSiteId with value from IRIS
			set saveCareProviderInfoRequest.careSiteId = pRequest.careSiteIdIRIS
			
			set saveCareProviderInfoRequest.providerId = careProviderId
			set saveCareProviderInfoRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveCareProviderInfoRequest, .saveCareProviderInfoResponse)
			q:$$$ISERR(sc)		
			
			// 3 - save care provider information in PostgreSQL
			set saveCareProviderInfoRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveCareProviderInfoRequest, .saveCareProviderInfoResponse)
			q:$$$ISERR(sc)
		
		} else {
			s pResponse.providerId = checkCareProviderInIrisResponse.careProviderId
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
