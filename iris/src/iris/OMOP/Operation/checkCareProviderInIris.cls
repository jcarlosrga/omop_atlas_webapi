Class OMOP.Operation.checkCareProviderInIris Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.checkCareProviderInIrisBO, Output pResponse As OMOP.Response.checkCareProviderInIrisBO) As %Status
{
	; #include %occInclude
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = "SELECT provider_id "_
				"FROM provider "_
				"WHERE provider_source_value = ?"
		
		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.careProviderId)
		;q:$$$ISERR(sc) 
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.providerSourceValue)
		quit:$$$ISERR(tSC)
		
		s pResponse.careProviderId = 0
		while rs.Next(.sc) {
			q:$$$ISERR(sc)
			
			s pResponse.careProviderId = rs.GetDataByName("provider_id")
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
  <MapItem MessageType="OMOP.Request.checkCareProviderInIrisBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
