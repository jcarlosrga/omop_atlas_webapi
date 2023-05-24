--
-- ARTIFICIAL DATA
--

--
-- PATIENTS
--
INSERT INTO HSAA.Patient(BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description,
Address_Street, Address_City_Description, Address_CountRy_Code, Address_State_Code, Address_Zip_Code, 
Gender_Code, Gender_Description, RawGender_Code, RawGender_Description, 
BirthGender_Code, BirthGender_Description, Deceased, DeathTime, Address_City_Code, CreatedOn)
VALUES 
('2000-01-02 10:00:00','ASIAN','ASIAN','ARABIC','ARABIC','Street1','Sity1','UNITED STATES','NY',30001,'M','',8507,'',1,'','','',0101, '2022-03-30 11:00:00')
INSERT INTO HSAA.Patient(BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description,
Address_Street, Address_City_Description, Address_CountRy_Code, Address_State_Code, Address_Zip_Code, 
Gender_Code, Gender_Description, RawGender_Code, RawGender_Description, 
BirthGender_Code, BirthGender_Description, Deceased, DeathTime, Address_City_Code, CreatedOn)
VALUES 
('2000-01-02 10:00:00','ASIAN','ASIAN','ARABIC','ARABIC','Street1','Sity2','UNITED STATES','NY',30001,'M','',8507,'',1,'','','',0101, '2022-02-10 11:00:00')
INSERT INTO HSAA.Patient(BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description,
Address_Street, Address_City_Description, Address_CountRy_Code, Address_State_Code, Address_Zip_Code, 
Gender_Code, Gender_Description, RawGender_Code, RawGender_Description, 
BirthGender_Code, BirthGender_Description, Deceased, DeathTime, Address_City_Code, CreatedOn)
VALUES 
('2000-01-02 10:00:00','ASIAN','ASIAN','ARABIC','ARABIC','Street2','Sity2','UNITED STATES','NY',30001,'F','',8532,'',1,'','','',0101, '2022-03-10 11:00:00')
INSERT INTO HSAA.Patient(BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description,
Address_Street, Address_City_Description, Address_CountRy_Code, Address_State_Code, Address_Zip_Code, 
Gender_Code, Gender_Description, RawGender_Code, RawGender_Description, 
BirthGender_Code, BirthGender_Description, Deceased, DeathTime, Address_City_Code, CreatedOn)
VALUES 
('2000-01-02 10:00:00','HISPANIC','HISPANIC','ARABIC','ARABIC','Street3','Sity3','UNITED STATES','CA',30001,'F','',8532,'',1,'','','',0101, '2022-01-30 11:00:00')
INSERT INTO HSAA.Patient(BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description,
Address_Street, Address_City_Description, Address_CountRy_Code, Address_State_Code, Address_Zip_Code, 
Gender_Code, Gender_Description, RawGender_Code, RawGender_Description, 
BirthGender_Code, BirthGender_Description, Deceased, DeathTime, Address_City_Code, CreatedOn)
VALUES 
('2000-01-02 10:00:00','HISPANIC','HISPANIC','ARABIC','ARABIC','Street3','Sity4','UNITED STATES','CA',30001,'M','',8507,'',1,'','','',0101, '2022-02-30 11:00:00')
INSERT INTO HSAA.Patient(BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description,
Address_Street, Address_City_Description, Address_CountRy_Code, Address_State_Code, Address_Zip_Code, 
Gender_Code, Gender_Description, RawGender_Code, RawGender_Description, 
BirthGender_Code, BirthGender_Description, Deceased, DeathTime, Address_City_Code, CreatedOn)
VALUES 
('2000-01-02 10:00:00','HISPANIC','HISPANIC','ARABIC','ARABIC','Street3','Sity4','UNITED STATES','CA',30001,'M','',8507,'',1,'','','',0101, '2022-01-22 11:00:00')
INSERT INTO HSAA.Patient(BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description,
Address_Street, Address_City_Description, Address_CountRy_Code, Address_State_Code, Address_Zip_Code, 
Gender_Code, Gender_Description, RawGender_Code, RawGender_Description, 
BirthGender_Code, BirthGender_Description, Deceased, DeathTime, Address_City_Code, CreatedOn)
VALUES 
('2000-01-02 10:00:00','OTHER','OTHER','ARABIC','ARABIC','Street4','Sity5','UNITED STATES','CA',30001,'M','',8507,'',1,'','','',0101, '2022-02-13 11:00:00')
INSERT INTO HSAA.Patient(BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description,
Address_Street, Address_City_Description, Address_CountRy_Code, Address_State_Code, Address_Zip_Code, 
Gender_Code, Gender_Description, RawGender_Code, RawGender_Description, 
BirthGender_Code, BirthGender_Description, Deceased, DeathTime, Address_City_Code, CreatedOn)
VALUES 
('2000-01-02 10:00:00','OTHER','OTHER','ARABIC','ARABIC','Street4','Sity6','UNITED STATES','CA',30001,'M','',8507,'',1,'','','',0101, '2022-04-10 11:00:00')
INSERT INTO HSAA.Patient(BirthTime, Race_Code, Race_Description, EthnicGroup_Code, EthnicGroup_Description,
Address_Street, Address_City_Description, Address_CountRy_Code, Address_State_Code, Address_Zip_Code, 
Gender_Code, Gender_Description, RawGender_Code, RawGender_Description, 
BirthGender_Code, BirthGender_Description, Deceased, DeathTime, Address_City_Code, CreatedOn)
VALUES 
('2000-01-02 10:00:00','OTHER','OTHER','ARABIC','ARABIC','Street5','Sity7','UNITED STATES','CA',30001,'F','',8532,'',1,'','','',0101, '2022-03-25 11:00:00')



