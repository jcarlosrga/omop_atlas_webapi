Class OMOP.Utils.database [ Abstract ]
{

/// d ##class(OMOP.Utils.database).locationFix()
ClassMethod locationFix()
{
	s glo = "^||BUL"
	k @glo
	
	set tRS = ##class(%ResultSet).%New()
	
	; build list of duplicates in locations
	set SQL = "SELECT location_id, location_source_value FROM location"
	Set tSC = tRS.Prepare(SQL)
	Quit:$$$ISERR(tSC)
	Set tSC = tRS.Execute()  
	Quit:$$$ISERR(tSC)
	
	While (tRS.Next(.tSC)) { 
		s locationId = tRS.Data("location_id")
		s locationSourceValue = tRS.Data("location_source_value")
		s @glo@(1,locationSourceValue,locationId)=""
		;s @glo@(2,locationId,locationSourceValue)=""
	}
	do tRS.Close()
	
	; collect list of locations from persons
	set SQL = "SELECT location_id FROM person"
	Set tSC = tRS.Prepare(SQL)
	Quit:$$$ISERR(tSC)
	Set tSC = tRS.Execute()  
	Quit:$$$ISERR(tSC)
	
	While (tRS.Next(.tSC)) { 
		s locationId = tRS.Data("location_id")
		s @glo@(2,locationId)=""
	}
	do tRS.Close()


	
	w 1
	
	; remove unuque values
	; and values from patients
	s origId = "" for { s origId = $o(@glo@(1,origId)) q:origId=""
		if $o(@glo@(1,origId,""), -1) = $o(@glo@(1,origId,"")) k @glo@(1,origId)
		
		; check patients location
		s df = 0
		s locationId = "" for { s locationId = $o(@glo@(1,origId,locationId)) q:locationId=""
			if $d(@glo@(2,locationId)) {
				s df = locationId
				quit
			}
		}
		if df k @glo@(1,origId,df)
	}
	
	w 2
	
	; here we have only duplicated locations without connections with patients
	


	; clear duplicates
	set SQL = "DELETE FROM location WHERE location_id = ?"
	Set tSC = tRS.Prepare(SQL)
	Quit:$$$ISERR(tSC)


	s origId = "" for { s origId = $o(@glo@(1,origId)) q:origId=""
		s locationId = "" for { s locationId = $o(@glo@(1,origId,locationId)) q:locationId=""
			Set tSC = tRS.Execute(locationId)  
			Quit:$$$ISERR(tSC)
		}
	}
	do tRS.Close()

	w "Ok"

	;zw @glo
}

/// d ##class(OMOP.Utils.database).patientsDuplicateChecks()
/// updated 20221124
ClassMethod patientsDuplicateChecks()
{
	s sc = $$$OK
	try{
		set tRS = ##class(%ResultSet).%New()
		set tRS2 = ##class(%ResultSet).%New()
		
		set SQL = "SELECT person_id, birth_datetime, person_source_value, gender_source_value, race_source_value, ethnicity_source_value FROM person WHERE ( (for_delete <> 1) OR (for_delete is NULL))"
		set tSC = tRS.Prepare(SQL)
		quit:$$$ISERR(tSC)
		
		set tSC = tRS.Execute()  
		quit:$$$ISERR(tSC)
		
		set patientsArr = "^||BUL"
		k @patientsArr
		
		s pCount = 0
		while tRS.Next(.tSC){
			quit:$$$ISERR(tSC)
			s pCount = pCount + 1
			;w pCount,!
			
			s personId = tRS.Data("person_id")
			s personId = $s(personId = "":"-",1:personId)
			s personId = $zcvt(personId, "l")
			
			s birthDatetime = tRS.Data("birth_datetime")
			s birthDatetime = $s(birthDatetime = "":"-",1:birthDatetime)
			s birthDatetime = $zcvt(birthDatetime, "l")
			
			s personSourceValue = tRS.Data("person_source_value")
			s personSourceValue = $s(personSourceValue = "":"-",1:personSourceValue)
			s personSourceValue = $zcvt(personSourceValue, "l")
			
			s genderSourceValue = tRS.Data("gender_source_value")
			s genderSourceValue = $s(genderSourceValue = "":"-",1:genderSourceValue)
			s genderSourceValue = $zcvt(genderSourceValue, "l")
			
			s raceSourceValue = tRS.Data("race_source_value")
			s raceSourceValue = $s(raceSourceValue = "":"-",1:raceSourceValue)
			s raceSourceValue = $zcvt(raceSourceValue, "l")
			
			s ethnicitySourceValue = tRS.Data("ethnicity_source_value")
			s ethnicitySourceValue = $s(ethnicitySourceValue = "":"-",1:ethnicitySourceValue)
			s ethnicitySourceValue = $zcvt(ethnicitySourceValue, "l")
			
			; gather all data
			s @patientsArr@(personSourceValue,birthDatetime,genderSourceValue,raceSourceValue,ethnicitySourceValue,personId)=""
			
		}
		
		w "Patients count: "_pCount,!
		
		
		
		; mark patients for removal
		s duplicatesCount = 0
		s personSourceValue = "" for { set personSourceValue = $o(@patientsArr@(personSourceValue)) q:personSourceValue=""
			s birthDatetime = "" for { set birthDatetime = $o(@patientsArr@(personSourceValue, birthDatetime)) q:birthDatetime=""
				s genderSourceValue = "" for { set genderSourceValue = $o(@patientsArr@(personSourceValue, birthDatetime,genderSourceValue)) q:genderSourceValue=""
					s raceSourceValue = "" for { set raceSourceValue = $o(@patientsArr@(personSourceValue, birthDatetime, genderSourceValue, raceSourceValue)) q:raceSourceValue=""
						s ethnicitySourceValue = "" for { set ethnicitySourceValue = $o(@patientsArr@(personSourceValue, birthDatetime, genderSourceValue, raceSourceValue, ethnicitySourceValue)) q:ethnicitySourceValue=""
							set firstPersonId = $o(@patientsArr@(personSourceValue, birthDatetime, genderSourceValue, raceSourceValue, ethnicitySourceValue,""))
							s personId = "" for { set personId = $o(@patientsArr@(personSourceValue, birthDatetime, genderSourceValue, raceSourceValue, ethnicitySourceValue,personId), -1) q:personId=""
								if personId '= firstPersonId {
									s duplicatesCount = duplicatesCount + 1
									; mark patients as processed
									
									set tRS2 = ##class(%ResultSet).%New()
									
									set SQL = "UPDATE person SET for_delete = 1 WHERE person_id = ?"
									set tSC = tRS2.Prepare(SQL)
									quit:$$$ISERR(tSC)
									
									set tSC = tRS2.Execute(personId)  
									quit:$$$ISERR(tSC)
									
								}
							}
						}
					}
				}
			}
		}
		
		w "Duplicates count: "_duplicatesCount,!
		w "Unique patinets count: "_(pCount - duplicatesCount),!
		
		// DELETE FROM person WHERE for_delete is not NULL
		set tRS2 = ##class(%ResultSet).%New()
		
		set SQL = "DELETE FROM person WHERE for_delete is not NULL"
		set tSC = tRS2.Prepare(SQL)
		quit:$$$ISERR(tSC)
		
		set tSC = tRS2.Execute(personId)  
		quit:$$$ISERR(tSC)
		
		do tRS2.Close()
		
	} catch e {
		s sc = e.AsStatus()
		w $g(pCount),!
		w "Critical error occured "_sc
	}
	q sc
}

