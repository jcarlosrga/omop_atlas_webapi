/// step 9
/// get patient info from BayState database
Class OMOP.Operation.getPerson Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method getPatientInfo(pRequest As OMOP.Request.getPersonBP, Output pResponse As OMOP.Response.getPersonBP) As %Status
{
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = "SELECT id, BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description, CreatedOn, "_
				"Gender_Code, RawGender_Code, BirthGender_Code "_
				"FROM HSAA.Patient "_
				"WHERE ID = "_pRequest.patientId
		
		#dim rs As EnsLib.SQL.GatewayResultSet
		; disabled
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.patientId)
		;q:$$$ISERR(sc) 
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.patientId)
		quit:$$$ISERR(tSC)
		
		while rs.Next() {
			s pResponse.id = rs.GetDataByName("id")
			s pResponse.birthTime = rs.GetDataByName("BirthTime")
			s pResponse.raceCode = rs.GetDataByName("Race_Code")
			s pResponse.raceDescription = rs.GetDataByName("Race_Description")
			s pResponse.ethnicGroupCode = rs.GetDataByName("EthnicGroup_Code")
			s pResponse.ethnicGroupDescription = rs.GetDataByName("EthnicGroup_Description")
			s pResponse.genderCode = rs.GetDataByName("Gender_Code")
			s pResponse.rawGenderCode = rs.GetDataByName("RawGender_Code")
			s pResponse.birthGenderCode = rs.GetDataByName("BirthGender_Code")
			s pResponse.createdOn= rs.GetDataByName("CreatedOn")
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
  <MapItem MessageType="OMOP.Request.getPersonBP">
    <Method>getPatientInfo</Method>
  </MapItem>
</MapItems>
}

}
