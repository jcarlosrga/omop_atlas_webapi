/// datatransformation
/// from get patient info response to get patient location request
Class OMOP.Transform.getPersonBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Response.getPersonBP, target As OMOP.Request.savePersonBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.savePersonBO).%New()
		
		s target.type = "savePerson"
		s target.personId = ""
		
		s genderConceptId = ..getLookUpTblValue("patient","gender_concept_id", source.rawGenderCode)
		i genderConceptId = "" s genderConceptId = "4214687"
		i genderConceptId = "4214687" {
			s genderConceptId = ..getLookUpTblValue("patient","gender_concept_id", source.genderCode)
			i genderConceptId = "" s genderConceptId = "4214687"
			i genderConceptId = "4214687" {
				s genderConceptId = ..getLookUpTblValue("patient","gender_concept_id", source.birthGenderCode)
				i genderConceptId = "" s genderConceptId = "4214687"
				i genderConceptId = "4214687" {
					// logError
				}
			}
		}
		s target.genderConceptId = genderConceptId
		
		s target.yearOfBirth = $e(source.birthTime,1,4)
		s target.monthOfBirth = $e(source.birthTime,6,7)
		s target.dayOfBirth = $e(source.birthTime,9,10)
		s target.birthDatetime = source.birthTime
		if source.birthTime = "" {
			; !!! logError
		}
		
		s raceConceptId = ..getLookUpTblValue("patient","race_concept_id", source.raceCode, source.raceDescription)
		
		s ^BUL1(1,$i(^BUL1)) = "patient"_","_"race_concept_id"_","_source.raceCode_","_source.raceDescription
		
		if raceConceptId = "" s raceConceptId = "4218674"
		i raceConceptId = "4218674" {
			// logError
		}
		s target.raceConceptId = raceConceptId
		
		s ethnicityConceptId = ..getLookUpTblValue("patient","ethnicity_concept_id", source.ethnicGroupCode, source.ethnicGroupDescription)
		if ethnicityConceptId = "" s ethnicityConceptId = "759814"
		i ethnicityConceptId = "759814" {
			// logError
		}
		s target.ethnicityConceptId = ethnicityConceptId
		
		s target.locationId = ""
		s target.providerId = ""
		s target.careSiteId = ""
		
		s target.personSourceValue = $e(source.id_"|"_source.createdOn	,1,50)
		
		s genderSourceValue = ..getLookUpTblValue("patient","gender_concept_id", source.rawGenderCode)
		if genderSourceValue = "4214687" {
			s genderSourceValue = ..getLookUpTblValue("patient","gender_concept_id", source.genderCode)
			if genderSourceValue = "4214687" {
				s genderSourceValue = ..getLookUpTblValue("patient","gender_concept_id", source.birthGenderCode)
				i genderSourceValue = "4214687" {
					// logError
				} else {
					s genderSourceValue = source.birthGenderCode	
				}
			} else {
				s genderSourceValue = source.genderCode
			}
		} else {
			 s genderSourceValue = source.rawGenderCode
		}
		s target.genderSourceValue = genderSourceValue
		
		
		s genderSourceConceptId = ..getLookUpTblValue("patient","gender_concept_id", source.rawGenderCode)
		if genderSourceConceptId = "4214687" {
			s genderSourceConceptId = ..getLookUpTblValue("patient","gender_concept_id", source.genderCode)
			if genderSourceConceptId = "4214687" {
				s genderSourceConceptId = ..getLookUpTblValue("patient","gender_concept_id", source.birthGenderCode)
				i genderSourceConceptId = "4214687" {
					// logError
				}
			}
		}
		s target.genderSourceConceptId = genderSourceConceptId
		
		s target.raceSourceValue = source.raceDescription
		s target.raceSourceConceptId = 0
		s target.ethnicitySourceValue = source.ethnicGroupDescription
		s target.ethnicitySourceConceptId = 0
		
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

}
