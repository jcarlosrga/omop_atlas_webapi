/// 20211108 Denis Bulashev
/// Method checks whether we have already had location in IRIS (for now) database or not
Class OMOP.Operation.checkCareProviderInfoInIRIS Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Response.getCareProviderInfoBO, Output pResponse As OMOP.Response.checkCareProviderInfoBO) As %Status
{
	; #include %occInclude
	s sc = $$$OK
	try{
		#dim rs As EnsLib.SQL.GatewayResultSet
		
		s pResponse = ##class(OMOP.Response.checkCareProviderInfoBO).%New()
		
		s sql = "SELECT location_id FROM SQLUser.provider WHERE ((provider_name=?) or (provider_name is NULL)) "_
				"AND ((npi = ?) or (npi is NULL)) "_
				"AND ((dea = ?) or (dea is NULL)) "_
				"AND ((provider_source_value = ?) or (provider_source_value is NULL)) "_
				"AND ((specialty_source_value = ?) or (specialty_source_value is NULL))"
		$$$TRACE(sql)
		; disabled
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.Description, pRequest.NationalProviderID, pRequest.DEANumber, (pRequest.state_"|"_pRequest.SDACodingStandard_"|"_pRequest.LastUpdated), pRequest.Specialty)
		;q:$$$ISERR(sc)
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.Description, pRequest.NationalProviderID, pRequest.DEANumber, (pRequest.state_"|"_pRequest.SDACodingStandard_"|"_pRequest.LastUpdated), pRequest.Specialty)
		quit:$$$ISERR(tSC)
		
		s ColumnCount=rs.GetColumnCount()
		
		s cc = 0
		while rs.Next() {
			s providerId = rs.GetDataByName("provider_id")
		}
		s pResponse.providerId = $g(providerId)
		
		d rs.Close()
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Response.getCareProviderInfoBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
