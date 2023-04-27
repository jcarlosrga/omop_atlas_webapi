Class OMOP.Transform.savePatientLocationBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Response.getPatientLocationBO, target As OMOP.Request.savePatientLocationBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.savePatientLocationBO).%New()
		s target.type = "savePatientLocation"
				
		s target.locationId = ""
		s target.address1 = $e(source.addressStreet,1,50)
		s target.address2 = 0
		
		s tmp = source.addressCityCode
		if '(tmp?.50(1A,1".",1"-",1" ",1"/")) s tmp = ""
		s target.city = tmp
		
		s state = ..getLookUpTblValue("location","country",source.addressCountRyCode,"","concept_value")
		$$$TRACE(state_" | "_source.addressCountRyCode)
		
		if state = "united states" {
			s state = ..getLookUpTblValue("location","state",source.addressStateCode,"","concept_value")
		} else {
			s state = ""	
		}
		s target.state = state
		s target.zip = $e(source.addressZipCode,1,9)
		s target.county = ""
		s target.locationSourceValue = $e("p"_source.id_"|"_source.addressZipCode_","_source.addressStateCode_","_source.addressCityCode_","_source.addressStreet,1,50)
		
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

}
