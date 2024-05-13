CREATE TABLE columbiadbmidb.vocab.VOCABULARY(
	vocabulary_id varchar(20) NOT NULL,
	vocabulary_name varchar(255) NOT NULL,
	vocabulary_reference varchar(255) NULL,
	vocabulary_version varchar(255) NULL,
	vocabulary_concept_id int NOT NULL
);
COPY columbiadbmidb.vocab.VOCABULARY
FROM 's3://cdm-builder-setup-files/vocab-files/VOCABULARY.csv'
IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role'
FORMAT AS CSV
DELIMITER '\t'
QUOTE '"'
IGNOREHEADER 1
REGION 'us-east-1'
DATEFORMAT 'YYYYMMDD';