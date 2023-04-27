/// step 0
/// Upload information about sites, locations and provides
Class OMOP.Operation.prestepsGetProviderData Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As Ens.Request, Output pResponse As OMOP.Response.prestepsGetProviderDataBP) As %Status
{
	s sc = $$$OK
	try{
		s pResponse = ##class(OMOP.Response.prestepsGetProviderDataBP).%New()
		q:$$$ISERR(sc) 
		
		set sql = "select "_
				"cp.id, cp.code as BHSID, cp.description as Provider, cp.SDACodingStandard as SDACode, "_
				"cps.startdate, cps.enddate, cps.lastupdated, "_
				"s.id as SiteID, s.rawname as Site, "_
				"hcf.code as HCFID, hcf.description as HCFacility, hcf.rawname as HCFName, cp.NationalProviderID, cp.DEANumber "_
				"from hsaa.careprovider cp "_
				"inner join hsaa.careprovidersite cps "_
				"on cp.id = cps.careprovider "_
				"inner join (select careprovider, max(lastupdated) as lastupdated from hsaa.careprovidersite group by careprovider) cps_max "_
				"on cps.careprovider = cps_max.careprovider "_
				"and cps.lastupdated = cps_max.lastupdated "_
				"inner join hsaa.site s "_
				"on cps.site = s.id "_
				"inner join hsaa.healthcarefacility hcf "_
				"on s.healthcarefacility = hcf.id "_
				"where cp.code != cp.description "_
				"order by BHSID, SDACode, lastupdated desc"
		
		#dim rs As EnsLib.SQL.GatewayResultSet
		s sc = ..Adapter.ExecuteQuery(.rs, sql)
		q:$$$ISERR(sc) 
		
		while rs.Next() {
			s dataItem = ##class(OMOP.Proxy.prestepsGetProviderDataItem).%New()
			
			s dataItem.ID = rs.GetDataByName("ID")
			s dataItem.BHSID = rs.GetDataByName("BHSID")
			s dataItem.Provider = rs.GetDataByName("Provider")
			s dataItem.SDACode = rs.GetDataByName("SDACode")
			s dataItem.StartDate = rs.GetDataByName("StartDate")
			s dataItem.EndDate = rs.GetDataByName("EndDate")
			s dataItem.LastUpdated = rs.GetDataByName("LastUpdated")
			s dataItem.SiteID = rs.GetDataByName("SiteID")
			s dataItem.Site = rs.GetDataByName("Site")
			s dataItem.HCFID = rs.GetDataByName("HCFID")
			s dataItem.HCFacility = rs.GetDataByName("HCFacility")
			s dataItem.HCFName = rs.GetDataByName("HCFName")
			
			d pResponse.items.Insert(dataItem)
		}
		
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
