/// datatransformation
/// 
Class OMOP.Transform.getDeathBO Extends OMOP.Common.DataTransform
{

ClassMethod Transform(source As OMOP.Response.getDeathBO, target As OMOP.Request.saveDeathBO) As %Status
{

	s sc = $$$OK
	try {
		s target = ##class(OMOP.Request.saveDeathBO).%New()
		
		s target.type = "saveDeath"
		s target.personId = ""
		s target.deathDate = $e(source.deathTime,1,10)
		s target.deathDatetime = source.deathTime
		s target.deathTypeConceptId = 32827
		s target.causeConceptId = 0
		s target.causeSourceValue = ""
		s target.causeSourceConceptId = 0

	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

}
