/// 
/// Base class for all transformations
/// 
Class OMOP.Common.DataTransform Extends Ens.DataTransform
{

ClassMethod getVisitInfo(encounterId, providerId, careSiteId, visitId, visitDetailsId)
{
	if encounterId = "" {
		q ""	
	}
	set tRS = ##class(%ResultSet).%New()
	
	s sql = "SELECT visit_occurrence_id, provider_id, care_site_id FROM visit_occurrence "_
			"WHERE visit_source_value = ?"
			
	set sc = tRS.Prepare(sql)
	q:$$$ISERR(sc) ""
	
	#dim rs As EnsLib.SQL.GatewayResultSet
	
	set tSC = tRS.Execute(encounterId)
	q:$$$ISERR(tSC) ""
	
	Set n=0  
	d tRS.Next(.tSC)
	q:$$$ISERR(tSC) ""
	
	s providerId = tRS.Data("provider_id")
	s careSiteId = tRS.Data("care_site_id")
	s visitId = tRS.Data("visit_occurrence_id")
	s visitDetailsId = tRS.Data("visit_occurrence_id")
	
	q "1"
}

/// save error in log table	
ClassMethod logError(omopTblId = "", omopField = "", omopRecordId = "", omopValue = "", sourceTbl = "", sourceField = "", sourceRecordId = "", sourceValue = "")
{
	
	set cls = ##class(OMOP.Storage.Errors).%New()
	s cls.omopTblId = omopTblId
	s cls.omopField = omopField
	s cls.omopRecordId = omopRecordId
	s cls.omopValue = omopValue
	s cls.sourceTbl = sourceTbl
	s cls.sourceField = sourceField
	s cls.sourceRecordId = sourceRecordId
	s cls.sourceValue = sourceValue
	s sc = cls.%Save()
}

/// get visit start date time from eventTable
ClassMethod getPersonSourceDateTime(person)
{
	s ret = ""
	set tRS = ##class(%ResultSet).%New()
		
	q:person="" ""
	
	s sql = "SELECT person_source_value "_
			"FROM SQLUser.person "_
			"WHERE person_id = ?"

	set sc = tRS.Prepare(sql)
	q:$$$ISERR(sc) ""
		
	#dim rs As EnsLib.SQL.GatewayResultSet
		
	set tSC = tRS.Execute(person)
	q:$$$ISERR(tSC) ""
		
	Set n=0  
	while (tRS.Next(.tSC)) { 
		s ret = tRS.Data("person_source_value")
	}
	s ret = $p(ret,"|",2)
	
	q ret
}

/// get visit start date time from eventTable
/// w ##class(OMOP.Common.DataTransform).getVisitStartDateTime(visitId)
ClassMethod getVisitStartDateTime(visitId)
{
	s ret = ""
	set tRS = ##class(%ResultSet).%New()
	
	q:visitId="" ""
	
	s sql = "SELECT visit_start_datetime "_
			"FROM SQLUser.visit_occurrence "_
			"WHERE visit_source_value = ?"

	set sc = tRS.Prepare(sql)
	q:$$$ISERR(sc) ""
	
	#dim rs As EnsLib.SQL.GatewayResultSet
	
	set tSC = tRS.Execute(visitId)
	q:$$$ISERR(tSC) ""
	
	Set n=0  
	while (tRS.Next(.tSC)) { 
		s ret = tRS.Data("visit_start_datetime")
	}
	
	q ret
}

/// 
/// transform value via our own lookup table
/// 
ClassMethod getLookUpTblValue(tblName = "", columnName = "", sourceCode = "", sourceValue = "", returnColumn = "concept_id")
{
	s ret = ""
	
	try {
	
		s tblName = $ZCVT($g(tblName),"l")
		s columnName = $ZCVT($g(columnName),"l")
		s (sourceCode,sourceCode2) = $ZCVT($g(sourceCode),"l")
		s (sourceValue,sourceValue2) = $ZCVT($g(sourceValue),"l")
		
		//
		// new block - transformation cache
		//
		if ($g(tblName)'="")&&($g(columnName)'="")&&($g(sourceCode)'="")&&($g(returnColumn)'="")&&($g(sourceValue)=""){
			s ret = $g(^||OMOP("getLookUpTblValue",tblName,columnName,sourceCode,returnColumn))
		}
		
		if ret="" {
		
		
		set tRS = ##class(%ResultSet).%New()
		
		if sourceCode = "" {
			set SQL = "SELECT TOP 1 "_returnColumn_",Comments "_		; value
				"FROM SQLUser.lookUpTbl "_
				"WHERE "_
				"Tbl_name = ? "_
				"AND "_
				"column_name = ? "
				;sourceCode
			
			if sourceValue = "" {
				set sourceValue = " AND ((source_value = '') OR (source_value IS NULL) OR (source_value = 'null'))"
				set SQL = SQL_" "_sourceValue
				
			} else {
				set SQL = SQL_
					"AND "_
					"source_value = ?"
			}
			
			set tSC = tRS.Prepare(SQL)
			if $$$ISERR(tSC) $$$TRACE(tSC) q
			set tSC = tRS.Execute(tblName,columnName,sourceValue)
			if $$$ISERR(tSC) $$$TRACE(tSC) q
			
		} else {
			if sourceValue=""{
				
				set SQL = "SELECT TOP 1 "_returnColumn_",Comments "_		; value
						"FROM SQLUser.lookUpTbl "_
						"WHERE "_
						"Tbl_name = ? "_
						"AND "_
						"column_name = ? "_
						"AND "_
						"source_code = ?"
			
				set tSC = tRS.Prepare(SQL)
				if $$$ISERR(tSC) $$$TRACE(tSC) q
			
				set tSC = tRS.Execute(tblName,columnName,sourceCode)
				if $$$ISERR(tSC) $$$TRACE(tSC) q

			} else {
				set SQL = "SELECT TOP 1 "_returnColumn_",Comments "_		; value
						"FROM SQLUser.lookUpTbl "_
						"WHERE "_
						"Tbl_name = ? "_
						"AND "_
						"column_name = ? "_
						"AND "_
						"source_code = ? "_
						"AND "_
						"source_value = ?"
						
			
				set tSC = tRS.Prepare(SQL)
				if $$$ISERR(tSC) $$$TRACE(tSC) q
			
				set tSC = tRS.Execute(tblName,columnName,sourceCode,sourceValue)
				if $$$ISERR(tSC) $$$TRACE(tSC) q
			}
		}
		
		Set n=0  
		while (tRS.Next(.tSC)) { 
			s ret = tRS.Data(returnColumn)
			s comment = tRS.Data("Comments")
		}
		
		if ((sourceCode2="")&&(sourceValue2 = "")&&((ret = "")||(ret = 0)))||($g(comment) = "non-standard")||(ret = "")||(ret = 0) {
			// LOG ERROR
			d ..logError("",returnColumn,"",ret,tblName,columnName,"",sourceCode2_"|"_sourceValue2_"|"_$g(comment))
		}
			
		;d ..logError("",returnColumn,"",tblName,columnName,"",sourceCode2_"|"_sourceValue)
		if ($g(tblName)'="")&&($g(columnName)'="")&&($g(sourceCode)'="")&&($g(returnColumn)'="")&&($g(sourceValue)=""){
			s ^||OMOP("getLookUpTblValue",tblName,columnName,sourceCode,returnColumn) = ret
		}
	}
	
	} catch e {
		s ret = e.AsStatus()
	}

	q ret
}

}
