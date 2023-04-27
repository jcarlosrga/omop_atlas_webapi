/// step 10
/// get death info from BayState database
Class OMOP.Operation.getDeath Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method getPatientInfo(pRequest As OMOP.Request.getDeathBO, Output pResponse As OMOP.Response.getDeathBO) As %Status
{
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = "SELECT ID, DeathTime, Deceased "_
				"FROM HSAA.Patient where Deceased = 1 and DeathTime is not null and ID = "_pRequest.patientId
				
		
		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.patientId)
		;q:$$$ISERR(sc) 
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute()
		quit:$$$ISERR(tSC)
		
		while rs.Next() {
			s pResponse.id = rs.GetDataByName("ID")
			s pResponse.deathTime = rs.GetDataByName("DeathTime")
			s pResponse.deceased = rs.GetDataByName("Deceased")
		}
		
		d rs.Close()
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.getDeathBO">
    <Method>getPatientInfo</Method>
  </MapItem>
</MapItems>
}

}
