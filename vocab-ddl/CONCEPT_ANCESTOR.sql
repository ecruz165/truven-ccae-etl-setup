CREATE TABLE columbiadbmidb.vocab.CONCEPT_ANCESTOR(
	ancestor_concept_id int NOT NULL,
	descendant_concept_id int NOT NULL,
	min_levels_of_separation int NOT NULL,
	max_levels_of_separation int NOT NULL
);
COPY columbiadbmidb.vocab.CONCEPT_ANCESTOR
FROM 's3://cdm-builder-setup-files/vocab-files/CONCEPT_ANCESTOR.csv'
IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role'
FORMAT AS CSV
DELIMITER '\t'
QUOTE '"'
IGNOREHEADER 1
REGION 'us-east-1'
DATEFORMAT 'YYYYMMDD';