/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.saveCareSiteBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Request.saveCareLocationInfoBO, target As OMOP.Request.saveCareSiteInfoBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveCareSiteInfoBO).%New()
		
		s target.type = "saveCareSite"		// same table and dataset
		
		s target.careSiteId = ""
		s target.careSiteName = ""
		s target.placeOfServiceConceptId = 0
		s target.locationId = source.locationId
		s target.careSiteSourceValue = ""	
		s target.placeOfServiceConceptId = ""
		
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

}
