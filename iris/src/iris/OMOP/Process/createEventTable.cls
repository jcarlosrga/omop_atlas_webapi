/// 
/// 20211025 Denis Bulashev
/// Step 12 - Create event table (inner table)
/// 
Class OMOP.Process.createEventTable Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createEventTable, Output pResponse As OMOP.Response.createEventTable) As %Status
{
	s sc = $$$OK
	try {
		// 2 - Get data
		#dim getEventDataRequest As OMOP.Request.getEventDataBO 
		#dim getEventDataResponse As OMOP.Response.getEventDataBO
		set getEventDataRequest = ##class(OMOP.Request.getEventDataBO).%New()
		set getEventDataRequest.patientId = pRequest.patientId
		set sc = ..SendRequestSync("Operation.getEventData", getEventDataRequest, .getEventDataResponse, 60)
		q:$$$ISERR(sc)
						
						
		// save elements to IRIS
		$$$TRACE("Person_id "_pRequest.personId_", records count "_getEventDataResponse.events.Count())
		for eventNum = 1:1:getEventDataResponse.events.Count() {
			set eventItem = getEventDataResponse.events.GetAt(eventNum)
			
			// transform data
			# dim saveEventRequest As OMOP.Request.saveEventBO
			set saveEventRequest = ##class(OMOP.Request.saveEventBO).%New()
			s sc = ##class(OMOP.Transform.saveEvent).Transform(eventItem, .saveEventRequest)
			q:$$$ISERR(sc)
			set saveEventRequest.personId = pRequest.personId
			
			
			// 1 - save data to IRIS
			set saveEventRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveEventRequest, .saveEventResponse)
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
