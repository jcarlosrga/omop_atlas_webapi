/// 20211025 Denis Bulashev
/// step ...
/// collect information for event table
/// 
Class OMOP.Operation.getConditionData Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method getPatientInfo(pRequest As OMOP.Request.getConditionDataBO, Output pResponse As OMOP.Response.getConditionDataBO) As %Status
{
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = "SELECT * "_
				"FROM eventTable "_
				"WHERE encounter = ?"
				
		$$$TRACE(sql)
		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.visitOccurrenceId)
		;q:$$$ISERR(sc) 
		
		;for i=1:1:rs.GetColumnCount(){
		;	$$$TRACE(rs.GetColumnName(i))
		;}
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute()
		quit:$$$ISERR(tSC)
		
		
		while rs.Next() {
			s conditionItem = ##class(OMOP.Proxy.conditionItem).%New()
			s conditionItem.ID = rs.GetDataByName("ID")
			s conditionItem.encounter = rs.GetDataByName("encounter")
			s conditionItem.eventConceptId = rs.GetDataByName("eventConceptId")
			s conditionItem.eventEndTime = rs.GetDataByName("eventEndTime")
			s conditionItem.eventSourceValue = rs.GetDataByName("eventSourceValue")
			s conditionItem.eventStartTime = rs.GetDataByName("eventStartTime")
			s conditionItem.modifierConceptId = rs.GetDataByName("modifierConceptId")
			s conditionItem.modifierSourceValue = rs.GetDataByName("modifierSourceValue")
			s conditionItem.providerName = rs.GetDataByName("providerName")
			s conditionItem.qualifierConceptId = rs.GetDataByName("qualifierConceptId")
			s conditionItem.qualifierSourceValue = rs.GetDataByName("qualifierSourceValue")
			s conditionItem.routeConceptId = rs.GetDataByName("routeConceptId")
			s conditionItem.routeSourceValue = rs.GetDataByName("routeSourceValue")
			s conditionItem.sourceTable = rs.GetDataByName("sourceTable")
			s conditionItem.unitConceptId = rs.GetDataByName("unitConceptId")
			s conditionItem.unitSourceValue = rs.GetDataByName("unitSourceValue")
			s conditionItem.valueAsConceptId = rs.GetDataByName("valueAsConceptId")
			s conditionItem.valueSourceValue = rs.GetDataByName("valueSourceValue")
			
			
			d pResponse.events.Insert(conditionItem)
			
			d rs.Close()
		}
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.getConditionDataBO">
    <Method>getPatientInfo</Method>
  </MapItem>
</MapItems>
}

}

