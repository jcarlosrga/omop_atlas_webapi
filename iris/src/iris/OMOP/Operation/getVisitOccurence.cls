/// 
/// 20211005 Denis Bulashev
/// Step 11 - Create Visit_occurrence
/// 
Class OMOP.Operation.getVisitOccurence Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method onRequest(pRequest As OMOP.Request.getVisitOccurenceBO, Output pResponse As OMOP.Response.getVisitOccurenceBO) As %Status
{
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
		
		s sql = "SELECT id, patient, EncounterType, StartTime, FromTime, EndTime, ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, AttendingClinician_SDACodingStandard, LOS, "_
				"AdmissionSource_Code, DischargeDisposition_Code "_
				"FROM HSAA.Encounter "_
				"WHERE patient = ? and TagFacility='BayState' "_
				"order by StartTime"
				


		#dim rs As EnsLib.SQL.GatewayResultSet
		; disabled
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.patientId)
		
		set rs=##class(%ResultSet).%New()
		Set tSC=rs.Prepare(sql)
		quit:$$$ISERR(tSC)

		set tSC=rs.Execute(pRequest.patientId)
		quit:$$$ISERR(tSC)
		
		while rs.Next() {
			s visitOccurrence = ##class(OMOP.Proxy.visitOccurenceItem).%New()
			d pResponse.occurencies.Insert(visitOccurrence)
			
			s visitOccurrence.id = rs.GetDataByName("ID")
			s visitOccurrence.patient = pRequest.personId	;rs.GetDataByName("patient")
			s visitOccurrence.encounterType = rs.GetDataByName("EncounterType")
			s visitOccurrence.startTime = rs.GetDataByName("StartTime")
			s visitOccurrence.fromTime = rs.GetDataByName("FromTime")
			s visitOccurrence.endTime = rs.GetDataByName("EndTime")
			s visitOccurrence.toTime = rs.GetDataByName("ToTime")
			s visitOccurrence.site = rs.GetDataByName("Site")
			s visitOccurrence.admittingClinicianDescription = rs.GetDataByName("AdmittingClinician_Description")
			s visitOccurrence.admissionSourceCode = rs.GetDataByName("AdmissionSource_Code")
			s visitOccurrence.dischargeDispositionCode = rs.GetDataByName("DischargeDisposition_Code")
			s visitOccurrence.lastUpdated = rs.GetDataByName("LastUpdated")
			s visitOccurrence.attendingClinicianCode = rs.GetDataByName("AttendingClinician_Code")
			s visitOccurrence.attendingClinicianSDACodingStandard = rs.GetDataByName("AttendingClinician_SDACodingStandard")
			s visitOccurrence.LOS = rs.GetDataByName("LOS")
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
  <MapItem MessageType="OMOP.Request.getVisitOccurenceBO">
    <Method>onRequest</Method>
  </MapItem>
</MapItems>
}

}
