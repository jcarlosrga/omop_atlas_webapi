/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.getCareProviderInfoBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Response.getCareProviderInfoBO, target As OMOP.Request.saveCareProviderInfoBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveCareProviderInfoBO).%New()
		
		s target.type = "saveCareProviderInfo"
		
		s target.providerId = ""
		s target.providerName = source.Description
		
		
		s target.npi = source.NationalProviderID
		s target.dea = source.DEANumber
		
		s target.specialtyConceptId = ..getLookUpTblValue("provider","specialty_concept_id",source.Specialty)
		s target.careSiteId = ""
		s target.yearOfBirth = ""
		s target.genderConceptId = 0
		
		s target.providerSourceValue = source.Code_"|"_source.SDACodingStandard_"|"_source.LastUpdated
		s target.specialtySourceValue = source.Specialty
		s target.specialtySourceConceptId = 0
		s target.genderSourceValue = ""
		s target.genderSourceConceptId = 0
		
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

}
