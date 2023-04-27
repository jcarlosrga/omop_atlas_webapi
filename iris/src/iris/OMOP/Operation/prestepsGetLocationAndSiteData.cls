/// step 9
/// get patient info from BayState database
Class OMOP.Operation.prestepsGetLocationAndSiteData Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As Ens.Request, Output pResponse As OMOP.Response.prestepsGetLocationAndSiteDataBP) As %Status
{
	s sc = $$$OK
	try{
		s pResponse = ##class(OMOP.Response.prestepsGetLocationAndSiteDataBP).%New()
		q:$$$ISERR(sc) 
		
		s sql = "SELECT distinct s.* from HSAA.Site s "_
				"JOIN HSAA.Encounter as e ON s.id=e.site "_
				"WHERE TagFacility='Baystate'"
		
		#dim rs As EnsLib.SQL.GatewayResultSet
		; disabled
		;s sc = ..Adapter.ExecuteQuery(.rs, sql)
		;q:$$$ISERR(sc) 
		
		set rs=##class(%ResultSet).%New()
		Set sc=rs.Prepare(sql)
		quit:$$$ISERR(sc)

		set sc=rs.Execute()
		quit:$$$ISERR(sc)
		
		while rs.Next() {
			s dataItem = ##class(OMOP.Proxy.prestepsGetLocationAndSiteDataItem).%New()
			s dataItem.ID = rs.GetDataByName("ID")
			s dataItem.HealthCareFacility = rs.GetDataByName("HealthCareFacility")
			s dataItem.IsPractice = rs.GetDataByName("IsPractice")
			s dataItem.LastUpdated = rs.GetDataByName("LastUpdated")
			s dataItem.Name = rs.GetDataByName("Name")
			s dataItem.RawName = rs.GetDataByName("RawName")
			
			d pResponse.items.Insert(dataItem)
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
  <MapItem MessageType="Ens.Request">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
