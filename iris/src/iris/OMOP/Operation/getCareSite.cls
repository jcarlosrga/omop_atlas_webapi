/// 
/// Step 6 - Find care site using provider data
/// 
Class OMOP.Operation.getCareSite Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.getCareSiteBO, Output pResponse As OMOP.Response.getCareSiteBO) As %Status
{
	; #include %occInclude
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc)
		
		s sql = "SELECT distinct f.* "_
				"FROM HSAA.ClinicalRelationship as c "_
				"left join (SELECT id, Description, Address_City_Code, Address_State_Code, Address_Street, Address_Zip_Code from HSAA.CareProvider) f "_
				"on c.CareProvider = f.id "_
				"WHERE clinician_careprovidertype_description = 'Primary Care Provider' and facilitycode = 'Baystate' and c.CareProvider = ?"
				
		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.careProviderId)
		;q:$$$ISERR(sc)
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.careProviderId)
		quit:$$$ISERR(tSC)

		s CareSiteId=""
		s cntr = 0
		while rs.Next() {
			s cntr = cntr + 1
			continue:cntr'=1
			s CareSiteId = rs.GetDataByName("id")
			s:CareSiteId="" CareSiteId = rs.GetDataByName("ID")
		}

		s pResponse.CareSiteId = $g(CareSiteId)
		
		d rs.Close()
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.getCareSiteBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
