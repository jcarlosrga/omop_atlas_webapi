/// 20211025 Denis Bulashev
/// step ...
/// collect information for event table
/// 
Class OMOP.Operation.getEventData Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method getPatientInfo(pRequest As OMOP.Request.getEventDataBO, Output pResponse As OMOP.Response.getEventDataBO) As %Status
{
	s sc = $$$OK
	try{
		s sc = pRequest.NewResponse(.pResponse) 
		q:$$$ISERR(sc) 
				
		;$$$TRACE(sql)
		#dim rs As EnsLib.SQL.GatewayResultSet
		;s sc = ..Adapter.ExecuteQuery(.rs, sql, pRequest.patientId, pRequest.patientId, pRequest.patientId, pRequest.patientId, pRequest.patientId, pRequest.patientId, pRequest.patientId, pRequest.patientId, pRequest.patientId, pRequest.patientId, pRequest.patientId, pRequest.patientId)
		;q:$$$ISERR(sc) 
		
		;for i=1:1:rs.GetColumnCount(){
		;	$$$TRACE(rs.GetColumnName(i))
		;}
		
		set rs = ##class(%ResultSet).%New()
		set rs.ClassName=..%ClassName(1)
		set rs.QueryName="PatientInfoQuery"
		;Set sc = rs.Prepare(sql)

		quit:$$$ISERR(sc)

		set sc = rs.Execute(pRequest.patientId)
		quit:$$$ISERR(sc)
		
		while rs.Next() {
			s eventItem = ##class(OMOP.Proxy.eventItem).%New()
			s eventItem.encounter = rs.GetDataByName("Encounter")
			s eventItem.eventConceptId = rs.GetDataByName("event_concept_id")
			s eventItem.eventSourceValue = rs.GetDataByName("event_source_value")			
			s eventItem.eventStartTime = rs.GetDataByName("event_start_time")
			s eventItem.eventEndTime = rs.GetDataByName("event_end_time")
			s eventItem.eventEnteredonDate = rs.GetDataByName("event_enteredon_date")			
			s eventItem.providerName = rs.GetDataByName("provider_name")
			s eventItem.qualifierConceptId = rs.GetDataByName("qualifier_concept_id")
			s eventItem.qualifierSourceValue = rs.GetDataByName("qualifier_source_value")			
			s eventItem.unitConceptId = rs.GetDataByName("unit_concept_id")
			s eventItem.unitSourceValue = rs.GetDataByName("unit_source_value")
			s eventItem.routeSourceValue = rs.GetDataByName("route_source_value")
			s eventItem.valueAsConceptId = rs.GetDataByName("value_as_concept_id")
			s eventItem.valueSourceValue = rs.GetDataByName("value_source_value")
			s eventItem.quantity = rs.GetDataByName("quantity")
			s eventItem.sourceTable = rs.GetDataByName("source_table")
			s eventItem.sourceId =  rs.GetDataByName("source_id")
			s eventItem.note =  rs.GetDataByName("note")
			s eventItem.valueAsNumber =  rs.GetDataByName("value_as_number")
			s eventItem.rangeLow =  rs.GetDataByName("range_low")
			s eventItem.rangeHigh =  rs.GetDataByName("range_high")
			
			d pResponse.events.Insert(eventItem)
		}
		
		d rs.Close()
		
	} catch e {
		s sc = e.AsStatus()
	}
	
	q sc
}

