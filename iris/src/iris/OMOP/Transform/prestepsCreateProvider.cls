/// datatransformation
/// for presteps
/// to transform data from Bay State to OMOP
Class OMOP.Transform.prestepsCreateProvider Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Proxy.prestepsGetProviderDataItem, target As OMOP.Request.saveCareProviderInfoBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveCareProviderInfoBO).%New()
		
		s target.type = "saveCareProviderInfo"
		
		s target.providerId = ""
		s target.providerName = source.Provider
		s target.npi = source.NationalProviderID
		s target.dea = source.DEANumber
		
		s target.specialtyConceptId = ..getLookUpTblValue("provider","specialty_concept_id",source.Specialty)
		
		
		s target.careSiteId = ""
		; find care site
		set tRS=##class(%ResultSet).%New()
		set tSC=tRS.Prepare("SELECT TOP 1 care_site_id FROM care_site WHERE care_site_source_value = ? ")
							
		quit:$$$ISERR(tSC)
		set tSC=tRS.Execute(source.SiteID)
		quit:$$$ISERR(tSC)
		
		do tRS.%Next(.tSC)
		quit:$$$ISERR(tSC)
		s target.careSiteId = tRS.GetDataByName("care_site_id")
		d tRS.Close()
		
		
		s target.careSiteId = ""
		s target.yearOfBirth = ""
		s target.genderConceptId = 0
		
		s target.providerSourceValue = source.BHSID_"|"_source.SDACode
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
