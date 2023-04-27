CREATE DATABASE omop;

\connect omop;


CREATE ROLE ohdsi_admin_group
  CREATEDB REPLICATION
   VALID UNTIL 'infinity';
COMMENT ON ROLE ohdsi_admin_group
  IS 'Administration group for OHDSI applications';

CREATE ROLE ohdsi_admin LOGIN PASSWORD 't8tia4XEFmBsN9MVJpwcE5iQT2g59DUt'
   VALID UNTIL 'infinity';
GRANT ohdsi_admin_group TO ohdsi_admin;
COMMENT ON ROLE ohdsi_admin
  IS 'Admin user account for OHDSI applications';

CREATE DATABASE "OHDSI"
  WITH ENCODING='UTF8'
       OWNER=ohdsi_admin_group
       CONNECTION LIMIT=-1;
COMMENT ON DATABASE "OHDSI"
  IS 'OHDSI database';
GRANT ALL ON DATABASE "OHDSI" TO GROUP ohdsi_admin_group;

CREATE SCHEMA webapi
       AUTHORIZATION ohdsi_admin_group;
COMMENT ON SCHEMA webapi
  IS 'Schema containing tables to support WebAPI functionality';
GRANT USAGE ON SCHEMA webapi TO PUBLIC;
GRANT ALL ON SCHEMA webapi TO GROUP ohdsi_admin_group;




--
--CREATE SEQUENCE webapi.source_daimon_sequence
--   START WITH 1
--    INCREMENT BY 1
--    NO MINVALUE
--    NO MAXVALUE
--    CACHE 1;
--
--
--ALTER TABLE webapi.source_daimon_sequence OWNER TO ohdsi_admin;
--
--
--CREATE SEQUENCE webapi.source_sequence
--    START WITH 1
--    INCREMENT BY 1
--    NO MINVALUE
--    NO MAXVALUE
--    CACHE 1;
--
--
--ALTER TABLE webapi.source_sequence OWNER TO ohdsi_admin;
--
--
--CREATE TABLE webapi.source_daimon (
--    source_daimon_id integer DEFAULT nextval('webapi.source_daimon_sequence'::regclass) NOT NULL,
--    source_id integer NOT NULL,
--    daimon_type integer NOT NULL,
--    table_qualifier character varying(255) NOT NULL,
--    priority integer NOT NULL
--);
--
--ALTER TABLE webapi.source_daimon OWNER TO ohdsi_admin;
--
--
--CREATE TABLE webapi.source (
--    source_id integer DEFAULT nextval('webapi.source_sequence'::regclass) NOT NULL,
--    source_name character varying(255) NOT NULL,
--    source_key character varying(50) NOT NULL,
--    source_connection character varying(8000) NOT NULL,
--    source_dialect character varying(255) NOT NULL,
--    username character varying(255),
--    password character varying(255),
--    krb_auth_method character varying DEFAULT 'PASSWORD'::character varying NOT NULL,
--    keytab_name character varying,
--    krb_keytab bytea,
--    krb_admin_server character varying,
--    deleted_date timestamp without time zone,
--    created_by_id integer,
--    created_date date,
--    modified_by_id integer,
--    modified_date date
--);
--
--
--ALTER TABLE webapi.source OWNER TO ohdsi_admin;



--

--DELETE FROM webapi.source_daimon
--;
--
--DELETE FROM webapi.source
--;
--
--INSERT INTO webapi.source (source_id, source_name, source_key, source_connection, source_dialect, username, password, krb_auth_method)
--SELECT nextval('webapi.source_sequence'), 'Cdm', 'CDM', ' jdbc:IRIS://localhost:1972/IRISAPP?user={user}&password={password}', 'sql server', '_SYSTEM', 'SYS', 'PASSWORD'
--;
--
--INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority)
--SELECT nextval('webapi.source_daimon_sequence'), source_id, 0, 'SQLUser', 0
--FROM webapi.source
--WHERE source_key = 'CDM'
--;
--
--INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority)
--SELECT nextval('webapi.source_daimon_sequence'), source_id, 1, 'SQLUser', 1
--FROM webapi.source
--WHERE source_key = 'CDM'
--;
--
--INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority)
--SELECT nextval('webapi.source_daimon_sequence'), source_id, 2, 'results', 1
--FROM webapi.source
--WHERE source_key = 'CDM'
--;
--
--INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority)
--SELECT nextval('webapi.source_daimon_sequence'), source_id, 5, 'temp', 0
--FROM webapi.source
--WHERE source_key = 'CDM'
--;