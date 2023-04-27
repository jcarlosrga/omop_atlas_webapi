/// 
/// 202110008 Denis Bulashev
/// Step 8(5???) - Get Care Provider
/// 
Class OMOP.Process.getCareProvider Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.getPatientLocationBP, Output pResponse As OMOP.Response.getPatientLocationBP) As %Status
{
	s sc = $$$OK
	try {
		s sc = pRequest.NewResponse(.pResponse)
		q:$$$ISERR(sc)
		
		
		// 1 - transform data for BO
		// s sc = ##class(OMOP.Transform.getPatientInfoBO).Transform()
		set sqlRequest = ##class(OMOP.Request.getPatientLocationBO).%New()
		set sqlRequest.patientId = pRequest.patientId
		
		// 2 - Get data
		s sc = ..SendRequestSync("Operation.getPatientLocation", sqlRequest, .sqlResponse)
		
		// transform data
		# dim saveDataRequest As OMOP.Request.savePatientLocationBO
		s sc = ##class(OMOP.Transform.savePatientLocationBO).Transform(sqlResponse, .saveDataRequest)
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
