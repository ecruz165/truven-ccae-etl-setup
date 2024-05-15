
import-vocab-data:
	@echo "COPYING VOCAB DATA..."
#	COPY columbiadbmidb.vocab.VOCABULARY FROM 's3://cdm-builder-setup-files/vocab-files/VOCABULARY.csv' IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role' FORMAT AS CSV DELIMITER '\t' QUOTE '"' IGNOREHEADER 1 REGION AS 'us-east-1'
 #   COPY columbiadbmidb.vocab.RELATIONSHIP FROM 's3://cdm-builder-setup-files/vocab-files/RELATIONSHIP.csv' IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role' FORMAT AS CSV DELIMITER '\t' QUOTE '"' REGION AS 'us-east-1'
 #   COPY columbiadbmidb.vocab.DRUG_STRENGTH FROM 's3://cdm-builder-setup-files/vocab-files/DRUG_STRENGTH.csv' IAM_ROLE 'arn:aws:iam::992382423790:role/columbia-dbmi-truven-etl-dev-redshift-role' FORMAT AS CSV DELIMITER '\t' QUOTE '"' REGION AS 'us-east-1'
.PHONY: import-vocab-data	