/// 
/// Step 5 - Find CareProvider using patientId and keep careProviderId
/// 
Class OMOP.Operation.getPatientIdFromPosatgreSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.getCareProviderBO, Output pResponse As OMOP.Response.getCareProviderBO) As %Status
{
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = "SELECT TOP 1 c.patient, c.CareProvider, c.Clinician_Description, f.* "_
				"FROM HSAA.ClinicalRelationship as c "_
				"left join (SELECT id, Description, Address_City_Code, Address_State_Code, Address_Street, Address_Zip_Code from HSAA.CareProvider) f "_
				"on c.CareProvider = f.id "_
				"WHERE clinician_careprovidertype_description = 'Primary Care Provider' and facilitycode = 'Baystate' and c.patient = "_pRequest.patientId
				
		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.patientId)
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.patientId)
		quit:$$$ISERR(tSC)
		
		
		set careProviderId = ""
		s cntr = 0
		while rs.Next() {
			s cntr = cntr + 1
			continue:cntr'=1
			s careProviderId = rs.GetDataByName("CareProvider")
		}

		s pResponse.CareProviderId = $g(careProviderId)
		
		d rs.Close()
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.getCareProviderBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