INSERT INTO HSAA.CareProvider(Description, Address_City_Code, Address_State_Code, Address_Street, Address_Zip_Code, Code, SDACodingStandard, NationalProviderID, DEANumber, Specialty, LastUpdated)
VALUES
('CareProvider_1',0101,'NY','CP_Street1',30101, 101, 808, 900, 987, 1111, '2020-01-01')
INSERT INTO HSAA.CareProvider(Description, Address_City_Code, Address_State_Code, Address_Street, Address_Zip_Code, Code, SDACodingStandard, NationalProviderID, DEANumber, Specialty, LastUpdated)
VALUES
('CareProvider_2',0101,'NY','CP_Street2',30101, 101, 807, 900, 987, 1111, '2020-01-01')
INSERT INTO HSAA.CareProvider(Description, Address_City_Code, Address_State_Code, Address_Street, Address_Zip_Code, Code, SDACodingStandard, NationalProviderID, DEANumber, Specialty, LastUpdated)
VALUES
('CareProvider_3',0101,'NY','CP_Street3',30101, 101, 806, 900, 987, 1111, '2020-01-01')
INSERT INTO HSAA.CareProvider(Description, Address_City_Code, Address_State_Code, Address_Street, Address_Zip_Code, Code, SDACodingStandard, NationalProviderID, DEANumber, Specialty, LastUpdated)
VALUES
('CareProvider_4',0101,'NY','CP_Street4',30101, 101, 805, 900, 987, 1111, '2020-01-01')



INSERT INTO HSAA.ClinicalRelationship (patient, CareProvider, Clinician_Description, clinician_careprovidertype_description, facilitycode)
VALUES
(1, 1, 'Clinician_Description_1', 'Primary Care Provider', 'Baystate')
INSERT INTO HSAA.ClinicalRelationship (patient, CareProvider, Clinician_Description, clinician_careprovidertype_description, facilitycode)
VALUES
(2, 2, 'Clinician_Description_2', 'Primary Care Provider', 'Baystate')
INSERT INTO HSAA.ClinicalRelationship (patient, CareProvider, Clinician_Description, clinician_careprovidertype_description, facilitycode)
VALUES
(3, 3, 'Clinician_Description_3', 'Primary Care Provider', 'Baystate')
INSERT INTO HSAA.ClinicalRelationship (patient, CareProvider, Clinician_Description, clinician_careprovidertype_description, facilitycode)
VALUES
(4, 4, 'Clinician_Description_4', 'Primary Care Provider', 'Baystate')
INSERT INTO HSAA.ClinicalRelationship (patient, CareProvider, Clinician_Description, clinician_careprovidertype_description, facilitycode)
VALUES
(5, 1, 'Clinician_Description_1', 'Primary Care Provider', 'Baystate')
INSERT INTO HSAA.ClinicalRelationship (patient, CareProvider, Clinician_Description, clinician_careprovidertype_description, facilitycode)
VALUES
(6, 2, 'Clinician_Description_2', 'Primary Care Provider', 'Baystate')
INSERT INTO HSAA.ClinicalRelationship (patient, CareProvider, Clinician_Description, clinician_careprovidertype_description, facilitycode)
VALUES
(7, 3, 'Clinician_Description_3', 'Primary Care Provider', 'Baystate')
INSERT INTO HSAA.ClinicalRelationship (patient, CareProvider, Clinician_Description, clinician_careprovidertype_description, facilitycode)
VALUES
(8, 4, 'Clinician_Description_4', 'Primary Care Provider', 'Baystate')
INSERT INTO HSAA.ClinicalRelationship (patient, CareProvider, Clinician_Description, clinician_careprovidertype_description, facilitycode)
VALUES
(9, 1, 'Clinician_Description_1', 'Primary Care Provider', 'Baystate')
INSERT INTO HSAA.ClinicalRelationship (patient, CareProvider, Clinician_Description, clinician_careprovidertype_description, facilitycode)
VALUES
(10, 2, 'Clinician_Description_2', 'Primary Care Provider', 'Baystate')


