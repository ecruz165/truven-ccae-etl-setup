CREATE TABLE columbiadbmidb.vocab.DOMAIN(
	domain_id varchar(20) NOT NULL,
	domain_name varchar(255) NOT NULL,
	domain_concept_id int NOT NULL
);
COPY columbiadbmidb.vocab.DOMAIN
FROM 's3://cdm-builder-setup-files/vocab-files/DOMAIN.csv'
IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role'
FORMAT AS CSV
DELIMITER '\t'
QUOTE '"'
IGNOREHEADER 1
REGION 'us-east-1'
DATEFORMAT 'YYYYMMDD';