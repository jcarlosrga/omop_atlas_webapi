Class OMOP.Utils.DSNTest [ Abstract ]
{

/// d ##class(OMOP.Utils.DSNTest).jdbcTest1()
ClassMethod jdbcTest1()
{
	s res = ##class(OMOP.Utils.DSNTest).TestJDBCConnection("PostgresJDBC")
	w res,!
	q:res'=""
	
	s res = ""
	try{
		#include %occInclude
   		//Create new Gateway connection object
	   	set gc=##class(%SQLGatewayConnection).%New()
	   	if gc=$$$NULLOREF w "Cannot create %SQLGatewayConnection." q
	   	
		set pDSN="PostgresJDBC"	;"PGODBCTest"	;"UserunixodbcHI"
		set usr="overevkina"	;"overevkina"
		set pwd="overevkina"	;"Fls2020fls20"
		
		set sc=gc.Connect(pDSN,usr,pwd,0)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc) q
		
		if gc.ConnectionHandle="" w "Connection failed" q
		
		set sc=gc.AllocateStatement(.hstmt)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc) q
		
		//Prepare statement for execution
		set pQuery= "select * from Sample.Person"
		s pQuery = "SELECT ID, DiscardOnShutdown, DurationInSeconds, Timeout FROM Ens.AlarmRequest"
		s pQuery = "SELECT TOP 1 * FROM HSAA.Patient" 
		;s pQuery = "SELECT TOP 1 * FROM pg_type" 
		set sc=gc.Prepare(hstmt,pQuery)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc) q
		
		//Execute statement
		set sc=gc.Execute(hstmt)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc) q
		//Get list of columns returned by query
		set sc=gc.DescribeColumns(hstmt, .columnlist)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc) q
		
		//display column headers delimited by ":"
		set numcols=$listlength(columnlist)-1  //get number of columns
		for colnum=2:1:numcols+1 {
		  Write $listget($listget(columnlist,colnum),1),":"
		}
		write !
		
		//Return first 200 rows
		set sc=gc.Fetch(hstmt)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc)
		
		set rownum=1
		while((gc.sqlcode'=100) && (rownum<=200)) {
		  for ii=1:1:numcols {
		     set sc=gc.GetData(hstmt, ii, 1, .val)
		     write " "_val
		     if $$$ISERR(sc) break
		  }
		  set rownum=rownum+1
		  write !
		  set sc=gc.Fetch(hstmt)
		  if $$$ISERR(sc) break
		}
		
		//Close cursor and then disconnect
		set sc=gc.CloseCursor(hstmt)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc)

		set sc=gc.Disconnect()
		w $system.Status.GetErrorText(sc)
		
		w "Ok"
	} catch e {
		s sc = e.AsStatus()
		w $system.Status.GetErrorText(sc)
	}
	q res
}

/// Test JDBC Connection ClassMethod
/// s res=##class(CB.Operation.Main).TestJDBCConnection("test1")
/// res="" - OK
/// res'="" - Error
ClassMethod TestJDBCConnection(ConnectionName As %String) As %String
{
	s res = ""	
	s sc = $system.SQLGateway.TestConnection(ConnectionName,, 0, .error)
	i $$$ISERR(sc) {
		i $l(error)=1 s error=""
		i error'="" {
			s res = error
		} else {
			s res = "Error connection. Connection Name="_ConnectionName_". "_$system.Status.GetErrorText(sc)
		}
	}
	
	q res
}

/// d ##class(OMOP.Utils.DSNTest).test7()
ClassMethod test7()
{
	s res = ""
	try{
		Set Connection=##class(%SQLGatewayConnection).%New()
		
		set pDSN="UserunixodbcHI"	;"PGODBCTest"	;"UserunixodbcHI"	;"PGODBCTest"	;"UserunixodbcHI"
		set usr=""	;"overevkina"
		set pwd=""	;"Fls2020fls20"
		
		set sc=Connection.Connect(pDSN,usr,pwd,0)
		if $$$ISERR(sc) w "Connection error ",$system.Status.GetErrorText(sc) q
		
		Set ResSet=##class(%ResultSet).%New("%DynamicQueryGW:SQLGW")
		
		s SQL = "SELECT * from mytable"
		s SQL = "SELECT ID, DiscardOnShutdown, DurationInSeconds, Timeout FROM Ens.AlarmRequest"
		d $system.OBJ.DisplayError(ResSet.Prepare(SQL,,Connection))

		d $system.OBJ.DisplayError(ResSet.Execute())
		
	} catch e {
		s sc = e.AsStatus()
		w $system.Status.GetErrorText(sc)
	}
	q res
}

/// d ##class(OMOP.Utils.DSNTest).test6()
ClassMethod test6()
{
	s res = ""
	try{
		#include %occInclude
   		//Create new Gateway connection object
	   	set gc=##class(%SQLGatewayConnection).%New()
	   	if gc=$$$NULLOREF w "Cannot create %SQLGatewayConnection." q
	   	
		set pDSN="UserunixodbcHI"	;"PGODBCTest"	;"UserunixodbcHI"
		set usr=""	;"overevkina"
		set pwd=""	;"Fls2020fls20"
		
		set sc=gc.Connect(pDSN,usr,pwd,0)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc) q
		
		if gc.ConnectionHandle="" w "Connection failed" q
		
		set sc=gc.AllocateStatement(.hstmt)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc) q
		
		//Prepare statement for execution
		set pQuery= "select * from Sample.Person"
		s pQuery = "SELECT ID, DiscardOnShutdown, DurationInSeconds, Timeout FROM Ens.AlarmRequest"
		s pQuery = "SELECT TOP 1 * FROM HSAA.Patient" 
		;s pQuery = "SELECT TOP 1 * FROM pg_type" 
		set sc=gc.Prepare(hstmt,pQuery)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc) q
		
		//Execute statement
		set sc=gc.Execute(hstmt)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc) q
		//Get list of columns returned by query
		set sc=gc.DescribeColumns(hstmt, .columnlist)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc) q
		
		//display column headers delimited by ":"
		set numcols=$listlength(columnlist)-1  //get number of columns
		for colnum=2:1:numcols+1 {
		  Write $listget($listget(columnlist,colnum),1),":"
		}
		write !
		
		//Return first 200 rows
		set sc=gc.Fetch(hstmt)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc)
		
		set rownum=1
		while((gc.sqlcode'=100) && (rownum<=200)) {
		  for ii=1:1:numcols {
		     set sc=gc.GetData(hstmt, ii, 1, .val)
		     write " "_val
		     if $$$ISERR(sc) break
		  }
		  set rownum=rownum+1
		  write !
		  set sc=gc.Fetch(hstmt)
		  if $$$ISERR(sc) break
		}
		
		//Close cursor and then disconnect
		set sc=gc.CloseCursor(hstmt)
		if $$$ISERR(sc) w $system.Status.GetErrorText(sc)

		set sc=gc.Disconnect()
		w $system.Status.GetErrorText(sc)
		
		w "Ok"
	} catch e {
		s sc = e.AsStatus()
		w $system.Status.GetErrorText(sc)
	}
	q res
}

}