-- visit occurrence
INSERT INTO HSAA.Encounter(patient, EncounterType, StartTime, FromTime, EndTime, 
		ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, 
		AttendingClinician_SDACodingStandard, LOS, AdmissionSource_Code, DischargeDisposition_Code,TagFacility)
VALUES
(1,'INPATIENT','','2020-01-02 10:00:00','', 
'2020-01-02 11:00:00','101','2022-03-30 14:20:00',1,'',
'808','','AMBSURG','AMA','BayState')
INSERT INTO HSAA.Encounter(patient, EncounterType, StartTime, FromTime, EndTime, 
		ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, 
		AttendingClinician_SDACodingStandard, LOS, AdmissionSource_Code, DischargeDisposition_Code,TagFacility)
VALUES
(2,'INPATIENT','','2020-01-02 10:00:00','', 
'2020-01-02 11:00:00','101','2022-03-30 14:20:00',1,'',
'807','','AMBSURG','AMA','BayState')
INSERT INTO HSAA.Encounter(patient, EncounterType, StartTime, FromTime, EndTime, 
		ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, 
		AttendingClinician_SDACodingStandard, LOS, AdmissionSource_Code, DischargeDisposition_Code,TagFacility)
VALUES
(3,'INPATIENT','','2020-01-02 10:00:00','', 
'2020-01-02 11:00:00','101','2022-03-30 14:20:00',1,'',
'806','','AMBSURG','AMA','BayState')
INSERT INTO HSAA.Encounter(patient, EncounterType, StartTime, FromTime, EndTime, 
		ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, 
		AttendingClinician_SDACodingStandard, LOS, AdmissionSource_Code, DischargeDisposition_Code,TagFacility)
VALUES
(4,'INPATIENT','','2020-01-02 10:00:00','', 
'2020-01-02 11:00:00','101','2022-03-30 14:20:00',1,'',
'805','','AMBSURG','AMA','BayState')
INSERT INTO HSAA.Encounter(patient, EncounterType, StartTime, FromTime, EndTime, 
		ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, 
		AttendingClinician_SDACodingStandard, LOS, AdmissionSource_Code, DischargeDisposition_Code,TagFacility)
VALUES
(5,'INPATIENT','','2020-01-02 10:00:00','', 
'2020-01-02 11:00:00','101','2022-03-30 14:20:00',1,'',
'808','','AMBSURG','AMA','BayState')
INSERT INTO HSAA.Encounter(patient, EncounterType, StartTime, FromTime, EndTime, 
		ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, 
		AttendingClinician_SDACodingStandard, LOS, AdmissionSource_Code, DischargeDisposition_Code,TagFacility)
VALUES
(6,'INPATIENT','','2020-01-02 10:00:00','', 
'2020-01-02 11:00:00','101','2022-03-30 14:20:00',1,'',
'807','','AMBSURG','AMA','BayState')
INSERT INTO HSAA.Encounter(patient, EncounterType, StartTime, FromTime, EndTime, 
		ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, 
		AttendingClinician_SDACodingStandard, LOS, AdmissionSource_Code, DischargeDisposition_Code,TagFacility)
