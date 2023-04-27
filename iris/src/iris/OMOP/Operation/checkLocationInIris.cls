/// 
/// Get information about location of a patient
/// 
Class OMOP.Operation.checkLocationInIris Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.checkLocationInIrisBO, Output pResponse As OMOP.Response.checkLocationInIrisBO) As %Status
{
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = "SELECT location_id FROM location "_
						"WHERE location_source_value = ?"
				
		
		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.patientId)
		;q:$$$ISERR(sc) 
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.sourceValue)
		quit:$$$ISERR(tSC)
		
		s pResponse.locationExists = 0
		while rs.Next() {
			s pResponse.locationExists = rs.GetDataByName("location_id")
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
  <MapItem MessageType="OMOP.Request.checkLocationInIrisBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
