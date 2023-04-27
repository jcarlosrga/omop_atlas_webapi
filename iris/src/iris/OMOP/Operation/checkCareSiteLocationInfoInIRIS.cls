/// 20211108 Denis Bulashev
/// Method checks whether we have already had location in IRIS (for now) database or not
Class OMOP.Operation.checkCareSiteLocationInfoInIRIS Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.saveCareLocationInfoBO, Output pResponse As OMOP.Response.checkCareLocationInfoBO) As %Status
{
	; #include %occInclude
	s sc = $$$OK
	try{
		#dim rs As EnsLib.SQL.GatewayResultSet
		
		s pResponse = ##class(OMOP.Response.checkCareLocationInfoBO).%New()
		
		s sql = "SELECT location_id FROM SQLUser.location WHERE ((address_1=?) or (address_1 is NULL)) "_
				"AND ((address_2 = ?) or (address_2 is NULL)) "_
				"AND ((city = ?) or (city is NULL)) "_
				"AND ((state = ?) or (state is NULL)) "_
				"AND ((zip = ?) or (zip is NULL)) "_
				"AND ((county = ?) or (county is NULL)) "_
				"AND ((location_source_value = ?) or (location_source_value is NULL)) "
		
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.address1, pRequest.address2, pRequest.city, pRequest.state, pRequest.zip, pRequest.county, pRequest.locationSourceValue)
		;q:$$$ISERR(sc)
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.address1, pRequest.address2, pRequest.city, pRequest.state, pRequest.zip, pRequest.county, pRequest.locationSourceValue)
		quit:$$$ISERR(tSC)
		
		s ColumnCount=rs.GetColumnCount()
		
		s cc = 0
		while rs.Next() {
			s locationId = rs.GetDataByName("location_id")		; .GetData(0)	;	
		}
		s pResponse.locationId = $g(locationId)
		
		d rs.Close()
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.saveCareLocationInfoBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
