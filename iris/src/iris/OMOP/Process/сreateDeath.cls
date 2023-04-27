/// 
/// 20211005 Denis Bulashev
/// Step 10 - Create death
/// 
Class OMOP.Process.сreateDeath Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createDeathBP, Output pResponse As OMOP.Response.createDeathBP) As %Status
{
	s sc = $$$OK
	try {

		s sc = pRequest.NewResponse(.pResponse)
		q:$$$ISERR(sc)

		// 2 - get death info from database
		#dim getDeathRequest As OMOP.Request.getDeathBO
		#dim getDeathResponse As OMOP.Response.getDeathBO
		set getDeathRequest = ##class(OMOP.Request.getDeathBO).%New()
		set getDeathRequest.patientId = pRequest.patientId
		set sc = ..SendRequestSync("Operation.getDeath", getDeathRequest, .getDeathResponse)
		q:$$$ISERR(sc)
		
		// there is no info about death - quit
		quit:getDeathResponse.deceased=""
		
		// 3 - data to IRIS
		// transform data from Operation.getCareProviderInfo
		#dim saveDeathRequest As OMOP.Request.saveDeathBO
		set sc = ##class(OMOP.Transform.getDeathBO).Transform(getDeathResponse, .saveDeathRequest)
		q:$$$ISERR(sc)
		
		s saveDeathRequest.personId = pRequest.personId
		set saveDeathRequest.target = "IRIS"
		set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveDeathRequest, .saveDeathResponse)
		q:$$$ISERR(sc)
		
		// 3 - save care provider information in PostgreSQL
		set saveDeathRequest.target = "PostgreSQL"
		set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveDeathRequest, .saveDeathResponse)
		q:$$$ISERR(sc)		
		
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
