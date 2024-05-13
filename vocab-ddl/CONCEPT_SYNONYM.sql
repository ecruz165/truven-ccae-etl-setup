CREATE TABLE columbiadbmidb.vocab.CONCEPT_SYNONYM(
	concept_id int NOT NULL,
	concept_synonym_name varchar(1000) NOT NULL,
	language_concept_id int NOT NULL
);
COPY columbiadbmidb.vocab.CONCEPT_SYNONYM
FROM 's3://cdm-builder-setup-files/vocab-files/CONCEPT_SYNONYM.csv'
IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role'
FORMAT AS CSV
DELIMITER '\t'
QUOTE '"'
IGNOREHEADER 1
REGION 'us-east-1'
DATEFORMAT 'YYYYMMDD';
