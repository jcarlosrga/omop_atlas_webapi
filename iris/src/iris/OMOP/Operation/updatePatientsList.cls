/// Recieve patients list from database for converting in OMOP
/// To Do: Rewrite like others Operations
/// Possible unused
Class OMOP.Operation.updatePatientsList Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method execSQL(pRequest As OMOP.Request.updatePatientsList, Output pResponse As OMOP.Response.updatePatientsList) As %Status
{
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = pRequest.SQL
		
	   	set gc=##class(%SQLGatewayConnection).%New()
	   	q:gc=$$$NULLOREF
	   	
		; !!!!
		set pDSN="UserunixodbcHI"
		set usr=""
		set pwd=""
		
		set sc=gc.Connect(pDSN,usr,pwd,0)
		q:$$$ISERR(sc)
		
		q:gc.ConnectionHandle=""
		
		set sc=gc.AllocateStatement(.hstmt)
		q:$$$ISERR(sc)
		
		//Prepare statement for execution
		s pQuery = sql
		
		set sc=gc.Prepare(hstmt,pQuery)
		q:$$$ISERR(sc)
		
		//Execute statement
		set sc=gc.Execute(hstmt)
		q:$$$ISERR(sc)
		
		//Get list of columns returned by query
		set sc=gc.DescribeColumns(hstmt, .columnlist)
		q:$$$ISERR(sc)
		

		set numcols=$listlength(columnlist)-1  //get number of columns
		
		//Return first 200 rows
		set sc=gc.Fetch(hstmt)
		q:$$$ISERR(sc)
		
		s json={"id":[]}
		set rownum=1
		while((gc.sqlcode'=100) && (rownum<=200)) {
			s row = {"data":[]}
		  	for ii=1:1:numcols {
		    	set sc=gc.GetData(hstmt, ii, 1, .val)
		     	d json."id".%Push(val)
		     	break:$$$ISERR(sc) 
		     	
		     	//d pResponse.patientId
		  	}
			set rownum=rownum+1
		  	set sc=gc.Fetch(hstmt)
		  	break:$$$ISERR(sc) 
		}
		
		//Close cursor and then disconnect
		set sc=gc.CloseCursor(hstmt)
		q:$$$ISERR(sc)

		set sc=gc.Disconnect()
		
		s pResponse.patientsList = json
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.updatePatientsList">
    <Method>execSQL</Method>
  </MapItem>
</MapItems>
}

}
