Class OMOP.Operation.getCareProviderInfo Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.getCareProviderInfoBO, Output pResponse As OMOP.Response.getCareProviderInfoBO) As %Status
{
	; #include %occInclude
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		q:pRequest.careProviderId=""
		
		s sql = "SELECT distinct p.ID, p.Code, p.Description, p.SDACodingStandard, p.NationalProviderID, p.DEANumber, p.Specialty, p.LastUpdated "_
				"FROM HSAA.ClinicalRelationship as c "_
				"JOIN HSAA.CareProvider as p ON p.ID = c.careprovider "_
				"WHERE c.CareProvider = ?"
		
		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.careProviderId)
		;q:$$$ISERR(sc) 
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.careProviderId)
		quit:$$$ISERR(tSC)
		
		do rs.Next(.sc)
		q:$$$ISERR(sc)
		
		s pResponse.Description = rs.GetDataByName("Description")
		s pResponse.NationalProviderID = rs.GetDataByName("NationalProviderID")
		s pResponse.DEANumber = rs.GetDataByName("DEANumber")
		s pResponse.Specialty = rs.GetDataByName("Specialty")
		s pResponse.Code = rs.GetDataByName("Code")
		s pResponse.SDACodingStandard = rs.GetDataByName("SDACodingStandard")
		s pResponse.LastUpdated = rs.GetDataByName("LastUpdated")
		
		
		d rs.Close()
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.getCareProviderInfoBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
