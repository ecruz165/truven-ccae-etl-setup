CREATE TABLE columbiadbmidb.vocab.CONCEPT_RELATIONSHIP(
	concept_id_1 int NOT NULL,
	concept_id_2 int NOT NULL,
	relationship_id varchar(20) NOT NULL,
	valid_start_date date NOT NULL,
	valid_end_date date NOT NULL,
	invalid_reason varchar(1) NULL
);
COPY columbiadbmidb.vocab.CONCEPT_RELATIONSHIP
FROM 's3://cdm-builder-setup-files/vocab-files/CONCEPT_RELATIONSHIP.csv'
IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role'
FORMAT AS CSV
DELIMITER '\t'
QUOTE '"'
IGNOREHEADER 1
REGION 'us-east-1'
DATEFORMAT 'YYYYMMDD';