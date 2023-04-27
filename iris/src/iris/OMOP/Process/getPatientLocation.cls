/// 
/// 20211005 Denis Bulashev
/// Step 4 - Create Patient Location
/// 
Class OMOP.Process.getPatientLocation Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.getPatientLocationBP, Output pResponse As OMOP.Response.getPatientLocationBP) As %Status
{
	s sc = $$$OK
	try {
		s sc = pRequest.NewResponse(.pResponse)
		q:$$$ISERR(sc)
		
		// 1 - transform data for BO
		
		set sqlRequest = ##class(OMOP.Request.getPatientLocationBO).%New()
		set sqlRequest.patientId = pRequest.patientId
		
		// 2 - Get data
		s sc = ..SendRequestSync("Operation.getPatientLocation", sqlRequest, .sqlResponse)
		q:$$$ISERR(sc)
		
		// transform data
		# dim saveDataRequest As OMOP.Request.savePatientLocationBO
		s sc = ##class(OMOP.Transform.savePatientLocationBO).Transform(sqlResponse, .saveDataRequest)
		q:$$$ISERR(sc)
		
		
		// 2.1 check if we already have this location in IRIS
		s checkLocationInIrisRequest = ##class(OMOP.Request.checkLocationInIrisBO).%New()
		s checkLocationInIrisRequest.sourceValue = saveDataRequest.locationSourceValue
		# dim checkLocationInIrisResponse As OMOP.Response.checkLocationInIrisBO
		s sc = ..SendRequestSync("Operation.checkLocationInIris", checkLocationInIrisRequest, .checkLocationInIrisResponse )
		q:$$$ISERR(sc)
		
		if checkLocationInIrisResponse.locationExists = 0 {
			set saveDataRequest.target = "IRIS"
			set saveDataRequest.locationId = ..getNewId("location")
			
			// 1 - save data to IRIS
			s sc = ..SendRequestSync("Operation.saveDataToIRIS", saveDataRequest, .saveDataResponse)
			q:$$$ISERR(sc)
			
			// 2 - sava data to PostgeSQL
			set saveDataRequest.target = "PostgreSQL"
			s sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveDataRequest, .saveDataResponse)
			q:$$$ISERR(sc)
			
			s pResponse.locationId = saveDataRequest.locationId
		} else {
			
			s pResponse.locationId = checkLocationInIrisResponse.locationExists
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