/// fix source value in visit* tables
/// d ##class(OMOP.Utils.database).visitSOurceFix()
/// does not work
ClassMethod visitSOurceFix()
{
	s sc = $$$OK
	try{
		; process all patients
		set tRS = ##class(%ResultSet).%New()
		set tRS2 = ##class(%ResultSet).%New()
		
		lock +^getNextPatientId4:10
		
		set SQL = "SELECT TOP 1 pId, ID FROM OMOP_Storage.patientId WHERE processed = 4"
		set tSC = tRS.Prepare(SQL)
		quit:$$$ISERR(tSC)
		
		set tSC = tRS.Execute()  
		quit:$$$ISERR(tSC)
		
		d tRS.Next(.tSC)
		quit:$$$ISERR(tSC)
		
		set pId = tRS.Data("pId")
		d tRS.Close()
		q:pId=""
		
		w "processing patient "_pId,!

		// update processing status
		set SQL = "UPDATE OMOP_Storage.patientId SET processed = 5 WHERE pId = ?"

		set tSC = tRS.Prepare(SQL)
		quit:$$$ISERR(tSC)
		
		set tSC = tRS.Execute(pId)  
		quit:$$$ISERR(tSC)
		
		d tRS.Close()
		lock -^getNextPatientId4:10
		
		
		// get inner person code from IRIS database
		set sql = "SELECT person_id FROM person WHERE person_source_value LIKE ?"
		
		set tSC=tRS.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=tRS.Execute(pId_"|%")
		quit:$$$ISERR(tSC)
		
		d tRS.Next(.tSC)
		q:$$$ISERR(tSC)
			
		s omopPersonId = tRS.GetDataByName("person_id")
			
		d tRS.Close()
		
		
		// get visits ID from baystate
		set sql = "SELECT ID FROM HSAA.Encounter WHERE patient = ? and TagFacility='BayState' order by StartTime"
		
		set tSC=tRS.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=tRS.Execute(pId)
		quit:$$$ISERR(tSC)
		
		
		/// find all visits for this patient and update outer code
		while tRS.Next(.tSC) {
			q:$$$ISERR(tSC)
			
			set visitId = tRS.GetDataByName("ID")
			w "visitId "_visitId,!
			
			
			// update visit ID
			// update processing status
			set SQL2 = "UPDATE visit_occurrence SET columnTmp = "_visitId_" WHERE person_id = "_omopPersonId
			w SQL2,!

			set tSC = tRS2.Prepare(SQL2)
			quit:$$$ISERR(tSC)
			
			set tSC = tRS2.Execute(visitId, omopPersonId)  
			quit:$$$ISERR(tSC)
			
			d tRS2.Close()
			
			
		}
		
		w "omopPersonId "_omopPersonId,!
		d tRS.Close()
		
		
		

		
		
	} catch e {
		s sc = e.AsStatus()
		w "Critical error occured "_sc
	}

	q sc
}

