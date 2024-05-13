CREATE TABLE columbiadbmidb.vocab.CONCEPT_CLASS(
	concept_class_id varchar(20) NOT NULL,
	concept_class_name varchar(255) NOT NULL,
	concept_class_concept_id int NOT NULL
);
COPY columbiadbmidb.vocab.CONCEPT_CLASS
FROM 's3://cdm-builder-setup-files/vocab-files/CONCEPT_CLASS.csv'
IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role'
FORMAT AS CSV
DELIMITER '\t'
QUOTE '"'
IGNOREHEADER 1
REGION 'us-east-1'
DATEFORMAT 'YYYYMMDD';