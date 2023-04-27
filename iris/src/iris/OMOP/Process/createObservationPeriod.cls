/// 20221202 Create records for observation periods in database
Class OMOP.Process.createObservationPeriod Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createObservationPeriod, Output pResponse As Ens.Response) As %Status
{
	s sc = $$$OK
	try {    
        set pResponse = ##class(Ens.Response).%New()
        // work locally, no need to send a request to source system
        set personId = pRequest.personId
        
        set tRS=##class(%ResultSet).%New()

        ; 1 - remove old data for this patient
        set sc=tRS.Prepare("DELETE FROM tmp_observation_period WHERE person_id = ?")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()


        ; 2 - collect data from patient
        set sc=tRS.Prepare("INSERT INTO SQLUser.tmp_observation_period "_
                    "SELECT "_
                        "person_id, "_
                        "MIN(condition_start_date) AS start_date, "_
                        "MAX(COALESCE(condition_end_date, condition_start_date)) AS end_date, "_
                        "'condition_occurrence' As source "_
                    "FROM "_
                        "SQLUser.condition_occurrence "_
                    "WHERE "_
                        "person_id = ? ")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()

        set sc=tRS.Prepare("INSERT INTO SQLUser.tmp_observation_period "_
                    "SELECT "_
                        "person_id, "_
                        "MIN(device_exposure_start_date) AS start_date, "_
                        "MAX(COALESCE(device_exposure_end_date, device_exposure_start_date)) AS end_date, "_
                        "'device_exposure' As source "_
                    "FROM "_
                        "SQLUser.device_exposure "_
                    "WHERE "_
                        "person_id = ? ")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()

        set sc=tRS.Prepare("INSERT INTO SQLUser.tmp_observation_period "_
                    "SELECT "_
                        "person_id, "_
                        "MIN(drug_exposure_start_date) AS start_date, "_
                        "MAX(COALESCE(drug_exposure_end_date, drug_exposure_start_date)) AS end_date, "_
                        "'drug_exposure' As source "_
                    "FROM "_
                        "SQLUser.drug_exposure "_
                    "WHERE "_
                        "person_id = ? ")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()

        set sc=tRS.Prepare("INSERT INTO SQLUser.tmp_observation_period "_
                    "SELECT "_
                        "person_id, "_
                        "MIN(measurement_date) AS start_date, "_
                        "MAX(measurement_date) AS end_date, "_
                        "'measurement' As source "_
                    "FROM "_
                        "SQLUser.measurement "_
                    "WHERE "_
                        "person_id = ? ")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()

        set sc=tRS.Prepare("INSERT INTO SQLUser.tmp_observation_period "_
                    "SELECT "_
                        "person_id, "_
                        "MIN(observation_date) AS start_date, "_
                        "MAX(observation_date) AS end_date, "_
                        "'observation' As source "_
                    "FROM "_
                        "SQLUser.observation "_
                    "WHERE "_
                        "person_id = ? ")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()

        set sc=tRS.Prepare("INSERT INTO SQLUser.tmp_observation_period "_
                    "SELECT "_
                        "person_id, "_
                        "MIN(procedure_date) AS start_date, "_
                        "MAX(procedure_date) AS end_date, "_
                        "'procedure_occurrence' As source "_
                    "FROM "_
                        "SQLUser.procedure_occurrence "_
                    "WHERE "_
                        "person_id = ? ")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()

        set sc=tRS.Prepare("INSERT INTO SQLUser.tmp_observation_period "_
                    "SELECT "_
                        "person_id, "_
                        "MIN(specimen_date) AS start_date, "_
                        "MAX(specimen_date) AS end_date, "_
                        "'specimen' As source "_
                    "FROM "_
                        "SQLUser.specimen "_
                    "WHERE "_
                        "person_id = ? ")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()

        set sc=tRS.Prepare("INSERT INTO SQLUser.tmp_observation_period "_
                    "SELECT "_
                        "person_id, "_
                        "MIN(visit_start_date) AS start_date, "_
                        "MAX(COALESCE(visit_end_date, visit_start_date)) AS end_date, "_
                        "'visit_occurrence' As source "_
                    "FROM "_
                        "SQLUser.visit_occurrence "_
                    "WHERE "_
                        "person_id = ? ")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()

        set sc=tRS.Prepare("INSERT INTO SQLUser.tmp_observation_period "_
                    "SELECT "_
                        "person_id, "_
                        "death_date AS start_date, "_
                        "death_date AS end_date, "_
                        "'visit_occurrence' As death "_
                    "FROM "_
                        "SQLUser.death "_
                    "WHERE "_
                        "person_id = ? ")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()

        ; 3 - get data for saving
        set sc=tRS.Prepare("SELECT "_
                        "person_id, "_
                        "MIN(start_date) AS start_date, "_
                        "MAX(end_date) AS end_date "_
                    "FROM "_
                        "SQLUser.tmp_observation_period "_
                    "WHERE "_
                        "person_id = ? ")
        quit:$$$ISERR(sc)
        set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)

        do tRS.Next()
        set startDate = tRS.Data("start_date")
        set endDate = tRS.Data("end_date")
        do tRS.Close()


        ; 4 - remove our data for this patient
        set sc=tRS.Prepare("DELETE FROM tmp_observation_period WHERE person_id = ?")
        quit:$$$ISERR(sc)
        ; set sc=tRS.Execute(personId) 
        quit:$$$ISERR(sc)
        do tRS.Close()

        ; save data
        // 1 - save data to IRIS
        #dim saveObservationPeriodRequest As OMOP.Request.saveObservationPeriodBO
        set saveObservationPeriodRequest = ##class(OMOP.Request.saveObservationPeriodBO).%New()
        set saveObservationPeriodRequest.personId = personId
        set saveObservationPeriodRequest.startDate = $zd(startDate,3)
        set saveObservationPeriodRequest.endDate = $zd(endDate,3)
        set saveObservationPeriodRequest.periodTypeConceptId = 44814725
        set saveObservationPeriodRequest.type = "saveObservationPeriod"
        set saveObservationPeriodRequest.target = "IRIS"
        set saveObservationPeriodRequest.observationPeriodId = ..getNewId("observationPeriod")
        set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveObservationPeriodRequest, .saveObservationPeriodResponse)
        q:$$$ISERR(sc)
        
        // 1 - save data to PostgreSQL
        set saveObservationPeriodRequest.target = "PostgreSQL"
        set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveObservationPeriodRequest, .saveObservationPeriodResponse)
        q:$$$ISERR(sc)


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

