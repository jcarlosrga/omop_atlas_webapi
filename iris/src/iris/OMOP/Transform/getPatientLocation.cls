/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.getPatientLocation Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Response.getPatientInfoBO, target As OMOP.Request.getPatientLocationBP) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.getPatientLocationBP).%New()
		
		s target.patientId = source.id
		
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

}
