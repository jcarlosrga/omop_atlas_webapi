/// 20211108 Denis Bulashev
/// Method checks whether we have already had location in IRIS (for now) database or not
Class OMOP.Operation.checkCareSiteInIRIS Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.checkCareSiteInIrisBO, Output pResponse As OMOP.Response.checkCareSiteInIrisBO) As %Status
{
	; #include %occInclude
	Set sc = $$$OK
	Try{
		#dim rs As EnsLib.SQL.GatewayResultSet
		
		Set pResponse = ##class(OMOP.Response.checkCareSiteInIrisBO).%New()
		
		Set sql = "SELECT care_site_id FROM care_site "_
				"WHERE care_site_source_value = ? "
		
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.address1, pRequest.address2, pRequest.city, pRequest.state, pRequest.zip, pRequest.county, pRequest.locationSourceValue)
		;q:$$$ISERR(sc)
		
		Set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		Quit:$$$ISERR(tSC)

		Set tSC=rs.Execute(pRequest.sourceValue)
		Quit:$$$ISERR(tSC)
		
		
		Set pResponse.careSiteId = 0
		While rs.Next() {
			Set pResponse.careSiteId = rs.GetDataByName("care_site_id")
		}
		
		Do rs.Close()
		
	} Catch e {
		Set sc = e.AsStatus()
	}
	
	Quit sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.checkCareSiteInIrisBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
