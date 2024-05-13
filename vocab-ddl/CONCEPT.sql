CREATE TABLE columbiadbmidb.vocab.CONCEPT(
	concept_id int NOT NULL,
	concept_name varchar(1000) NOT NULL,
	domain_id varchar(20) NOT NULL,
	vocabulary_id varchar(20) NOT NULL,
	concept_class_id varchar(20) NOT NULL,
	standard_concept varchar(1) NULL,
	concept_code varchar(50) NOT NULL,
	valid_start_date date NOT NULL,
	valid_end_date date NOT NULL,
	invalid_reason varchar(1) NULL
);
COPY columbiadbmidb.vocab.CONCEPT
FROM 's3://cdm-builder-setup-files/vocab-files/CONCEPT.csv'
IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role'
FORMAT AS CSV
DELIMITER '\t'
QUOTE AS '~'
IGNOREHEADER 1
REGION 'us-east-1'
DATEFORMAT 'YYYYMMDD';