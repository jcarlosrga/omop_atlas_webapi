/// step 0
/// get patients list for future processing
/// 
/// 20220418 Denis Bulashev
/// 				HASS.PatientList table was added
Class OMOP.Operation.getPatientsList Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Parameter SETTINGS = "SendLocalRequest:Basic";

/// Send request to the same namespace where production is running. In this case adapter don't use connection via JDBC
Property SendLocalRequest As %Boolean;

Method getPatientInfo(pRequest As OMOP.Request.getPatientsList, Output pResponse As OMOP.Response.getPatientsList) As %Status
{
	s sc = $$$OK
	try{
		; get records from source table one by one
		
		set sc = pRequest.NewResponse(.pResponse) 
		quit:$$$ISERR(sc) 
		
		set sql1 = "SELECT TOP 1 patient_id FROM HSAA.PatientList"
		set sql2 = "DELETE FROM HSAA.PatientList WHERE patient_id = ?"
		
		while 1 {
			set patientId = ""
			if ..SendLocalRequest {
				; local call
				set rset=##class(%ResultSet).%New()
				set sc=rset.Prepare(sql1)
				quit:$$$ISERR(sc)

				set sc=rset.Execute()
				quit:$$$ISERR(sc)
				
				do rset.Next(.sc)
				quit:$$$ISERR(sc)
				
				set patientId = rset.GetDataByName("patient_id")
				
				do rset.Close()
				
				; if record found - remove it from the source table
				if patientId '= "" {
					set sc=rset.Prepare(sql2)
					quit:$$$ISERR(sc)

					set sc=rset.Execute(patientId)
					quit:$$$ISERR(sc)
					
					do rset.Close()
				}
				
			
			} else {
				; remote call
				#dim rs As EnsLib.SQL.GatewayResultSet
				s sc = ..Adapter.ExecuteQuery(.rs, sql1)
				q:$$$ISERR(sc) 
				
				d rs.Next(.sc)
				quit:$$$ISERR(sc)
				
				set patientId = rs.GetDataByName("patient_id")
				
				; if record found - remove it from the source table
				if patientId '= "" {
					d ..Adapter.ExecuteUpdate(.rs, sql, patientId)
				}
				
			}
			
			q:patientId=""
			
			d pResponse.patientsList.Insert(patientId)
			
		}
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.getPatientsList">
    <Method>getPatientInfo</Method>
  </MapItem>
</MapItems>
}

}
