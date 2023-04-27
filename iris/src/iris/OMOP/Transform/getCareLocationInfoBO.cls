/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.getCareLocationInfoBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Response.getCareSiteInfoBO, target As OMOP.Request.saveCareLocationInfoBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveCareLocationInfoBO).%New()
		
		s target.type = "savePatientLocation"		// same table and dataset
		
		s target.locationId = ""
		s target.address1 = $e(source.AddressStreet,1,50)
		s target.address2 = ""
		
		s tmp = source.AddressCityCode
		if '(tmp?.50(1A,1".",1"-",1" ",1"/")) s tmp = ""
		s target.city = tmp
		
		s state = ..getLookUpTblValue("location","country",source.AddressCountryCode,"","concept_value")
		if state = "united states" {
			s state = ..getLookUpTblValue("location","state",source.AddressStateCode,"","concept_value")
		} else {
			s state = ""	
		}
		s target.state = state
		
		s target.zip = $e(source.AddressZipCode,1,9)
		s target.county = ""
		s target.locationSourceValue = $e("PSP"_source.ID_"|"_source.AddressZipCode_","_source.AddressStateCode_","_source.AddressCityCode_","_source.AddressStreet,1,50)

		
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

}
