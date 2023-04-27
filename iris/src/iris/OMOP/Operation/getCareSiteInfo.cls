/// 
/// 20211108 Denis Bulashev
/// Operation get information about care site from database
/// 
Class OMOP.Operation.getCareSiteInfo Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.getCareSiteInfoBO, Output pResponse As OMOP.Response.getCareSiteInfoBO) As %Status
{
	; #include %occInclude
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		q:pRequest.careProviderId=""
		
		s sql = "SELECT distinct f.* "_
				"FROM HSAA.ClinicalRelationship AS c "_
				"LEFT JOIN (SELECT id, Description, Address_City_Code, Address_State_Code, Address_Street, Address_Zip_Code, Address_Country_Code from HSAA.CareProvider) f "_
				"ON c.CareProvider = f.id "_
				"WHERE clinician_careprovidertype_description = 'Primary Care Provider' AND facilitycode = 'Baystate' AND c.CareProvider = ?"


		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.careProviderId)
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.careProviderId)
		quit:$$$ISERR(tSC)
		
		s sc = rs.Next()
		s pResponse.ID = rs.GetDataByName("ID")
		s pResponse.Description = rs.GetDataByName("Description")
		s pResponse.AddressCityCode = rs.GetDataByName("Address_City_Code")
		s pResponse.AddressStateCode = rs.GetDataByName("Address_State_Code")
		s pResponse.AddressStreet = rs.GetDataByName("Address_Street")
		s pResponse.AddressZipCode = rs.GetDataByName("Address_Zip_Code")
		s pResponse.AddressCountryCode = rs.GetDataByName("Address_Country_Code")
		
		d rs.Close()
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.getCareSiteInfoBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
