Class OMOP.Utils.Import [ Abstract ]
{

/// 
/// 2022 03 28 Denis Bulashev
/// 2023 02 10 Sergey Petrov
/// Import artificial data to OMOP from csv files
/// From here http://www.ltscomputingllc.com/downloads/
/// 
/// d ##class(OMOP.Utils.Import).ImportData("/opt/irisbuild/data/")
ClassMethod ImportData(dataDir = "")
{
	set dur = ##class(User.LogDuration).%New()
	try{
		q:dataDir=""
		W !,"Start import data",!!
		do INITLOOKUP
		set fileName=""
		; vocabularies
		for {
			set fileName = $order(LOOKUP("vocabularies",fileName)) 
			quit:fileName=""
			set className = $get(LOOKUP("vocabularies",fileName))
			w "fileName:  "_fileName,!
			w "className:  "_className,!

			if fileName = "CONCEPT_ANCESTOR" {
				set tblName = "SQLUser.concept_ancestor"
				set lc = "LOAD BULK %NOJOURN DATA FROM FILE"
				set lc = lc_" '"_dataDir_fileName_".csv' INTO "_tblName
				set lc = lc_" USING { ""from"": {""file"": {""header"": true, ""columnseparator"": "",""}}}"

				w "Loading: "_lc,!
				set tStatement = ##class(%SQL.Statement).%New()
				set qStatus = tStatement.%Prepare(lc)
				if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit}
				set rset = tStatement.%Execute()
				set tStatement = ##class(%SQL.Statement).%New()

				w "Indexing: "_tblName,!
				set qStatus = tStatement.%Prepare("BUILD INDEX FOR TABLE "_tblName)
				if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit}
				set rset = tStatement.%Execute()
			}
			elseif fileName = "CONCEPT_RELATIONSHIP" {
				set tblName = "SQLUser.concept_relationship"
				set lc = "LOAD BULK %NOJOURN DATA FROM FILE"
				set lc = lc_" '"_dataDir_fileName_".csv' INTO "_tblName
				set lc = lc_" USING { ""from"": {""file"": {""header"": true, ""columnseparator"": "",""}}}"

				w "Loading: "_lc,!
				set tStatement = ##class(%SQL.Statement).%New()
				set qStatus = tStatement.%Prepare(lc)
				if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit}
				set rset = tStatement.%Execute()

				w "Indexing: "_tblName,!
				set qStatus = tStatement.%Prepare("BUILD INDEX FOR TABLE "_tblName)
				if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit}
				set rset = tStatement.%Execute()
			} 
			#; elseif fileName = "CONCEPT_SYNONYM" {
				#; 	set tblName = "SQLUser.concept_synonym"
				#; 	set lc = "LOAD BULK %NOJOURN DATA FROM FILE"
				#; 	set lc = lc_" '"_dataDir_fileName_".csv' INTO "_tblName
				#; 	set lc = lc_" USING { ""from"": {""file"": {""header"": true, ""columnseparator"": "",""}}}"

				#; w "Loading: "_lc,!
				#; set tStatement = ##class(%SQL.Statement).%New()
				#; 	set qStatus = tStatement.%Prepare(lc)
				#; 	if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit}
				#; 	set rset = tStatement.%Execute()

				#; w "Indexing: "_tblName,!
				#; set qStatus = tStatement.%Prepare("BUILD INDEX FOR TABLE "_tblName)
				#; if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit}
				#; set rset = tStatement.%Execute()
			#; }
			elseif fileName = "CONCEPT" {
				set tblName = "SQLUser.concept"
				set lc = "LOAD BULK %NOJOURN DATA FROM FILE"
				set lc = lc_" '"_dataDir_fileName_".csv' INTO "_tblName
				set lc = lc_" USING { ""from"": {""file"": {""header"": true, ""columnseparator"": ""\t""}}}"

				w "Loading: "_lc,!
				set tStatement = ##class(%SQL.Statement).%New()
				set qStatus = tStatement.%Prepare(lc)
				if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit}
				set rset = tStatement.%Execute()

				w "Indexing: "_tblName,!
				set qStatus = tStatement.%Prepare("BUILD INDEX FOR TABLE "_tblName)
				if qStatus'=1 {write "%Prepare failed:" do $System.Status.DisplayError(qStatus) quit}
				set rset = tStatement.%Execute()
			}
			else {
				do ..ImportFile(dataDir,fileName,className,1)
			}
		}

		; lookup tables
		set fileName=""
		for {
			set fileName = $order(LOOKUP("lookup_tables",fileName))
			quit:fileName=""
			set className = $get(LOOKUP("lookup_tables",fileName))
			do ..ImportFile(dataDir,fileName,className,1)
		}
		
		
		; artificial dataset
		set fileName=""
		for {
			set fileName = $order(LOOKUP("artificial_dataset",fileName))
			quit:fileName=""
			set className = $get(LOOKUP("artificial_dataset",fileName))
			do ..ImportFile(dataDir,fileName,className,0)
		}
		W !!,"Import data complete",!	
	} 
	catch e {
		s sc = e.AsStatus()
		w $system.Status.GetErrorText(sc),!
	}
	quit
 //============================================================================
 // Init local LookUp table
 //============================================================================