Query PatientInfoQuery(patientId As %String) As %SQLQuery [ SqlProc ]
{
SELECT
    Encounter,
    Diagnosis_Code AS event_concept_id,
    Diagnosis_Description AS event_source_value,
    COALESCE(DiagnosisTime, EnteredOn) AS event_start_time,
    COALESCE(DiagnosisTime, EnteredOn) AS event_end_time,
    COALESCE(DiagnosisTime, EnteredOn) AS event_enteredon_date,
    STRING(
        DiagnosingClinician_Code,
        '|',
        DiagnosingClinician_SDACodingStandard
    ) AS provider_name,
    Null AS qualifier_concept_id,
    Null AS qualifier_source_value,
    Null AS unit_concept_id,
    Null AS unit_source_value,
    Null AS route_source_value,
    Diagnosis_Code AS value_as_concept_id,
    Diagnosis_Description AS value_source_value,
    Null AS quantity,
    'Diagnosis' AS source_table,
    id AS source_id,
    NULL AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.Diagnosis
WHERE
    patient = :patientId
    and (
        Diagnosis_Code IS NOT NULL
        OR Diagnosis_Description IS NOT NULL
    )
    and TagFacility = 'Baystate'
UNION
SELECT
    Null AS Encounter,
    Allergy_Code AS event_concept_id,
    Allergy_Description AS event_source_value,
    COALESCE(FromTime, ToTime) AS event_start_time,
    COALESCE(ToTime, FromTime) AS event_end_time,
    EnteredOn AS event_enteredon_date,
    STRING(Clinician_Code, '|', Clinician_SDACodingStandard) AS provider_name,
    Severity_Code AS qualifier_concept_id,
    Severity_Description AS qualifier_source_value,
    Null AS unit_concept_id,
    Null AS unit_source_value,
    Null AS route_source_value,
    Allergy_Code AS value_as_concept_id,
    Allergy_Description AS value_source_value,
    Null AS quantity,
    'Allergy' AS source_table,
    id AS source_id,
    Null AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.Allergy
WHERE
    patient = :patientId
    and (
        Allergy_Code IS NOT NULL
        OR Allergy_Description IS NOT NULL
    )
    and TagFacility = 'Baystate'
UNION
SELECT
    Null AS Encounter,
    Reaction_Code AS event_concept_id,
    Reaction_Description AS event_source_value,
    COALESCE(FromTime, ToTime) AS event_start_time,
    COALESCE(ToTime, FromTime) AS event_end_time,
    EnteredOn AS event_enteredon_date,
    STRING(Clinician_Code, '|', Clinician_SDACodingStandard) AS provider_name,
    Null AS qualifier_concept_id,
    Null AS qualifier_source_value,
    Null AS unit_concept_id,
    Null AS unit_source_value,
    Null AS route_source_value,
    Reaction_Code AS value_as_concept_id,
    Reaction_Description AS value_source_value,
    Null AS quantity,
    'AllergyReaction' AS source_table,
    id AS source_id,
    Null AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.Allergy
WHERE
    patient = :patientId
    and (
        Reaction_Code IS NOT NULL
        or Reaction_Description IS NOT NULL
    )
    and Reaction_Code != Allergy_Code
    and TagFacility = 'Baystate'
UNION
SELECT
    Encounter,
    ObservationCode_Code AS event_concept_id,
    ObservationCode_Description AS event_source_value,
    COALESCE(ObservationTime, EnteredOn) AS event_start_time,
    COALESCE(ObservationTime, EnteredOn) AS event_end_time,
    COALESCE(ObservationTime, EnteredOn) AS event_enteredon_date,
    STRING(Clinician_Code, '|', Clinician_SDACodingStandard) AS provider_name,
    Null AS qualifier_concept_id,
    Null AS qualifier_source_value,
    ObservationCode_ObservationValueUnits_Code AS unit_concept_id,
    ObservationCode_ObservationValueUnits_Description AS unit_source_value,
    Null AS route_source_value,
    ObservationRawValue AS value_as_concept_id,
    ObservationRawValue AS value_source_value,
    Null AS quantity,
    'Observation' AS source_table,
    id AS source_id,
    NULL AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.Observation
WHERE
    patient = :patientId
    and (
        ObservationCode_Code IS NOT NULL
        OR ObservationCode_Description IS NOT NULL
    )
    and TagFacility = 'Baystate'
UNION
SELECT
    Null AS Encounter,
    Problem_Code AS event_concept_id,
    Problem_Description AS event_source_value,
    COALESCE(FromTime, ToTime) AS event_start_time,
    COALESCE(ToTime, FromTime) AS event_end_time,
    EnteredOn AS event_enteredon_date,
    STRING(Clinician_Code, '|', Clinician_SDACodingStandard) AS provider_name,
    Null AS qualifier_concept_id,
    Null AS qualifier_source_value,
    Null AS unit_concept_id,
    Null AS unit_source_value,
    Null AS route_source_value,
    Problem_Code AS value_as_concept_id,
    Problem_Description AS value_source_value,
    Null AS quantity,
    'Problem' AS source_table,
    id AS source_id,
    NULL AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.Problem
WHERE
    patient = :patientId
    and (
        Problem_Code IS NOT NULL
        or Problem_Description IS NOT NULL
    )
    and TagFacility = 'Baystate'
UNION
SELECT
    Null AS Encounter,
    SocialHabit_Code AS event_concept_id,
    SocialHabit_Description AS event_source_value,
    COALESCE(FromTime, ToTime) AS event_start_time,
    COALESCE(ToTime, FromTime) AS event_end_time,
    EnteredOn AS event_enteredon_date,
    STRING(EnteredBy_Code, '|', EnteredBy_SDACodingStandard) AS provider_name,
    Null AS qualifier_concept_id,
    Null AS qualifier_source_value,
    Null AS unit_concept_id,
    Null AS unit_source_value,
    Null AS route_source_value,
    SocialHabitQty_Code AS value_as_concept_id,
    SocialHabitQty_Description AS value_source_value,
    Null AS quantity,
    'SocialHistory' AS source_table,
    id AS source_id,
    NULL AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.SocialHistory
WHERE
    patient = :patientId
    and (
        SocialHabit_Code IS NOT NULL
        or SocialHabit_Description IS NOT NULL
    )
    and TagFacility = 'Baystate'
UNION
SELECT
    Null AS Encounter,
    HSAAProcedure_Code AS event_concept_id,
    HSAAProcedure_Description AS event_source_value,
    COALESCE(ProcedureTime, EnteredOn) AS event_start_time,
    COALESCE(ProcedureTime, EnteredOn) AS event_end_time,
    COALESCE(ProcedureTime, EnteredOn) AS event_enteredon_date,
    STRING(Clinician_Code, '|', Clinician_SDACodingStandard) AS provider_name,
    Null AS qualifier_concept_id,
    Null AS qualifier_source_value,
    Null AS unit_concept_id,
    Null AS unit_source_value,
    Null AS route_source_value,
    HSAAProcedure_Code AS value_as_concept_id,
    HSAAProcedure_Description AS value_source_value,
    Null AS quantity,
    'Procedure' AS source_table,
    id AS source_id,
    NULL AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.HSAAProcedure
WHERE
    patient = :patientId
    and (
        HSAAProcedure_Code IS NOT NULL
        or HSAAProcedure_Description IS NOT NULL
    )
    and TagFacility = 'Baystate'
UNION
SELECT
    o.Encounter AS Encounter,
    o.OrderCode_Code AS event_concept_id,
    o.OrderCode_Description AS event_source_value,
    COALESCE(m.FromTime, o.EnteredOn) AS event_start_time,
    COALESCE(m.ToTime, o.EnteredOn) AS event_end_time,
    o.EnteredOn AS event_enteredon_date,
    STRING(
        o.OrderedBy_Code,
        '|',
        o.OrderedBy_SDACodingStandard
    ) AS provider_name,
    Null AS qualifier_concept_id,
    Null AS qualifier_source_value,
    m.DoseUoM_Code AS unit_concept_id,
    m.DoseUoM_Description AS unit_source_value,
    m.Route_Description AS route_source_value,
    Null AS value_as_concept_id,
    Null AS value_source_value,
    m.DoseQuantity AS quantity,
    'HSAA.Medication' AS source_table,
    o.id AS source_id,
    o.TextInstruction AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.Medication as m
    Inner join HSAA.HSAAOrder as o on m.HSAAOrder = o.ID
WHERE
    m.patient = :patientId
    and (
        o.OrderCode_Code IS NOT NULL
        or o.OrderCode_Description IS NOT NULL
    )
    and o.TagFacility = 'Baystate'
UNION
SELECT
    o.Encounter AS Encounter,
    o.OrderCode_Code AS event_concept_id,
    o.OrderCode_Description AS event_source_value,
    COALESCE(r.FromTime, o.EnteredOn) AS event_start_time,
    COALESCE(r.ToTime, o.EnteredOn) AS event_end_time,
    o.EnteredOn AS event_enteredon_date,
    STRING(
        o.OrderedBy_Code,
        '|',
        o.OrderedBy_SDACodingStandard
    ) AS provider_name,
    Null AS qualifier_concept_id,
    Null AS qualifier_source_value,
    Null AS unit_concept_id,
    Null AS unit_source_value,
    Null AS route_source_value,
    Null AS value_as_concept_id,
    Null AS value_source_value,
    Null AS quantity,
    'OtherResult' AS source_table,
    o.id AS source_id,
    o.TextInstruction AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.OtherResult as r
    Inner join HSAA.HSAAOrder as o on r.HSAAOrder = o.ID
WHERE
    r.patient = :patientId
    and (
        o.OrderCode_Code IS NOT NULL
        or o.OrderCode_Description IS NOT NULL
    )
    and o.TagFacility = 'Baystate'
UNION
SELECT
    o.Encounter AS Encounter,
    o.OrderCode_Code AS event_concept_id,
    o.OrderCode_Description AS event_source_value,
    COALESCE(r.FromTime, o.EnteredOn) AS event_start_time,
    COALESCE(r.ToTime, o.EnteredOn) AS event_end_time,
    o.EnteredOn AS event_enteredon_date,
    STRING(
        o.OrderedBy_Code,
        '|',
        o.OrderedBy_SDACodingStandard
    ) AS provider_name,
    Null AS qualifier_concept_id,
    Null AS qualifier_source_value,
    Null AS unit_concept_id,
    Null AS unit_source_value,
    Null AS route_source_value,
    Null AS value_as_concept_id,
    Null AS value_source_value,
    Null AS quantity,
    'RadResult' AS source_table,
    o.id AS source_id,
    r.ResultText AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.RadResult as r
    Inner join HSAA.HSAAOrder as o on r.HSAAOrder = o.ID
WHERE
    r.patient = :patientId
    and (
        o.OrderCode_Code IS NOT NULL
        or o.OrderCode_Description IS NOT NULL
    )
    and o.TagFacility = 'Baystate'
UNION
SELECT
    Encounter,
    DocumentType_Code AS event_concept_id,
    DocumentType_Description AS event_source_value,
    COALESCE(DocumentTime, EnteredOn) AS event_start_time,
    COALESCE(DocumentTime, EnteredOn) AS event_end_time,
    COALESCE(DocumentTime, EnteredOn) AS event_enteredon_date,
    STRING(Clinician_Code, '|', Clinician_SDACodingStandard) AS provider_name,
    Null AS qualifier_concept_id,
    Null AS qualifier_source_value,
    Null AS unit_concept_id,
    Null AS unit_source_value,
    Null AS route_source_value,
    Null AS value_as_concept_id,
    DocumentName AS value_source_value,
    Null AS quantity,
    'Document' AS source_table,
    id AS source_id,
    NoteText AS note,
    NULL AS value_as_number,
    NULL AS range_low,
    NULL AS range_high
FROM
    HSAA.Document
WHERE
    patient = :patientId
    and TagFacility = 'Baystate'
UNION
SELECT
    o.Encounter AS Encounter,
    STRING(o.OrderCode_Code, '|', i.TestItemCode_Code) AS event_concept_id,
    STRING(
        o.OrderCode_Description,
        '|',
        i.TestItemCode_Description
    ) AS event_source_value,
    COALESCE(r.FromTime, o.EnteredOn) AS event_start_time,
    COALESCE(r.ToTime, o.EnteredOn) AS event_end_time,
    o.EnteredOn AS event_enteredon_date,
    STRING(
        o.OrderedBy_Code,
        '|',
        o.OrderedBy_SDACodingStandard
    ) AS provider_name,
    NULL AS qualifier_concept_id,
    NULL AS qualifier_source_value,
    NULL AS unit_concept_id,
    i.ResultValueUnits AS unit_source_value,
    NULL AS route_source_value,
    i.ResultInterpretation AS value_as_concept_id,
    CASE
        WHEN i.ResultRawValue IS NULL THEN r.ResultText
        WHEN ISNUMERIC(i.ResultRawValue) = 1 THEN r.ResultText
        ELSE STRING(r.ResultText, '|', i.ResultRawValue)
    END AS value_source_value,
    NULL AS quantity,
    'LabResult' AS source_table,
    o.id AS source_id,
    i.Comments AS note,
    CASE
        WHEN ISNUMERIC(i.ResultRawValue) = 1 THEN i.ResultRawValue
        ELSE NULL
    END AS value_as_number,
    $PIECE(i.ResultNormalRange, '-', 1) AS range_low,
    $PIECE(i.ResultNormalRange, '-', 2) AS range_high
FROM
    HSAA.LabResult as r
    Inner join HSAA.HSAAOrder as o on r.HSAAOrder = o.ID
    LEFT JOIN HSAA.LabResultItem as i on r.HSAAOrder = i.HSAAOrder
    and r.ID = i.LabResult
WHERE
    r.patient = :patientId
    and (
        o.OrderCode_Code IS NOT NULL
        or o.OrderCode_Description IS NOT NULL
    )
    and o.TagFacility = 'Baystate'
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="OMOP.Request.getEventDataBO">
    <Method>getPatientInfo</Method>
  </MapItem>
</MapItems>
}

}

