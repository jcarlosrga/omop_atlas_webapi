/// 
/// Get information about location of a patient
/// 
Class OMOP.Operation.getPatientLocation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.getPatientLocationBO, Output pResponse As OMOP.Response.getPatientLocationBO) As %Status
{
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = "SELECT ID, Address_City_Code, Address_City_Description, "_
						"Address_State_Code, Address_Street, Address_Zip_Code, Address_CountRy_Code "_
						"FROM HSAA.Patient p "_
						"WHERE ID = ?"
				
		
		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.patientId)
		;q:$$$ISERR(sc) 
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.patientId)
		quit:$$$ISERR(tSC)
		
		while rs.Next() {
			s pResponse.id = rs.GetDataByName("ID")
			s pResponse.addressCityCode = rs.GetDataByName("Address_City_Code")
			s pResponse.addressCityDescription = rs.GetDataByName("Address_City_Description")
			s pResponse.addressStateCode = rs.GetDataByName("Address_State_Code")
			s pResponse.addressStreet = rs.GetDataByName("Address_Street")
			s pResponse.addressZipCode = rs.GetDataByName("Address_Zip_Code")
			s pResponse.addressCountRyCode = rs.GetDataByName("Address_CountRy_Code")
			
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
  <MapItem MessageType="OMOP.Request.getPatientLocationBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