/// fix person.personSourceValue field in OMOP
/// d ##class(OMOP.Utils.database).personSourceValueFix()
ClassMethod personSourceValueFix()
{
	s sc = $$$OK
	;q sc
	try{
		; process all patients
		set rs=##class(%ResultSet).%New()

		set rs2=##class(%ResultSet).%New()
		
		set tRS = ##class(%ResultSet).%New()
		
		lock +^getNextPatientId3:10
		
		set SQL = "SELECT TOP 1 pId, ID FROM OMOP_Storage.patientId WHERE processed > 2"
		set tSC = tRS.Prepare(SQL)
		quit:$$$ISERR(tSC)
		
		set tSC = tRS.Execute()  
		quit:$$$ISERR(tSC)
		
		d tRS.Next(.tSC)
		quit:$$$ISERR(tSC)
		set pId = tRS.Data("pId")
		
		q:pId=""
		d tRS.Close()
		
		
		set SQL = "UPDATE OMOP_Storage.patientId SET processed = 4 WHERE pID = ?"
		set tSC = tRS.Prepare(SQL)
		quit:$$$ISERR(tSC)
		
		set tSC = tRS.Execute(pId)  
		quit:$$$ISERR(tSC)
		
		d tRS.Close()
		
		
		lock -^getNextPatientId3:10
		
		s pCount=0
		set pCount = pCount + 1
		;q:pCount>10
	
	
			; get information about this person	from BayState database
			s sql = "SELECT id, BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description, CreatedOn, "_
					"Gender_Code, RawGender_Code, BirthGender_Code "_
					"FROM HSAA.Patient "_
					"WHERE ID = ? "

			set sc=rs.Prepare(sql)
			quit:$$$ISERR(sc)

			set sc=rs.Execute(pId)
			quit:$$$ISERR(sc)
			
			d rs.Next(.sc) 
			s personId = rs.GetDataByName("ID")
			s personBirthTime = rs.GetDataByName("BirthTime")
			s personRaceCode = rs.GetDataByName("Race_Code")
			s personRaceDescription = rs.GetDataByName("Race_Description")
			s personEthnicGroupCode = rs.GetDataByName("EthnicGroup_Code")
			s personEthnicGroupDescription = rs.GetDataByName("EthnicGroup_Description")
			s personGenderCode = rs.GetDataByName("Gender_Code")
			s personRawGenderCode = rs.GetDataByName("RawGender_Code")
			s personBirthGenderCode = rs.GetDataByName("BirthGender_Code")
			s personCreatedOn= rs.GetDataByName("CreatedOn")
			
			d rs.Close()
			
			s ^BUL(5)=1
			; transform data
			
			; get patient from OMOP
			set sql = "SELECT person_id FROM person WHERE person_source_value LIKE ?"
			
			set sc=rs.Prepare(sql)
			quit:$$$ISERR(sc)

			set sc=rs.Execute(personId_"|"_personCreatedOn)
			quit:$$$ISERR(sc)
			
			;w sql_"|("_personId_"|"_personCreatedOn_")"
			
			s omopCnt=0
			while rs.Next(.sc) {
				s omopCnt = omopCnt + 1
				q:$$$ISERR(sc)
				q:omopCnt>1
				
				s omopPersonId = rs.GetDataByName("person_id")
				
				w "1 BS id: "_pId_", OMOP id:"_omopPersonId,!
			}
			d rs.Close()
			s ^BUL(6)=1
			; patient was not found
			if omopCnt'=1 {
				; loking for a group of fields
				; get patient from OMOP
				;set sql = "SELECT person_id FROM person WHERE birth_datetime = ? AND person_source_value = ? AND race_source_value = ?"
				set sql = "SELECT person_id FROM person WHERE birth_datetime = ? AND race_source_value = ?"
				
				set sc=rs.Prepare(sql)
				quit:$$$ISERR(sc)

				;set sc=rs.Execute(personBirthTime, "|"_personCreatedOn, personRaceDescription)
				set sc=rs.Execute(personBirthTime, personRaceDescription)
				quit:$$$ISERR(sc)
				
				s omopCnt2=0
				set omopPersonId = ""
				while rs.Next(.sc) {
					s omopCnt2 = omopCnt + 1
					q:$$$ISERR(sc)
					
					s omopPersonId = rs.GetDataByName("person_id")
					w "2 BS id: "_pId_", OMOP id:"_omopPersonId,!
				}
				d rs.Close()
			
				; we have found a record and only one
				if (omopCnt2 = 1) && (omopPersonId'="") {
					w "3",!
					set sql = "UPDATE person SET person_source_value = ? WHERE person_id = ?"
			s ^BUL(7)=1
					set sc=rs.Prepare(sql)
					quit:$$$ISERR(sc)

					set sc=rs.Execute(personId_"|"_personCreatedOn, omopPersonId)
					quit:$$$ISERR(sc)
					
					d rs.Close()
				}
			}
			
			
		;}
		
		
		
		
		
		
		
		
	} catch e {
		s sc = e.AsStatus()
		w "Critical error occured "_sc
	}
	s ^BUL(8)=1
	q sc
}

