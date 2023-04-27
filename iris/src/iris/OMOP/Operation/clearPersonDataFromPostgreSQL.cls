/// 
/// 20220414 Denis Bulashev
/// clear stored data from postgreSQL by patientId
/// 
Class OMOP.Operation.clearPersonDataFromPostgreSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.clearPersonDataFromPostgreSQLBO, Output pResponse As OMOP.Response.clearPersonDataFromPostgreSQLBO) As %Status
{
	s sc = $$$OK
	
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		
		; delete records from tables
		for tblName = "visit_occurrence", "visit_detail", "specimen", "procedure_occurrence", "payer_plan_period", "observation_period", "observation", "note", "measurement", "drug_exposure", "device_exposure", "death", 
			"condition_occurrence", "condition_era", "person" {
			set sql = "DELETE FROM "_tblName_" WHERE person_id = "_pRequest.personId
			set sc = ..Adapter.ExecuteUpdate(.rowsCount, sql)
			quit:$$$ISERR(sc)
		}

	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.clearPersonDataFromPostgreSQLBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
