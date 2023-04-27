/// 
/// 2021119 Denis Bulashev
/// Step 21 - fact_relationship_concept_id
/// 
Class OMOP.Process.createFactRelationshipConceptId Extends OMOP.Process.Base [ ClassType = persistent ]
{

Method OnRequest(pRequest As OMOP.Request.createFactRelationshipConceptId, Output pResponse As Ens.Response) As %Status
{
	s sc = $$$OK
	try {

		set personId = pRequest.personId
		
		// all data is processing inside IRIS, there is no need to do external calls

		s SQL = "SELECT "_
				"c1.condition_occurrence_id    AS fact_id_1,"_
				"c2.condition_occurrence_id    AS fact_id_2,"_
				"'1147333'                                 AS domain_concept_id_1,"_
				"'1147333'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.condition_occurrence c1"_
				"join SQLUser.condition_occurrence c2"_
				"on LEFT(c1.condition_source_value,$find(c1.condition_source_value,'|')-2)=LEFT(c2.condition_source_value,$find(c2.condition_source_value,'|')-2)"_
				"where c1.condition_source_value %pattern '.N1""|a|"".E' and c2.condition_source_value %pattern '.N1""|r|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				""_
				"SELECT "_
				"c1.condition_occurrence_id    AS fact_id_1,"_
				"c2.condition_occurrence_id    AS fact_id_2,"_
				"'1147333'                                 AS domain_concept_id_1,"_
				"'1147333'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.condition_occurrence c1"_
				"join SQLUser.condition_occurrence c2"_
				"on LEFT(c1.condition_source_value,$find(c1.condition_source_value,'|')-2)=LEFT(c2.condition_source_value,$find(c2.condition_source_value,'|')-2)"_
				"where c1.condition_source_value %pattern '.N1""|r|"".E' and c2.condition_source_value %pattern '.N1""|a|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				""_
				"SELECT "_
				"c1.condition_occurrence_id    AS fact_id_1,"_
				"c2.observation_id    AS fact_id_2,"_
				"'1147333'                                 AS domain_concept_id_1,"_
				"'1147304'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.condition_occurrence c1"_
				"join SQLUser.observation c2"_
				"on LEFT(c1.condition_source_value,$find(c1.condition_source_value,'|')-2)=LEFT(c2.observation_source_value,$find(c2.observation_source_value,'|')-2)"_
				"where c1.condition_source_value %pattern '.N1""|a|"".E' and c2.observation_source_value %pattern '.N1""|r|"".E'"_
				" AND c1.person_id = ? "_
				"UNION"_
				"SELECT "_
				"c1.observation_id    AS fact_id_1,"_
				"c2.condition_occurrence_id    AS fact_id_2,"_
				"'1147304'                                 AS domain_concept_id_1,"_
				"'1147333'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.observation c1"_
				"join SQLUser.condition_occurrence c2"_
				"on LEFT(c1.observation_source_value,$find(c1.observation_source_value,'|')-2)=LEFT(c2.condition_source_value,$find(c2.condition_source_value,'|')-2)"_
				"where c1.observation_source_value %pattern '.N1""|r|"".E' and c2.condition_source_value %pattern '.N1""|a|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				""_
				"SELECT "_
				"c1.condition_occurrence_id    AS fact_id_1,"_
				"c2.measurement_id    AS fact_id_2,"_
				"'1147333'                                 AS domain_concept_id_1,"_
				"'1147330'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.condition_occurrence c1"_
				"join SQLUser.measurement c2"_
				"on LEFT(c1.condition_source_value,$find(c1.condition_source_value,'|')-2)=LEFT(c2.measurement_source_value,$find(c2.measurement_source_value,'|')-2)"_
				"where c1.condition_source_value %pattern '.N1""|a|"".E' and c2.measurement_source_value %pattern '.N1""|r|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				"SELECT "_
				"c1.measurement_id    AS fact_id_1,"_
				"c2.condition_occurrence_id    AS fact_id_2,"_
				"'1147330'                                 AS domain_concept_id_1,"_
				"'1147333'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.measurement c1"_
				"join SQLUser.condition_occurrence c2"_
				"on LEFT(c1.measurement_source_value,$find(c1.measurement_source_value,'|')-2)=LEFT(c2.condition_source_value,$find(c2.condition_source_value,'|')-2)"_
				"where c1.measurement_source_value %pattern '.N1""|r|"".E' and c2.condition_source_value %pattern '.N1""|a|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				""_
				"SELECT "_
				"c1.condition_occurrence_id    AS fact_id_1,"_
				"c2.procedure_occurrence_id    AS fact_id_2,"_
				"'1147333'                                 AS domain_concept_id_1,"_
				"'1147301'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.condition_occurrence c1"_
				"join SQLUser.procedure_occurrence c2"_
				"on LEFT(c1.condition_source_value,$find(c1.condition_source_value,'|')-2)=LEFT(c2.procedure_source_value,$find(c2.procedure_source_value,'|')-2)"_
				"where c1.condition_source_value %pattern '.N1""|a|"".E' and c2.procedure_source_value %pattern '.N1""|r|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				"SELECT "_
				"c1.procedure_occurrence_id    AS fact_id_1,"_
				"c2.condition_occurrence_id    AS fact_id_2,"_
				"'1147301'                                 AS domain_concept_id_1,"_
				"'1147333'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.procedure_occurrence c1"_
				"join SQLUser.condition_occurrence c2"_
				"on LEFT(c1.procedure_source_value,$find(c1.procedure_source_value,'|')-2)=LEFT(c2.condition_source_value,$find(c2.condition_source_value,'|')-2)"_
				"where c1.procedure_source_value %pattern '.N1""|r|"".E' and c2.condition_source_value %pattern '.N1""|a|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				""_
				"SELECT "_
				"c1.procedure_occurrence_id    AS fact_id_1,"_
				"c2.procedure_occurrence_id    AS fact_id_2,"_
				"'1147301'                                 AS domain_concept_id_1,"_
				"'1147301'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.procedure_occurrence c1"_
				"join SQLUser.procedure_occurrence c2"_
				"on LEFT(c1.procedure_source_value,$find(c1.procedure_source_value,'|')-2)=LEFT(c2.procedure_source_value,$find(c2.procedure_source_value,'|')-2)"_
				"where c1.procedure_source_value %pattern '.N1""|a|"".E' and c2.procedure_source_value %pattern '.N1""|r|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				"SELECT "_
				"c1.procedure_occurrence_id    AS fact_id_1,"_
				"c2.procedure_occurrence_id    AS fact_id_2,"_
				"'1147301'                                 AS domain_concept_id_1,"_
				"'1147301'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.procedure_occurrence c1"_
				"join SQLUser.procedure_occurrence c2"_
				"on LEFT(c1.procedure_source_value,$find(c1.procedure_source_value,'|')-2)=LEFT(c2.procedure_source_value,$find(c2.procedure_source_value,'|')-2)"_
				"where c1.procedure_source_value %pattern '.N1""|r|"".E' and c2.procedure_source_value %pattern '.N1""|a|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				""_
				"SELECT "_
				"c1.measurement_id    AS fact_id_1,"_
				"c2.measurement_id    AS fact_id_2,"_
				"'1147330'                                 AS domain_concept_id_1,"_
				"'1147330'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.measurement c1"_
				"join SQLUser.measurement c2"_
				"on LEFT(c1.measurement_source_value,$find(c1.measurement_source_value,'|')-2)=LEFT(c2.measurement_source_value,$find(c2.measurement_source_value,'|')-2)"_
				"where c1.measurement_source_value %pattern '.N1""|a|"".E' and c2.measurement_source_value %pattern '.N1""|r|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				"SELECT "_
				"c1.measurement_id    AS fact_id_1,"_
				"c2.measurement_id    AS fact_id_2,"_
				"'1147330'                                 AS domain_concept_id_1,"_
				"'1147330'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.measurement c1"_
				"join SQLUser.measurement c2"_
				"on LEFT(c1.measurement_source_value,$find(c1.measurement_source_value,'|')-2)=LEFT(c2.measurement_source_value,$find(c2.measurement_source_value,'|')-2)"_
				"where c1.measurement_source_value %pattern '.N1""|r|"".E' and c2.measurement_source_value %pattern '.N1""|a|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				""_
				"SELECT "_
				"c1.observation_id    AS fact_id_1,"_
				"c2.observation_id    AS fact_id_2,"_
				"'1147304'                                 AS domain_concept_id_1,"_
				"'1147304'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.observation c1"_
				"join SQLUser.observation c2"_
				"on LEFT(c1.observation_source_value,$find(c1.observation_source_value,'|')-2)=LEFT(c2.observation_source_value,$find(c2.observation_source_value,'|')-2)"_
				"where c1.observation_source_value %pattern '.N1""|a|"".E' and c2.observation_source_value %pattern '.N1""|r|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				"SELECT "_
				"c1.observation_id    AS fact_id_1,"_
				"c2.observation_id    AS fact_id_2,"_
				"'1147304'                                 AS domain_concept_id_1,"_
				"'1147304'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.observation c1"_
				"join SQLUser.observation c2"_
				"on LEFT(c1.observation_source_value,$find(c1.observation_source_value,'|')-2)=LEFT(c2.observation_source_value,$find(c2.observation_source_value,'|')-2)"_
				"where c1.observation_source_value %pattern '.N1""|r|"".E' and c2.observation_source_value %pattern '.N1""|a|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				""_
				"SELECT "_
				"c1.observation_id    AS fact_id_1,"_
				"c2.measurement_id    AS fact_id_2,"_
				"'1147304'                                 AS domain_concept_id_1,"_
				"'1147330'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.observation c1"_
				"join SQLUser.measurement c2"_
				"on LEFT(c1.observation_source_value,$find(c1.observation_source_value,'|')-2)=LEFT(c2.measurement_source_value,$find(c2.measurement_source_value,'|')-2)"_
				"where c1.observation_source_value %pattern '.N1""|a|"".E' and c2.measurement_source_value %pattern '.N1""|r|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				"SELECT "_
				"c1.measurement_id    AS fact_id_1,"_
				"c2.observation_id    AS fact_id_2,"_
				"'1147330'                                 AS domain_concept_id_1,"_
				"'1147304'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.measurement c1"_
				"join SQLUser.observation c2"_
				"on LEFT(c1.measurement_source_value,$find(c1.measurement_source_value,'|')-2)=LEFT(c2.observation_source_value,$find(c2.observation_source_value,'|')-2)"_
				"where c1.measurement_source_value %pattern '.N1""|r|"".E' and c2.observation_source_value %pattern '.N1""|a|"".E'"_
				" AND c1.person_id = ? "_
				""_
				""_
				"UNION"_
				""_
				"SELECT "_
				"c1.observation_id    AS fact_id_1,"_
				"c2.procedure_occurrence_id    AS fact_id_2,"_
				"'1147304'                                 AS domain_concept_id_1,"_
				"'1147301'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.observation c1"_
				"join SQLUser.procedure_occurrence c2"_
				"on LEFT(c1.observation_source_value,$find(c1.observation_source_value,'|')-2)=LEFT(c2.procedure_source_value,$find(c2.procedure_source_value,'|')-2)"_
				"where c1.observation_source_value %pattern '.N1""|a|"".E' and c2.procedure_source_value %pattern '.N1""|r|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				"SELECT "_
				"c1.procedure_occurrence_id    AS fact_id_1,"_
				"c2.observation_id    AS fact_id_2,"_
				"'1147301'                                 AS domain_concept_id_1,"_
				"'1147304'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.procedure_occurrence c1"_
				"join SQLUser.observation c2"_
				"on LEFT(c1.procedure_source_value,$find(c1.procedure_source_value,'|')-2)=LEFT(c2.observation_source_value,$find(c2.observation_source_value,'|')-2)"_
				"where c1.procedure_source_value %pattern '.N1""|r|"".E' and c2.observation_source_value %pattern '.N1""|a|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				""_
				"SELECT "_
				"c1.measurement_id    AS fact_id_1,"_
				"c2.procedure_occurrence_id    AS fact_id_2,"_
				"'1147330'                                 AS domain_concept_id_1,"_
				"'1147301'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.measurement c1"_
				"join SQLUser.procedure_occurrence c2"_
				"on LEFT(c1.measurement_source_value,$find(c1.measurement_source_value,'|')-2)=LEFT(c2.procedure_source_value,$find(c2.procedure_source_value,'|')-2)"_
				"where c1.measurement_source_value %pattern '.N1""|a|"".E' and c2.procedure_source_value %pattern '.N1""|r|"".E'"_
				" AND c1.person_id = ? "_
				""_
				"UNION"_
				"SELECT "_
				"c1.procedure_occurrence_id    AS fact_id_1,"_
				"c2.measurement_id    AS fact_id_2,"_
				"'1147301'                                 AS domain_concept_id_1,"_
				"'1147330'                                 AS domain_concept_id_2,"_
				"'4165382'                                 AS relationship_concept_id"_
				"FROM SQLUser.procedure_occurrence c1"_
				"join SQLUser.measurement c2"_
				"on LEFT(c1.procedure_source_value,$find(c1.procedure_source_value,'|')-2)=LEFT(c2.measurement_source_value,$find(c2.measurement_source_value,'|')-2)"_
				"where c1.procedure_source_value %pattern '.N1""|r|"".E' and c2.measurement_source_value %pattern '.N1""|a|"".E'"_
				" AND c1.person_id = ? "

		set tRS=##class(%ResultSet).%New()
		set tSC=tRS.Prepare(SQL)
		quit:$$$ISERR(tSC)
		set tSC=tRS.Execute(personId, personId, personId, personId, personId, personId, personId, personId, personId, personId, personId, personId, personId, personId, personId, personId, personId, personId, personId, personId) 
		quit:$$$ISERR(tSC)
		
		While tRS.%Next() {
			; sava as is - no need to transform data
			# dim saveFactRelationshipRequest As OMOP.Request.saveFactRelationshipBO
			set saveFactRelationshipRequest = ##class(OMOP.Request.saveFactRelationshipBO).%New()
			set saveFactRelationshipRequest.factId1 = tRS.GetDataByName("fact_id_1")
			set saveFactRelationshipRequest.factId2 = tRS.GetDataByName("fact_id_2")
			
			set saveFactRelationshipRequest.domainConceptId1 = tRS.GetDataByName("domain_concept_id_1")
			set saveFactRelationshipRequest.domainConceptId2 = tRS.GetDataByName("domain_concept_id_2")
			
			set saveFactRelationshipRequest.relationshipConceptId = tRS.GetDataByName("relationship_concept_id")
			
			set saveFactRelationshipRequest.type = "saveFactRelationshipBO"
			
			// 1 - save data to IRIS
			set saveFactRelationshipRequest.target = "IRIS"
			set sc = ..SendRequestSync("Operation.saveDataToIRIS", saveFactRelationshipRequest, .saveFactRelationshipResponse)
			q:$$$ISERR(sc)
			
			// 1 - save data to PostgreSQL
			set saveFactRelationshipRequest.target = "PostgreSQL"
			set sc = ..SendRequestSync("Operation.saveDataToPostgreSQL", saveFactRelationshipRequest, .saveFactRelationshipResponse)
			q:$$$ISERR(sc)

		}
	} catch e {
		s sc = e.AsStatus()
	}
	q sc
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