VALUES
(7,'INPATIENT','','2020-01-02 10:00:00','', 
'2020-01-02 11:00:00','101','2022-03-30 14:20:00',1,'',
'808','','AMBSURG','AMA','BayState')
INSERT INTO HSAA.Encounter(patient, EncounterType, StartTime, FromTime, EndTime, 
		ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, 
		AttendingClinician_SDACodingStandard, LOS, AdmissionSource_Code, DischargeDisposition_Code,TagFacility)
VALUES
(8,'INPATIENT','','2020-01-02 10:00:00','', 
'2020-01-02 11:00:00','101','2022-03-30 14:20:00',1,'',
'806','','AMBSURG','AMA','BayState')
INSERT INTO HSAA.Encounter(patient, EncounterType, StartTime, FromTime, EndTime, 
		ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, 
		AttendingClinician_SDACodingStandard, LOS, AdmissionSource_Code, DischargeDisposition_Code,TagFacility)
VALUES
(9,'INPATIENT','','2020-01-02 10:00:00','', 
'2020-01-02 11:00:00','101','2022-03-30 14:20:00',1,'',
'807','','AMBSURG','AMA','BayState')
INSERT INTO HSAA.Encounter(patient, EncounterType, StartTime, FromTime, EndTime, 
		ToTime, Site, LastUpdated, AttendingClinician_Code, AttendingClinician_Description, 
		AttendingClinician_SDACodingStandard, LOS, AdmissionSource_Code, DischargeDisposition_Code,TagFacility)
VALUES
(10,'INPATIENT','','2020-01-02 10:00:00','', 
'2020-01-02 11:00:00','101','2022-03-30 14:20:00',1,'',
'807','','AMBSURG','AMA','BayState')



-- condition
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(1,'10370003','RHYTHM FROM ARTIFICIAL PACING (FINDING)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 1)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(2,'10711371000119102','CYST OF RIGHT BREAST (DISORDER)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 2)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(3,'1075071000119103','SWELLING OF FIRST METATARSAL JOINT OF HALLUX OF LEFT FOOT (DISORDER)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 3)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(4,'1089971000119108','CYST OF STRUCTURE OF INTERNAL PART OF MOUTH (DISORDER)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 4)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(5,'109275008','MELANOCYTIC NEVUS OF SCALP (DISORDER)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 5)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(6,'10932321000119105','CLOSED FRACTURE OF LEFT PATELLA (DISORDER)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 6)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(7,'10937881000119101','CLOSED FRACTURE OF RIGHT HAND (DISORDER)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 7)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(8,'110138006','AVULSION OF TONSIL (DISORDER)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 8)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(9,'111359004','DIVERTICULITIS OF COLON (DISORDER)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 9)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(10,'11366004','SINGERS NODES (DISORDER)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 10)



-- observation
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'266919005','NEVER SMOKED TOBACCO (FINDING)','2022-01-10 09:00:00','',
'123','888','','NEVER SMOKED TOBACCO (FINDING)','101',
'Baystate', 1)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'266927001','UNKNOWN IF EVER SMOKED','2022-01-10 09:00:00','',
'123','888','','UNKNOWN IF EVER SMOKED','101',
'Baystate', 2)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'428041000124106','CURRENT SOME DAY SMOKER','2022-01-10 09:00:00','',
'123','888','','CURRENT SOME DAY SMOKER','101',
'Baystate', 3)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'8517006','FORMER SMOKER','2022-01-10 09:00:00','',
'123','888','','FORMER SMOKER','101',
'Baystate', 4)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'1078631000119102','HISTORY OF RIGHT TOTAL KNEE REPLACEMENT (SITUATION)','2022-01-10 09:00:00','',
'123','888','','HISTORY OF RIGHT TOTAL KNEE REPLACEMENT (SITUATION)','101',
'Baystate', 5)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'118538004','MASS, A MEASURE OF QUANTITY OF MATTER (PROPERTY) (QUALIFIER VALUE)','2022-01-10 09:00:00','',
'123','888','','MASS, A MEASURE OF QUANTITY OF MATTER (PROPERTY) (QUALIFIER VALUE)','101',
'Baystate', 6)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'12856003','UNEVEN VENOUS ECTASIA (MORPHOLOGIC ABNORMALITY)','2022-01-10 09:00:00','',
'123','888','','UNEVEN VENOUS ECTASIA (MORPHOLOGIC ABNORMALITY)','101',
'Baystate', 7)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'1338007','BASAL CELL CARCINOMA (MORPHOLOGIC ABNORMALITY)','2022-01-10 09:00:00','',
'123','888','','BASAL CELL CARCINOMA (MORPHOLOGIC ABNORMALITY)','101',
'Baystate', 8)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'161687003','HISTORY OF - COLOSTOMY (CONTEXT-DEPENDENT CATEGORY','2022-01-10 09:00:00','',
'123','888','','HISTORY OF - COLOSTOMY (CONTEXT-DEPENDENT CATEGORY','101',
'Baystate', 9)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'169484002','CONTRACEPTIVE IUD REMOVAL AWAITED (FINDING)','2022-01-10 09:00:00','',
'123','888','','CONTRACEPTIVE IUD REMOVAL AWAITED (FINDING)','101',
'Baystate', 10)


