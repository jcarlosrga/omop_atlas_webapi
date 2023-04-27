/// 
/// 20211005 Denis Bulashev
/// Step 9 - Create person (patient)
/// 
Class OMOP.Process.сreatePerson Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createPersonBP, Output pResponse As OMOP.Response.createPersonBP) As %Status
{
	s sc = $$$OK
	try {

		s sc = pRequest.NewResponse(.pResponse)
		q:$$$ISERR(sc)

		// 1 - transform data for BO
		// s sc = ##class(OMOP.Transform.getPatientInfoBO).Transform()
		
		// 2 - get patient info from database
		#dim getPersonRequest As OMOP.Request.getPersonBP
		#dim getPersonResponse As OMOP.Response.getPersonBP
		set getPersonRequest = ##class(OMOP.Request.getPersonBP).%New()
		set getPersonRequest.patientId = pRequest.patinetId
		set sc = ..SendRequestSync("Operation.getPerson", getPersonRequest, .getPersonResponse)
		q:$$$ISERR(sc)

		
		// getn new person ID
		set personId = ..getNewId("person")
		set pResponse.personId = personId
		set getPersonResponse.id = pRequest.patinetId
		
		// 3 - data to IRIS
		// transform data from Operation.getCareProviderInfo
		#dim savePersonRequest As OMOP.Request.savePersonBO
		set sc = ##class(OMOP.Transform.getPersonBO).Transform(getPersonResponse, .savePersonRequest)
		q:$$$ISERR(sc)
		set savePersonRequest.personId = personId
		set savePersonRequest.locationId = pRequest.locationId
		set savePersonRequest.providerId = pRequest.providerId
		set savePersonRequest.careSiteId = pRequest.careSiteId
		
		set savePersonRequest.target = "IRIS"
		set sc = ..SendRequestSync("Operation.saveDataToIRIS", savePersonRequest, .savePersonResponse)
		q:$$$ISERR(sc)
		
		// 3 - save care provider information in PostgreSQL
		set savePersonRequest.target = "PostgreSQL"
		set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", savePersonRequest, .savePersonResponse)
		q:$$$ISERR(sc)
		
		/*
		// may be code below can be ommited
		// 2 - Get data
		set sqlRequest = ##class(OMOP.Request.getPatientLocationBO).%New()
		set sqlRequest.patientId = pRequest.patinetId
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
		*/

		
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
