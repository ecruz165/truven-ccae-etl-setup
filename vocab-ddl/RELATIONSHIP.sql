CREATE TABLE columbiadbmidb.vocab.RELATIONSHIP(
	relationship_id varchar(20) NOT NULL,
	relationship_name varchar(255) NOT NULL,
	is_hierarchical varchar(1) NOT NULL,
	defines_ancestry varchar(1) NOT NULL,
	reverse_relationship_id varchar(20) NOT NULL,
	relationship_concept_id int NOT NULL
);
COPY columbiadbmidb.vocab.RELATIONSHIP
FROM 's3://cdm-builder-setup-files/vocab-files/RELATIONSHIP.csv'
IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role'
FORMAT AS CSV
DELIMITER '\t'
QUOTE '"'
IGNOREHEADER 1
REGION 'us-east-1'
DATEFORMAT 'YYYYMMDD';