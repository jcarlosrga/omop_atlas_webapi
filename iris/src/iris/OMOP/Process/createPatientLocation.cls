/// 
/// 20211005 Denis Bulashev
/// Step 4 - Create Patient Location
/// 
Class OMOP.Process.createPatientLocation Extends Ens.BusinessProcess [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.getPatientInfoBP, Output pResponse As OMOP.Response.getPatientInfoBP) As %Status
{
	s sc = $$$OK
	try {
		// 1 - transform data
		s sc = ##class(OMOP.Transform.getPatientInfoBP).Transform()

		s sqlRequest = ##class(OMOP.Request.updatePatientsList).%New()
		s sqlResponse = sqlRequest.NewResponse()
		
		s sqlRequest.SQL = 
				"SELECT DISTINCT e.Patient "_
				"FROM HSAA.Patient p "_
    			"JOIN "_
       				"(	SELECT DISTINCT Patient FROM HSAA.Encounter "_
         				"WHERE TagFacility='Baystate') e "_
    					"ON p.id=e.patient "_
						"WHERE (Gender_Code IS NOT NULL or Gender_Description IS NOT NULL "_
						"or "_
						"RawGender_Code  IS NOT NULL or RawGender_Description IS NOT NULL "_
						"or "_
						"BirthGender_Code IS NOT NULL or BirthGender_Description IS NOT NULL "_
					") "_
					"AND "_
					"p.BirthTIme IS NOT NULL AND p.BirthTIme>'1921-01-01' "_
					"AND "_
					"p.Race_Code IS NOT NULL AND p.EthnicGroup_Code IS NOT NULL AND e.Patient < 100" 
					
					
					
		s sc = ..SendRequestSync("Operation.updatePatientsList", sqlRequest, .sqlResponse)
		q:$$$ISERR(sc)

		$$$TRACE(sqlResponse.patientsList.%ToJSON())
		
		// create/update patients list for future processing
		// 1 check if we already have this patioent in list
   		set iterator=sqlResponse."patientsList"."id".%GetIterator()
   		while iterator.%GetNext(.key,.val) { 
   			// check if record exists
   			if ##class(OMOP.Storage.PatientId).patientIdExists(val) {
	   			// s patientCls = ##class(OMOP.Storage.PatientId).IndexikeyOpen(val)
   			} else {
	   			// create new record
	   			s patientCls = ##class(OMOP.Storage.PatientId).%New()
	   			s patientCls.pId = val
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
