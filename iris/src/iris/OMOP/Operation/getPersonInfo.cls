/// Unused
Class OMOP.Operation.getPersonInfo Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method getPatientInfo(pRequest As OMOP.Request.getPatientInfo, Output pResponse As OMOP.Response.getPatientInfo) As %Status
{
	; #include %occInclude
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = "SELECT id, BirthTime, Race_Code, Race_Description, "_
					"EthnicGroup_Code, EthnicGroup_Description, "_
					"Address_Street, Address_City_Description, "_
					"Address_CountRy_Code, Address_State_Code, Address_Zip_Code, "_
					"Gender_Code, Gender_Description, "_
					"RawGender_Code, RawGender_Description, "_
					"BirthGender_Code, BirthGender_Description, "_
					"Deceased, DeathTime "_
					"FROM HSAA.Patient as p "_
					"WHERE ID = "_pRequest.patientId
		
	   	set gc=##class(%SQLGatewayConnection).%New()
	   	q:gc=$$$NULLOREF 	;w "Cannot create %SQLGatewayConnection." q		
	   	
		; !!!!
		set pDSN="UserunixodbcHI"
		set usr=""	;"overevkina"
		set pwd=""	;"Fls2020fls20"
		
		set sc=gc.Connect(pDSN,usr,pwd,0)
		q:$$$ISERR(sc) ;w $system.Status.GetErrorText(sc) q
		
		q:gc.ConnectionHandle="" ;w "Connection failed" q
		
		set sc=gc.AllocateStatement(.hstmt)
		q:$$$ISERR(sc) 	;w $system.Status.GetErrorText(sc) q
		
		//Prepare statement for execution
		s pQuery = sql
		$$$TRACE(pQuery)
		
		set sc=gc.Prepare(hstmt,pQuery)
		q:$$$ISERR(sc) 	;w $system.Status.GetErrorText(sc) q		
		
		//Execute statement
		set sc=gc.Execute(hstmt)
		q:$$$ISERR(sc) 	;w $system.Status.GetErrorText(sc) q
		
		//Get list of columns returned by query
		set sc=gc.DescribeColumns(hstmt, .columnlist)
		q:$$$ISERR(sc)	;w $system.Status.GetErrorText(sc) q
		
		;//display column headers delimited by ":"
		set numcols=$listlength(columnlist)-1  //get number of columns
		;for colnum=2:1:numcols+1 {
		;  Write $listget($listget(columnlist,colnum),1),":"
		;}
		;write !
		
		//Return first 200 rows
		set sc=gc.Fetch(hstmt)
		q:$$$ISERR(sc) 	;w $system.Status.GetErrorText(sc)
		
		s json={"id":[]}
		set rownum=1
		
		while(gc.sqlcode'=100) {
			set sc=gc.GetData(hstmt, 1, 1, .val)
			s pResponse.id = val
			set sc=gc.GetData(hstmt, 2, 1, .val)
			s pResponse.birthTime = val
			set sc=gc.GetData(hstmt, 3, 1, .val)
			s pResponse.raceCode = val
			set sc=gc.GetData(hstmt, 4, 1, .val)
			s pResponse.raceDescription = val
			set sc=gc.GetData(hstmt, 5, 1, .val)
			s pResponse.ethnicGroupCode = val
			set sc=gc.GetData(hstmt, 6, 1, .val)
			s pResponse.ethnicGroupDescription = val
			set sc=gc.GetData(hstmt, 7, 1, .val)
			s pResponse.addressStreet = val
			set sc=gc.GetData(hstmt, 8, 1, .val)
			s pResponse.addressCityDescription = val
			set sc=gc.GetData(hstmt, 9, 1, .val)
			s pResponse.addressCountRyCode = val
			set sc=gc.GetData(hstmt, 10, 1, .val)
			s pResponse.addressStateCode = val
			set sc=gc.GetData(hstmt, 11, 1, .val)
			s pResponse.addressZipCode = val
			set sc=gc.GetData(hstmt, 12, 1, .val)
			s pResponse.genderCode = val
			set sc=gc.GetData(hstmt, 13, 1, .val)
			s pResponse.genderDescription = val
			set sc=gc.GetData(hstmt, 14, 1, .val)
			s pResponse.rawGenderCode = val
			set sc=gc.GetData(hstmt, 15, 1, .val)
			s pResponse.rawGenderDescription = val
			set sc=gc.GetData(hstmt, 16, 1, .val)
			s pResponse.birthGenderCode = val
			set sc=gc.GetData(hstmt, 17, 1, .val)
			s pResponse.birthGenderDescription = val
			set sc=gc.GetData(hstmt, 18, 1, .val)
			s pResponse.deceased = val
			set sc=gc.GetData(hstmt, 19, 1, .val)
			s pResponse.deathTime = val
			
			set rownum=rownum+1
		  	set sc=gc.Fetch(hstmt)
		  	break:$$$ISERR(sc) 
		}
		
		//Close cursor and then disconnect
		set sc=gc.CloseCursor(hstmt)
		q:$$$ISERR(sc)	;w $system.Status.GetErrorText(sc)

		set sc=gc.Disconnect()
		;w $system.Status.GetErrorText(sc)
		
		//s pResponse.patientsList = json
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.getPatientInfo">
    <Method>getPatientInfo</Method>
  </MapItem>
</MapItems>
}

}