-- measurement 
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'2710-2','OXYGEN SATURATION','2022-01-10 09:00:00','',
'123','888','','','95',
'Baystate', 1)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'252195001','EXERCISE STRESS TEST - ENDOCRINE (PROCEDURE)','2022-01-10 09:00:00','',
'123','888','','','95',
'Baystate', 2)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'69000-8','PULSE RATE, SITTING','2022-01-10 09:00:00','',
'123','888','','','65',
'Baystate', 3)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'	8310-5','TEMPERATURE','2022-01-10 09:00:00','',
'123','888','','','100',
'Baystate', 4)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'9279-1','RESPIRATORY RATE','2022-01-10 09:00:00','',
'123','888','','','40',
'Baystate', 5)



-- procedure_occurrence  
INSERT INTO HSAA.HSAAProcedure
	(Encounter, HSAAProcedure_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, source_table, HSAAProcedure_Description, patient)
VALUES
(Null,'11127003','','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 'HSAA.Medication', 'ESOPHAGOGASTROSTOMY, ANTESTERNAL OR ANTETHORACIC (PROCEDURE)', 1)
INSERT INTO HSAA.HSAAProcedure
	(Encounter, HSAAProcedure_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, source_table, HSAAProcedure_Description, patient)
VALUES
(Null,'11570006','','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 'HSAA.Medication', 'BIOPSY OF LIP (PROCEDURE)', 2)
INSERT INTO HSAA.HSAAProcedure
	(Encounter, HSAAProcedure_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, source_table, HSAAProcedure_Description, patient)
VALUES
(Null,'116140006','','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 'HSAA.Medication', 'TOTAL HYSTERECTOMY (PROCEDURE)', 3)
INSERT INTO HSAA.HSAAProcedure
	(Encounter, HSAAProcedure_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, source_table, HSAAProcedure_Description, patient)
VALUES
(Null,'116141005','','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 'HSAA.Medication', 'ABDOMINAL HYSTERECTOMY (PROCEDURE)', 4)
INSERT INTO HSAA.HSAAProcedure
	(Encounter, HSAAProcedure_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, source_table, HSAAProcedure_Description, patient)
VALUES
(Null,'119685007','','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 'HSAA.Medication', 'ANKLE EXCISION (PROCEDURE)', 5)



-- drug_exposure   
INSERT INTO HSAA.Medication    
	(Clinician_Code, Clinician_SDACodingStandard, DOSEQUANTITY, DOSEUOM_CODE, DOSEUOM_DESCRIPTION,
	Encounter, EnteredOn, FROMTIME, HSAAORDER, ObservationCode_Code,
	ObservationCode_Description, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue,
	ObservationTime, ROUTE_DESCRIPTION, TOTIME, TagFacility, source_table, patient)
VALUES
('126109000','',1,'','LEVONORGESTREL (SUBSTANCE)',
Null,'','2022-01-20 09:00:00','1','',
'','','','','',
'INHALATION','2022-01-20 09:00:00','Baystate','HSAA.Medication',1)
INSERT INTO HSAA.Medication    
	(Clinician_Code, Clinician_SDACodingStandard, DOSEQUANTITY, DOSEUOM_CODE, DOSEUOM_DESCRIPTION,
	Encounter, EnteredOn, FROMTIME, HSAAORDER, ObservationCode_Code,
	ObservationCode_Description, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue,
	ObservationTime, ROUTE_DESCRIPTION, TOTIME, TagFacility, source_table, patient)
VALUES
('326428000','',1,'','LEVONORGESTREL 52MG INTRAUTERINE SYSTEM (PRODUCT)',
Null,'','2022-01-20 09:00:00','2','',
'','','','','',
'INHALATION','2022-01-20 09:00:00','Baystate','HSAA.Medication',2)
INSERT INTO HSAA.Medication    
	(Clinician_Code, Clinician_SDACodingStandard, DOSEQUANTITY, DOSEUOM_CODE, DOSEUOM_DESCRIPTION,
	Encounter, EnteredOn, FROMTIME, HSAAORDER, ObservationCode_Code,
	ObservationCode_Description, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue,
	ObservationTime, ROUTE_DESCRIPTION, TOTIME, TagFacility, source_table, patient)
VALUES
('Albuterol (albuterol (OP))','',1,'','Albuterol (albuterol (OP))',
Null,'','2022-01-20 09:00:00','3','',
'','','','','',
'INHALATION','2022-01-20 09:00:00','Baystate','HSAA.Medication',3)
INSERT INTO HSAA.Medication    
	(Clinician_Code, Clinician_SDACodingStandard, DOSEQUANTITY, DOSEUOM_CODE, DOSEUOM_DESCRIPTION,
	Encounter, EnteredOn, FROMTIME, HSAAORDER, ObservationCode_Code,
	ObservationCode_Description, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue,
	ObservationTime, ROUTE_DESCRIPTION, TOTIME, TagFacility, source_table, patient)
VALUES
('Creatine','',1,'','Creatine',
Null,'','2022-01-20 09:00:00','4','',
'','','','','',
'INHALATION','2022-01-20 09:00:00','Baystate','HSAA.Medication',4)
INSERT INTO HSAA.Medication    
	(Clinician_Code, Clinician_SDACodingStandard, DOSEQUANTITY, DOSEUOM_CODE, DOSEUOM_DESCRIPTION,
	Encounter, EnteredOn, FROMTIME, HSAAORDER, ObservationCode_Code,
	ObservationCode_Description, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue,
	ObservationTime, ROUTE_DESCRIPTION, TOTIME, TagFacility, source_table, patient)
VALUES
('ydrocortisone topical 2.5% lotion','',1,'','ydrocortisone topical 2.5% lotion',
Null,'','2022-01-20 09:00:00','5','',
'','','','','',
'INHALATION','2022-01-20 09:00:00','Baystate','HSAA.Medication',5)

INSERT INTO HSAA.HSAAOrder (ORDERCODE_CODE, TagFacility, OrderCode_Description)
VALUES(126109000,'Baystate','LEVONORGESTREL (SUBSTANCE)')
INSERT INTO HSAA.HSAAOrder (ORDERCODE_CODE, TagFacility, OrderCode_Description)
VALUES(326428000,'Baystate','LEVONORGESTREL 52MG INTRAUTERINE SYSTEM (PRODUCT)')
INSERT INTO HSAA.HSAAOrder (ORDERCODE_CODE, TagFacility, OrderCode_Description)
VALUES(326428000,'Baystate','Albuterol (albuterol (OP))')
INSERT INTO HSAA.HSAAOrder (ORDERCODE_CODE, TagFacility, OrderCode_Description)
VALUES(326428000,'Baystate','Creatine')
INSERT INTO HSAA.HSAAOrder (ORDERCODE_CODE, TagFacility, OrderCode_Description)
VALUES(326428000,'Baystate','ydrocortisone topical 2.5% lotion')




-- device_exposure
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'25062003','FEEDING TUBE, DEVICE (PHYSICAL OBJECT)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 1)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'10906003','VEIN STRIPPER, DEVICE (PHYSICAL OBJECT)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 2)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'14548009','HARRINGTON ROD, DEVICE (PHYSICAL OBJECT)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 3)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'257354000','VENTRICULOPERITONEAL SHUNT DEVICE (PHYSICAL OBJECT)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 4)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'43252007','COCHLEAR PROSTHESIS, DEVICE (PHYSICAL OBJECT)','2022-01-10 09:00:00','',
'123','888','','','',
'Baystate', 5)



-- specimen 
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'111002','PARATHYROID STRUCTURE (BODY STRUCTURE)','2022-01-10 09:00:00','',
'123','888','','','10134009',
'Baystate', 1)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'1159005','STRUCTURE OF FRENULUM LINGUAE (BODY STRUCTURE)','2022-01-10 09:00:00','',
'123','888','','','309506005',
'Baystate', 2)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'119533004','MANDIBLE PART (BODY STRUCTURE)','2022-01-10 09:00:00','',
'123','888','','','309287004',
'Baystate', 3)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'12406000','LITTLE FINGER STRUCTURE (BODY STRUCTURE)','2022-01-10 09:00:00','',
'123','888','','','309189008',
'Baystate', 4)
INSERT INTO HSAA.Observation 
	(Encounter, ObservationCode_Code, ObservationCode_Description, ObservationTime, EnteredOn, 
	Clinician_Code, Clinician_SDACodingStandard, ObservationCode_ObservationValueUnits_Code, ObservationCode_ObservationValueUnits_Description, ObservationRawValue, 
	TagFacility, patient)
