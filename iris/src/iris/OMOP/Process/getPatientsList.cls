/// Process gets patient list for future processing
/// and store this list in database
Class OMOP.Process.getPatientsList Extends Ens.BusinessProcess [ ClassType = persistent ]
{

Method OnRequest(pRequest As Ens.Request, Output pResponse As Ens.Response) As %Status
{
	s sc = $$$OK
	try {
		
		if pRequest.%IsA(##class(Ens.Request).%ClassName(1)) {
 			s sc = ..getPatientsList(.pRequest,.pResponse)
		}

	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

Method getPatientsList(pRequest, pResponse)
{
	s sc = $$$OK
	try {
		; prepare requests to get data
		s sqlRequest = ##class(OMOP.Request.getPatientsList).%New()
		
		#dim sqlResponse as OMOP.Response.getPatientsList
		s sc = ..SendRequestSync("Operation.getPatientsList", sqlRequest, .sqlResponse)
		q:$$$ISERR(sc)
		
		// create/update patients list for future processing
		for patientsCounter = 1:1:sqlResponse.patientsList.Count() {
			s patientId = sqlResponse.patientsList.GetAt(patientsCounter)
   			if ##class(OMOP.Storage.PatientId).patientIdExists(patientId) {
	   			// do nothing or somehow update
	   			s patientCls = ##class(OMOP.Storage.PatientId).patientIdOpen(patientId)
	   			s patientCls.processed = 0
	   			s sc = patientCls.%Save()

   			} else {
	   			// create new record
	   			s patientCls = ##class(OMOP.Storage.PatientId).%New()
	   			s patientCls.pId = patientId
	   			s patientCls.processed = 0
	   			s sc = patientCls.%Save()
   			}
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
