CREATE TABLE columbiadbmidb.vocab.DRUG_STRENGTH(
	drug_concept_id int NOT NULL,
	ingredient_concept_id int NOT NULL,
	amount_value float NULL,
	amount_unit_concept_id int NULL,
	numerator_value float NULL,
	numerator_unit_concept_id int NULL,
	denominator_value float NULL,
	denominator_unit_concept_id int NULL,
    box_size int NULL,
	valid_start_date date NOT NULL,
	valid_end_date date NOT NULL,
	invalid_reason varchar(1) NULL
);
COPY columbiadbmidb.vocab.DRUG_STRENGTH
FROM 's3://cdm-builder-setup-files/vocab-files/DRUG_STRENGTH.csv'
IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role'
FORMAT AS CSV
DELIMITER '\t'
QUOTE '"'
IGNOREHEADER 1
REGION 'us-east-1'
DATEFORMAT 'YYYYMMDD';