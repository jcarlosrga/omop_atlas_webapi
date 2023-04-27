/// 
/// 20220414 Denis Bulashev
/// return personId by patientId from PostgreSQL
/// 
Class OMOP.Operation.getPersonIdFromPostgreSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.getPersonIdFromPostgreSQLBO, Output pResponse As OMOP.Response.getPersonIdFromPostgreSQLBO) As %Status
{
	s sc = $$$OK
	
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		set sql = "SELECT person_id FROM person WHERE person_source_value LIKE '"_pRequest.personId_"|%' LIMIT 1" 
		
		$$$TRACE(sql)
		
		#dim rs As EnsLib.SQL.GatewayResultSet
		set sc = ..Adapter.ExecuteQuery(.rs, sql)
		quit:$$$ISERR(sc)
		
		while rs.Next() {
			do pResponse.personId.Insert(rs.GetDataByName("person_id"))
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
  <MapItem MessageType="OMOP.Request.getPersonIdFromPostgreSQLBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
