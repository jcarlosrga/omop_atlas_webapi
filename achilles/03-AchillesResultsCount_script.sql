
-- If table does exist, just drop it
--DROP TABLE RESULTS.achilles_result_concept_count;

CREATE TABLE RESULTS.achilles_result_concept_count
(
  concept_id                int,
  record_count              bigint,
  descendant_record_count   bigint,
  person_count              bigint,
  descendant_person_count   bigint
);


CREATE TABLE tmp_counts
AS
 SELECT
concept_id,
  agg_count_value
FROM
(
  SELECT stratum_1 AS concept_id, MAX (count_value) AS agg_count_value
  FROM RESULTS.achilles_results
  WHERE analysis_id IN (2, 4, 5, 201, 225, 301, 325, 401, 425, 501, 505, 525, 601, 625, 701, 725, 801, 825,
    826, 827, 901, 1001, 1201, 1203, 1425, 1801, 1825, 1826, 1827, 2101, 2125, 2301)
  GROUP BY stratum_1
  UNION ALL
  SELECT stratum_2 AS concept_id, SUM (count_value) AS agg_count_value
  FROM RESULTS.achilles_results
  WHERE analysis_id IN (405, 605, 705, 805, 807, 1805, 1807, 2105)
    /* analyses:
         Number of condition occurrence records, by condition_concept_id by condition_type_concept_id
         Number of procedure occurrence records, by procedure_concept_id by procedure_type_concept_id
         Number of drug exposure records, by drug_concept_id by drug_type_concept_id
         Number of observation occurrence records, by observation_concept_id by observation_type_concept_id
         Number of observation occurrence records, by observation_concept_id and unit_concept_id
         Number of observation occurrence records, by measurement_concept_id by measurement_type_concept_id
         Number of measurement occurrence records, by measurement_concept_id and unit_concept_id
         Number of device exposure records, by device_concept_id by device_type_concept_id
        but this subquery only gets the type or unit concept_ids, i.e., stratum_2
    */
  GROUP BY stratum_2
);

CREATE TABLE tmp_counts_person
AS
 SELECT
concept_id,
  agg_count_value
FROM
(
  SELECT stratum_1 AS concept_id, MAX (count_value) AS agg_count_value
  FROM RESULTS.achilles_results
  WHERE analysis_id IN (200, 240, 400, 440, 540, 600, 640, 700, 740, 800, 840, 900, 1000, 1300, 1340, 1800, 1840, 2100, 2140, 2200)
    /* analyses:
        Number of persons with at least one visit occurrence, by visit_concept_id
        Number of persons with at least one visit occurrence, by visit_source_concept_id
        Number of persons with at least one condition occurrence, by condition_concept_id
        Number of persons with at least one condition occurrence, by condition_source_concept_id
        Number of persons with death, by cause_source_concept_id
        Number of persons with at least one procedure occurrence, by procedure_concept_id
        Number of persons with at least one procedure occurrence, by procedure_source_concept_id
        Number of persons with at least one drug exposure, by drug_concept_id
        Number of persons with at least one drug exposure, by drug_source_concept_id
        Number of persons with at least one observation occurrence, by observation_concept_id
        Number of persons with at least one observation occurrence, by observation_source_concept_id
        Number of persons with at least one drug era, by drug_concept_id
        Number of persons with at least one condition era, by condition_concept_id
        Number of persons with at least one visit detail, by visit_detail_concept_id
        Number of persons with at least one visit detail, by visit_detail_source_concept_id
        Number of persons with at least one measurement occurrence, by measurement_concept_id
        Number of persons with at least one measurement occurrence, by measurement_source_concept_id
        Number of persons with at least one device exposure, by device_concept_id
        Number of persons with at least one device exposure, by device_source_concept_id
        Number of persons with at least one note by  note_type_concept_id
    */
  GROUP BY stratum_1
);

CREATE TABLE tmp_concepts
AS
 SELECT
ancestor_id,
  descendant_id
FROM %NOPARALLEL
(
  select concept_id as ancestor_id, coalesce(cast(ca.descendant_concept_id as varchar(50)), concept_id) as descendant_id
  from %NOPARALLEL (
    select concept_id from %NOPARALLEL tmp_counts
    UNION
    -- include any ancestor concept that has a descendant in counts
    select distinct cast(ancestor_concept_id as varchar(50)) concept_id
    from %NOPARALLEL tmp_counts c
    join OMOP_CDM.concept_ancestor ca on cast(ca.descendant_concept_id as varchar(50)) = c.concept_id
  ) c
  left join OMOP_CDM.concept_ancestor ca on c.concept_id = cast(ca.ancestor_concept_id as varchar(50))
);


INSERT INTO RESULTS.achilles_result_concept_count (concept_id, record_count, descendant_record_count, person_count, descendant_person_count)
SELECT DISTINCT
    cast(concepts.ancestor_id as int) AS concept_id,
    coalesce(max(c1.agg_count_value), 0) AS record_count,
    coalesce(sum(c2.agg_count_value), 0) AS descendant_record_count,
    coalesce(max(c3.agg_count_value), 0) AS person_count,
    coalesce(sum(c4.agg_count_value), 0) AS descendant_person_count
FROM tmp_concepts concepts
         LEFT JOIN tmp_counts c1 ON concepts.ancestor_id = c1.concept_id
         LEFT JOIN tmp_counts c2 ON concepts.descendant_id = c2.concept_id
         LEFT JOIN tmp_counts_person c3 ON concepts.ancestor_id = c3.concept_id
         LEFT JOIN tmp_counts_person c4 ON concepts.descendant_id = c4.concept_id
GROUP BY concepts.ancestor_id;

DROP TABLE tmp_counts;

DROP TABLE tmp_counts_person;

DROP TABLE tmp_concepts;