VALUES
(Null,'13853000','TRANSPLANTED SKIN (BODY STRUCTURE)','2022-01-10 09:00:00','',
'123','888','','','167874004',
'Baystate', 5)



-- note  
insert into HSAA.Document(CLINICIAN_CODE,CLINICIAN_SDACODINGSTANDARD,DOCUMENTNAME,DOCUMENTTIME,DOCUMENTTYPE_CODE,
DOCUMENTTYPE_DESCRIPTION,ENTEREDON,Encounter,FROMTIME,NOTETEXT,
TAGFACILITY,TOTIME,PATIENT)
VALUES(
'','','Note_title','2022-01-10 09:00:00','EMERGENCY NOTES',
'note_source','2022-01-10 09:00:00',Null,'2022-01-10 09:00:00','Note text 1.',
'Baystate','','1')
insert into HSAA.Document(CLINICIAN_CODE,CLINICIAN_SDACODINGSTANDARD,DOCUMENTNAME,DOCUMENTTIME,DOCUMENTTYPE_CODE,
DOCUMENTTYPE_DESCRIPTION,ENTEREDON,Encounter,FROMTIME,NOTETEXT,
TAGFACILITY,TOTIME,PATIENT)
VALUES
(
'','','Note_title','2022-01-10 09:00:00','EMERGENCY NOTES',
'note_source','2022-01-10 09:00:00',Null,'2022-01-10 09:00:00','Note text 2.',
'Baystate','','2')
insert into HSAA.Document(CLINICIAN_CODE,CLINICIAN_SDACODINGSTANDARD,DOCUMENTNAME,DOCUMENTTIME,DOCUMENTTYPE_CODE,
DOCUMENTTYPE_DESCRIPTION,ENTEREDON,Encounter,FROMTIME,NOTETEXT,
TAGFACILITY,TOTIME,PATIENT)
VALUES
(
'','','Note_title','2022-01-10 09:00:00','EMERGENCY NOTES',
'note_source','2022-01-10 09:00:00',Null,'2022-01-10 09:00:00','Note text 3.',
'Baystate','','3')
insert into HSAA.Document(CLINICIAN_CODE,CLINICIAN_SDACODINGSTANDARD,DOCUMENTNAME,DOCUMENTTIME,DOCUMENTTYPE_CODE,
DOCUMENTTYPE_DESCRIPTION,ENTEREDON,Encounter,FROMTIME,NOTETEXT,
TAGFACILITY,TOTIME,PATIENT)
VALUES
(
'','','Note_title','2022-01-10 09:00:00','EMERGENCY NOTES',
'note_source','2022-01-10 09:00:00',Null,'2022-01-10 09:00:00','Note text 4.',
'Baystate','','4')
insert into HSAA.Document(CLINICIAN_CODE,CLINICIAN_SDACODINGSTANDARD,DOCUMENTNAME,DOCUMENTTIME,DOCUMENTTYPE_CODE,
DOCUMENTTYPE_DESCRIPTION,ENTEREDON,Encounter,FROMTIME,NOTETEXT,
TAGFACILITY,TOTIME,PATIENT)
VALUES
(
'','','Note_title','2022-01-10 09:00:00','EMERGENCY NOTES',
'note_source','2022-01-10 09:00:00',Null,'2022-01-10 09:00:00','Note text 5.',
'Baystate','','5')