INITLOOKUP
	set group = "vocabularies"
	S LOOKUP(group,"CONCEPT")="User.concept"
	S LOOKUP(group,"CONCEPT_ANCESTOR")="User.conceptancestor"
	S LOOKUP(group,"CONCEPT_CLASS")="User.conceptclass"
	S LOOKUP(group,"CONCEPT_RELATIONSHIP")="User.conceptrelationship"
	S LOOKUP(group,"CONCEPT_SYNONYM")="User.conceptsynonym"
	S LOOKUP(group,"DOMAIN")="User.domain"
	S LOOKUP(group,"DRUG_STRENGTH")="User.drugstrength"
	S LOOKUP(group,"VOCABULARY")="User.vocabulary"
	S LOOKUP(group,"RELATIONSHIP")="User.relationship"

	set group = "lookup_tables"
	S LOOKUP(group,"1 Look-up2")="User.lookUpTbl"
	S LOOKUP(group,"SocialHistory1")="User.lookUpTbl"
	S LOOKUP(group,"Procedure_look_up1")="User.lookUpTbl"
	S LOOKUP(group,"Observation3")="User.lookUpTbl"
	S LOOKUP(group,"Observation2")="User.lookUpTbl"
	S LOOKUP(group,"Observation1")="User.lookUpTbl"
	S LOOKUP(group,"LabResult2")="User.lookUpTbl"
	S LOOKUP(group,"LabResult1")="User.lookUpTbl"
	S LOOKUP(group,"Diagnosis1")="User.lookUpTbl"
	S LOOKUP(group,"Drugs2")="User.lookUpTbl"
	S LOOKUP(group,"Drugs1")="User.lookUpTbl"
	S LOOKUP(group,"Allergy3")="User.lookUpTbl"
	S LOOKUP(group,"Allergy2")="User.lookUpTbl"
	S LOOKUP(group,"Allergy1")="User.lookUpTbl"
	S LOOKUP(group,"1 Look-up3")="User.lookUpTbl"
	S LOOKUP(group,"1 Look-up1")="User.lookUpTbl"
	S LOOKUP(group,"Problem3")="User.lookUpTbl"
	S LOOKUP(group,"Problem2")="User.lookUpTbl"
	S LOOKUP(group,"Problem1")="User.lookUpTbl"
	S LOOKUP(group,"Lookup radres")="User.lookUpTbl"
	S LOOKUP(group,"Labs item")="User.lookUpTbl"

	set group = "artificial_dataset"
	S LOOKUP(group,"care_site")="User.caresite"
	S LOOKUP(group,"cdm_source")="User.cdmsource"
	S LOOKUP(group,"condition_era")="User.conditionera"
	S LOOKUP(group,"condition_occurrence")="User.conditionoccurrence"
	S LOOKUP(group,"cost")="User.cost"
	S LOOKUP(group,"death")="User.death"
	S LOOKUP(group,"device_exposure")="User.deviceexposure"
	S LOOKUP(group,"drug_era")="User.drugera"
	S LOOKUP(group,"drug_exposure")="User.drugexposure"
	S LOOKUP(group,"location")="User.location"
	S LOOKUP(group,"measurement")="User.measurement"
	S LOOKUP(group,"observation")="User.observation"
	S LOOKUP(group,"observation_period")="User.observationperiod"
	S LOOKUP(group,"payer_plan_period")="User.payerplanperiod"
	S LOOKUP(group,"person")="User.person"
	S LOOKUP(group,"procedure_occurrence")="User.procedureoccurrence"
	S LOOKUP(group,"provider")="User.provider"
	S LOOKUP(group,"visit_occurrence")="User.visitoccurrence"

	quit
 //============================================================================
}

/// d ##class(OMOP.Utils.Import).ImportFile("/opt/irisbuild/data/","CONCEPT","User.concept")
ClassMethod ImportFile(dataDir = "", fileName = "", className = "", skipHead = 0)
{
	set dur = ##class(User.LogDuration).%New()
	if dataDir = "" w "Empty dataDir!",! quit
	if fileName = "" w "Empty fileName!",! quit
	if className="" w "Empty className!",! quit
	w "Processing file: "_dataDir_fileName_".csv",!
	set fileCls = ##class(%Library.FileCharacterStream).%New()
	set fileCls.Filename = dataDir_fileName_".csv"
	set lastWrite=$p($zh,".")
	set linesCount = 0
	d DISABLE^%NOJRN
	while 'fileCls.AtEnd {
		set fileLine = fileCls.ReadLine()
		I lastWrite'=$p($zh,".") {
			W $C(13),linesCount
			set lastWrite=$p($zh,".")
		}
		; skip rows with column names
		continue:$I(linesCount)<=skipHead
		
		set sc=$CLASSMETHOD(className,"InsertLine",fileLine)
		if $$$ISERR(sc){
			w !,$system.Status.GetErrorText(sc),!
			if $I(errCounter)>10 quit	
			continue
		}	
	}
	w $C(13),"Rows count: "_linesCount,!
	d ENABLE^%NOJRN
}