/// d ##class(OMOP.Utils.database)test()
ClassMethod test()
{
	
	f pId=1:1:100000{
		
			if ##class(OMOP.Storage.PatientId).%ExistsId(pId){
				W:(pId#10000=0) pId,!
				d ##class(OMOP.Storage.PatientId).%DeleteId(pId)
			}
			;s cls = ##class(OMOP.Storage.PatientId).%New()
			;s cls.pId = pId
			;d cls.%Save()
	}
}

/// d ##class(OMOP.Utils.database).profilerParse()
ClassMethod profilerParse()
{
	s glo = $NA(^BUL("profiler"))
	
	s jobId = "" for { s jobId = $o(@glo@(jobId)) q:jobId=""
		w "jobId "_jobId,!
		
		s methodName = ""
		s methodNameOld = ""
		s timeStart = ""
		s ind = "" for { s ind=$o(@glo@(jobId,ind)) q:ind=""
			s methodName = $o(@glo@(jobId,ind,""))
			if methodName = methodNameOld {
				s time = (+$g(@glo@(jobId,ind,methodName,"stop")) - timeStart)
				i time > 0.1 {
					w ind_" "_methodName_" time "_time,!
				}
			} else {
				s timeStart = $g(@glo@(jobId,ind,methodName,"start"))
				s methodNameOld = methodName
			}
		}
	}
}

