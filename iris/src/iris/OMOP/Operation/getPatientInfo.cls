/// Step 1
/// Get information about patient
Class OMOP.Operation.getPatientInfo Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method getPatientInfo(pRequest As OMOP.Request.getPatientInfo, Output pResponse As OMOP.Response.getPatientInfo) As %Status
{
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = "SELECT id, BirthTime, Race_Code, Race_Description, "_
					"EthnicGroup_Code, EthnicGroup_Description, "_
					"Address_Street, Address_City_Description, "_
					"Address_CountRy_Code, Address_State_Code, Address_Zip_Code, "_
					"Gender_Code, Gender_Description, "_
					"RawGender_Code, RawGender_Description, "_
					"BirthGender_Code, BirthGender_Description, "_
					"Deceased, DeathTime "_
				"FROM HSAA.Patient as p "_
				"WHERE ID = ?"
				
		
		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.patientId)
		;q:$$$ISERR(sc) 
		
		set rs=##class(%ResultSet).%New()
		Set sc=rs.Prepare(sql)
		quit:$$$ISERR(sc)

		set sc=rs.Execute(pRequest.patientId)
		quit:$$$ISERR(sc)
		
		while rs.Next() {
			s pResponse.id = rs.GetDataByName("id")
			s:pResponse.id="" pResponse.id = rs.GetDataByName("ID")
			
			s pResponse.birthTime = rs.GetDataByName("BirthTime")
			s pResponse.raceCode = rs.GetDataByName("Race_Code")
			s pResponse.raceDescription = rs.GetDataByName("Race_Description")
			s pResponse.ethnicGroupCode = rs.GetDataByName("EthnicGroup_Code")
			s pResponse.ethnicGroupDescription = rs.GetDataByName("EthnicGroup_Description")
			
			s pResponse.addressStreet = rs.GetDataByName("Address_Street")
			s pResponse.addressCityDescription = rs.GetDataByName("Address_City_Description")
			s pResponse.addressCountRyCode = rs.GetDataByName("Address_CountRy_Code")
			s pResponse.addressStateCode = rs.GetDataByName("Address_State_Code")
			s pResponse.addressZipCode = rs.GetDataByName("Address_Zip_Code")

			s pResponse.genderCode = rs.GetDataByName("Gender_Code")
			s pResponse.genderDescription = rs.GetDataByName("Gender_Description")
			s pResponse.rawGenderCode = rs.GetDataByName("RawGender_Code")
			s pResponse.rawGenderDescription = rs.GetDataByName("RawGender_Description")
			s pResponse.birthGenderCode = rs.GetDataByName("BirthGender_Code")

			s pResponse.birthGenderDescription = rs.GetDataByName("BirthGender_Description")
			s pResponse.deceased = rs.GetDataByName("Deceased")
			s pResponse.deathTime = rs.GetDataByName("DeathTime")
			
		}
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.getPatientInfo">
    <Method>getPatientInfo</Method>
  </MapItem>
</MapItems>
}

}
