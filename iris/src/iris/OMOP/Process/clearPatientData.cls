/// 
/// 20220414 Denis Bulashev
/// Clear stored patient data from PostgreSQL and IRIS databases
/// 
Class OMOP.Process.clearPatientData Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.clearPatientDataBP, Output pResponse As Ens.Response) As %Status
{
	s sc = $$$OK
	try {
		
		; ---PostgreSQL
		
		#dim getPersonIdFromPostgreSQLRequest As OMOP.Request.getPersonIdFromPostgreSQLBO
		#dim getPersonIdFromPostgreSQLResponse As OMOP.Response.getPersonIdFromPostgreSQLBO
		set getPersonIdFromPostgreSQLRequest = ##class(OMOP.Request.getPersonIdFromPostgreSQLBO).%New()
		set getPersonIdFromPostgreSQLRequest.personId = pRequest.patientId
		set sc = ..SendRequestSync("Operation.getPersonIdFromPostgreSQL", getPersonIdFromPostgreSQLRequest, .getPersonIdFromPostgreSQLResponse)
		
		q:$$$ISERR(sc)
		
		; process all records from list above (in case of duplicates) 
		; OMOP.Operation.clearPersonDataFromPostgreSQL
		#dim clearPersonDataFromPostgreSQLRequest As OMOP.Request.clearPersonDataFromPostgreSQLBO
		#dim clearPersonDataFromPostgreSQLResponse As OMOP.Response.clearPersonDataFromPostgreSQLBO
		
		for personNum = 1:1:getPersonIdFromPostgreSQLResponse.personId.Count(){
			set personId = getPersonIdFromPostgreSQLResponse.personId.GetAt(personNum)
			set clearPersonDataFromPostgreSQLRequest = ##class(OMOP.Request.clearPersonDataFromPostgreSQLBO).%New()
			set clearPersonDataFromPostgreSQLRequest.personId = personId
			
			set sc = ..SendRequestSync("Operation.clearPersonDataFromPostgreSQL", clearPersonDataFromPostgreSQLRequest, .clearPersonDataFromPostgreSQLResponse)
		}
		
		
		
		; --- IRIS
		
		s pId = pRequest.patientId
		q:pId=""
		
		// get personID and clean person table
		set tRS = ##class(%ResultSet).%New()
		set SQL = "SELECT person_id FROM person WHERE person_source_value LIKE '"_pId_"|%'" 
		set sc = tRS.Prepare(SQL)
		q:$$$ISERR(sc)
		
		set sc = tRS.Execute()
		q:$$$ISERR(sc)

		while (tRS.Next(.sc)) {
			q:$$$ISERR(sc)
			
			s personID = tRS.Data("person_id")
			continue:personID=""
			
			; delete records from other tables
			set tRS2 = ##class(%ResultSet).%New()
			set SQL2 = "DELETE FROM ? WHERE person_id = ?"
			set sc = tRS2.Prepare(SQL2)
			q:$$$ISERR(sc)

			for tblName = "visit_occurrence", "visit_detail", "specimen", "procedure_occurrence", "payer_plan_period", "observation_period", "observation", "note", "measurement", "drug_exposure", "device_exposure", "death", 
				"cost", "condition_occurrence", "condition_era" {
				
				$$$TRACE(tblName)
				
				set sc = tRS2.Execute(tblName, personID)
				q:$$$ISERR(sc)
			}
			d tRS2.Close()
			
			; eventTable -> personId
			set tRS2 = ##class(%ResultSet).%New()
			set SQL2 = "DELETE FROM eventTable WHERE personId = "_personID
			set sc = tRS2.Prepare(SQL2)
			q:$$$ISERR(sc)
			set sc = tRS2.Execute()
			q:$$$ISERR(sc)
			d tRS2.Close()
		}
		d tRS.Close()

		set SQL = "DELETE FROM person WHERE person_source_value LIKE '"_pId_"|%'" 
		set sc = tRS.Prepare(SQL)
		q:$$$ISERR(sc)
		set sc = tRS.Execute()
		q:$$$ISERR(sc)
		d tRS.Close()
		
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