/// d ##class(OMOP.Utils.Import)ImportTest3()
ClassMethod ImportTest3()
{
	s path = "/home/overevkina/import/"
	DO $SYSTEM.SQL.Schema.ImportDDL(path_"insert_metadata_act_covid_V4.sql",,"MSSQLServer")
}

/// d ##class(OMOP.Utils.Import).ImportDicts20211224()
ClassMethod ImportDicts20211224()
{
	s path = "/home/overevkina/import/lookUp_20211224/"
	; 1 create structure for dictionaries
	;DO $SYSTEM.SQL.Schema.ImportDDL(path_"0_create_vocab.ddl.sql",,"MSSQLServer")
	
	s fileCls = ##class(%Library.FileCharacterStream).%New()
	
	Set tStmnt=##class(%SQL.Statement).%New()
	
	s errorsCount = 0
	f tblName= "1 Look-up1_1.sql" , "1 Look-up2_1.sql", "1 Look-up3_1.sql", "Allergy1_1.sql", "Allergy2_1.sql", "Allergy3_1.sql", "Diagnosis1_1.sql", "Drugs1_1.sql", "Drugs1_2.sql", "Drugs2_1.sql", "LabResult1_1.sql", "LabResult2_1.sql", "Observation1_1.sql", "Observation2_1.sql", "Observation3_1.sql", "Problem1_1.sql", "Problem2_1.sql", "Problem2_2.sql", "Problem2_3.sql", "Problem2_4.sql", "Problem3_1.sql", "Procedure_look_up1_1.sql", "SocialHistory1_1.sql" {
		w "process file ",tblName,!
		s linesCount=0
		
		
		DO $SYSTEM.SQL.Schema.ImportDDL(path_tblName,,"MySQL")
	}
}

/// d ##class(OMOP.Utils.Import).ImportDicts()
ClassMethod ImportDicts()
{
	s path = "/home/overevkina/import/"
	; 1 create structure for dictionaries
	;DO $SYSTEM.SQL.Schema.ImportDDL(path_"0_create_vocab.ddl.sql",,"MSSQLServer")
	
	s fileCls = ##class(%Library.FileCharacterStream).%New()
	
	Set tStmnt=##class(%SQL.Statement).%New()
	
	s errorsCount = 0
	;f tblName="1_truncate_omop_base.sql","2_omop_base.concept_class.Table.sql","3_omop_base.domain.Table.sql","4_omop_base.vocabulary.Table.sql","5_1_omop_base.concept.Table.sql","5_2_omop_base.concept.Table.sql","6_omop_base.relationship.Table.sql","7_omop_base.concept_relationship.Table.sql","8_omop_base.concept_synonym.Table.sql","9_omop_base.drug_strength.Table.sql","10_omop_base.concept_ansestor.Table.sql" {
	f tblName="8_omop_base.concept_synonym.Table.sql","9_omop_base.drug_strength.Table.sql","10_omop_base.concept_ansestor.Table.sql" {
		w "process file ",tblName,!
		s linesCount=0
		
		
		s fileCls.Filename = path_tblName
		while 'fileCls.AtEnd {
			s fileLine = fileCls.ReadLine()
			s linesCount=linesCount + 1
			
			continue:$e(fileLine,1,3)["GO"
			quit:errorsCount>100
			
			; prepare string
			if tblName = "1_truncate_omop_base.sql" {
				s fileLine = $REPLACE(fileLine,"[omop_base].","")
				s fileLine = $REPLACE(fileLine,";","")
			} else {
				s fileLine = $REPLACE(fileLine,"[omop_base].","INTO ")
				s fileLine = $REPLACE(fileLine,");",")")
			}
			s fileLine = $REPLACE(fileLine,"[domain]","""domain""")
			s fileLine = $REPLACE(fileLine,"[","")
			s fileLine = $REPLACE(fileLine,"]","")
			s fileLine = $REPLACE(fileLine,"(N'","('")
			s fileLine = $REPLACE(fileLine,"', N'","', '")
			s fileLine = $REPLACE(fileLine,", N'",", '")
			
			
			Set tSQL = fileLine
			Set tSC = tStmnt.%Prepare(tSQL)
			If 'tSC {
				w !,!,"Error:",!,tSQL
				w $system.OBJ.DisplayError(tSC),!
				s errorsCount = errorsCount + 1
				continue
			}
			
			Set resultSet = tStmnt.%Execute()
			If (resultSet.%SQLCODE < 0) {
				;Throw ##class(%Exception.SQL).CreateFromSQLCODE(resultSet.%SQLCODE, resultSet.%Message)
				w !,!,"Error:",!,tSQL,!,resultSet.%SQLCODE,!,resultSet.%Message,!
				s errorsCount = errorsCount + 1
			}

			;w 2," ",fileLine,"|",tSQL,"|",!
			if linesCount#1000 = 0 w "Processed lines: ",linesCount,!
		}
		; DO $SYSTEM.SQL.Schema.ImportDDL(path_tblName,,"MSSQLServer")
		quit:errorsCount>100
		w "Total lines count: ",linesCount,!,!
	}
}

}