/// d ##class(OMOP.Utils.database).clearOMOPData()
ClassMethod clearOMOPData()
{
	set tRS = ##class(%ResultSet).%New()
	
	for tblName = "location", "location_history","care_site","provider","person","death","visit_occurrence", "visit_detail", "condition_occurrence","observation","care_site","visit_detail","measurement","procedure_occurrence","drug_exposure","device_exposure","specimen","note",
		"eventTable","OMOP_Storage.Errors","observation_period","drug_exposure" ; "OMOP_Storage.PatientId"
		{
		;set sql = "DELETE FROM "_tblName
		set sql = "TRUNCATE TABLE "_tblName
		w sql,!
		set tSC = tRS.Prepare(sql) 
		if $$$ISERR(tSC) w $system.Status.GetErrorText(tSC),! q
		set tSC = tRS.Execute()  
		if $$$ISERR(tSC) w $system.Status.GetErrorText(tSC),! q
		d tRS.Close()
		
		k ^OMOP
	}
}

/// d ##class(OMOP.Utils.database).conceptDublicatesCheck()
/// updated 20221123
ClassMethod conceptDublicatesCheck()
{
	Set tRS = ##class(%ResultSet).%New()
	
	Set tRS2 = ##class(%ResultSet).%New()
	
	Set SQL = "select count(concept_id), concept_id, max(%Id) from SQLUser.concept GROUP BY concept_id"
	Set tSC = tRS.Prepare(SQL)
	Quit:$$$ISERR(tSC)
	Set tSC = tRS.Execute()  
	Quit:$$$ISERR(tSC)
	
	Set n=0  
	While (tRS.Next(.tSC)) { 
		Set n = n+1
		;w tRS.Data("concept_id")," ",tRS.Data("Aggregate_1")," ",tRS.Data("Aggregate_3"),!
		// get maximal Id for this concept
		//s SQL2 = "DELETE FROM SQLUser.concept WHERE concept_id = "_tRS.Data("concept_id")_" AND %Id < "_tRS.Data("Aggregate_3")_""
		s SQL2 = "DELETE FROM SQLUser.concept WHERE concept_id = ? AND %Id < ?"
		if tRS.Data("Aggregate_1") > 1 {
			;w SQL2,!
			Set tSC2 = tRS2.Prepare(SQL2)
			if $$$ISERR(tSC2) w $system.Status.GetErrorText(tSC2) q
			Set tSC2 = tRS2.Execute(tRS.Data("concept_id"), tRS.Data("Aggregate_3"))  
			if $$$ISERR(tSC2) w $system.Status.GetErrorText(tSC2) q
			;w n,!
			d tRS2.Close()
		}
	}
	d tRS.Close()

	w "Ok",!
}

}

