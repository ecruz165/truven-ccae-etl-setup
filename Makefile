ENVIRONMENT ?= aws


# APPLY INFRA
# - executes terraform init, plan, apply 
# - creates redshift cluster for vocab data
# - create s3 buckets for truven ccae as csv
apply-infra:
	@echo "APPLYING INFA..."
	time bash -c ".scripts/apply-infra.sh $(ENVIRONMENT)"
.PHONY: apply-infra


# UPLOAD VOCAB DATA
# - uploads csv file and places is provided s3 bucket in the folder specificed
upload-vocab-data:
	@echo "UPLOADING VOCAB DATA..."
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/CONCEPT_ANCESTOR.csv cdm-builder-setup-files /vocab-files" 
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/CONCEPT_CLASS.csv cdm-builder-setup-files /vocab-files" 
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/CONCEPT_CPT4.csv cdm-builder-setup-files /vocab-files" 
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/CONCEPT_RELATIONSHIP.csv cdm-builder-setup-files /vocab-files" 
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/CONCEPT_CPT4.csv cdm-builder-setup-files /vocab-files" 
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/CONCEPT_SYNONYM.csv cdm-builder-setup-files /vocab-files" 
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/CONCEPT.csv cdm-builder-setup-files /vocab-files"
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/DOMAIN.csv cdm-builder-setup-files /vocab-files"
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/DRUG_STRENGTH.csv cdm-builder-setup-files /vocab-files"
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/RELATIONSHIP.csv cdm-builder-setup-files /vocab-files"
	bash -c ".scripts/upload-vocab-file.sh ./vocab-files/VOCABULARY.csv cdm-builder-setup-files /vocab-files"
.PHONY: upload-vocab-data


# CREATE VOCAB TABLE (NOT WORKING YET - Permission issue)
# - creates redshift table using local sql script 
create-vocab-table:
	@echo "CREATING VOCAB TABLES..."
	bash -c ".scripts/create-table.sh CONCEPT_ANCESTOR ./vocab-ddl/CONCEPT_ANCESTOR.sql"
	bash -c ".scripts/create-table.sh CONCEPT_CLASS ./vocab-ddl/CONCEPT_CLASS.sql"
	bash -c ".scripts/create-table.sh CONCEPT_CPT4 ./vocab-ddl/CONCEPT_CPT4.sql"
	bash -c ".scripts/create-table.sh CONCEPT_RELATIONSHIP ./vocab-ddl/CONCEPT_RELATIONSHIP.sql"
	bash -c ".scripts/create-table.sh CONCEPT_SYNONYM ./vocab-ddl/CONCEPT_SYNONYM.sql"
	bash -c ".scripts/create-table.sh CONCEPT ./vocab-ddl/CONCEPT.sql"
	bash -c ".scripts/create-table.sh DOMAIN ./vocab-ddl/DOMAIN.sql"
	bash -c ".scripts/create-table.sh DRUG_STRENGTH ./vocab-ddl/DRUG_STRENGTH.sql"
	bash -c ".scripts/create-table.sh RELATIONSHIP ./vocab-ddl/RELATIONSHIP.sql"
	bash -c ".scripts/create-table.sh VOCABULARY ./vocab-ddl/VOCABULARY.sql"
.PHONY: create-vocab-table


# IMPORT VOCAB DATA (NOT WORKING YET - Permission issue)
# - imports into designated table the updated s3 stored csv file 
import-vocab-data:
	@echo "IMPORTING VOCAB DATA..."
	bash -c ".scripts/import-vocab-table.sh CONCEPT_ANCESTOR s3://cdm-builder-setup-files/vocab-files/CONCEPT_ANCESTOR.csv"
	bash -c ".scripts/import-vocab-table.sh CONCEPT_CLASS  s3://cdm-builder-setup-files/vocab-files/CONCEPT_CLASS.csv"
	bash -c ".scripts/import-vocab-table.sh CONCEPT_CPT4 s3://cdm-builder-setup-files/vocab-files/CONCEPT_CPT4.csv"
	bash -c ".scripts/import-vocab-table.sh CONCEPT_RELATIONSHIP s3://cdm-builder-setup-files/vocab-files/CONCEPT_RELATIONSHIP.csv"
	bash -c ".scripts/import-vocab-table.sh CONCEPT_CPT4 s3://cdm-builder-setup-files/vocab-files/CONCEPT_CPT4.csv"
	bash -c ".scripts/import-vocab-table.sh CONCEPT_SYNONYM s3://cdm-builder-setup-files/vocab-files/CONCEPT_SYNONYM.csv"
	bash -c ".scripts/import-vocab-table.sh CONCEPT s3://cdm-builder-setup-files/vocab-files/CONCEPT.csv"
	bash -c ".scripts/import-vocab-table.sh DOMAIN s3://cdm-builder-setup-files/vocab-files/DOMAIN.csv"
	bash -c ".scripts/import-vocab-table.sh DRUG_STRENGTH s3://cdm-builder-setup-files/vocab-files/DRUG_STRENGTH.csv"
	bash -c ".scripts/import-vocab-table.sh RELATIONSHIP s3://cdm-builder-setup-files/vocab-files/RELATIONSHIP.csv"
	bash -c ".scripts/import-vocab-table.sh VOCABULARY s3://cdm-builder-setup-files/vocab-files/VOCABULARY.csv"
	@echo "IMPORTED VOCAB DATA"
.PHONY: import-vocab-data


# UPLOAD TRUVEN DATA
# - uploads csv file and places is provided s3 bucket in the folder specificed
upload-truven-data:
	NY
	@echo "UPLOADING TRUVEN DATA..."
	bash -c ".scripts/upload-files-to-s3.sh ./truven-files/083 cdm-builder-setup-files /truven-files/083"
#	bash -c ".scripts/upload-files-to-s3.sh ./truven-files/093 cdm-builder-setup-files /truven-files/093"
	@echo "UPLOADED TRUVEN DATA"
.PHONY: upload-truven-data


etl-build:
	dotnet publish ./etl-lambdabuilder/sources/org.ohdsi.cdm.sln
.PHONY: etl-build

etl-start:
	cd ./etl-lambdabuilder/sources/Presentation/org.ohdsi.cdm.presentation.etl2 && \
	./bin/Release/net8.0-windows/org.ohdsi.cdm.presentation.etl.exe \
	--skip_etl false \
  	--skip_lookup false \
  	--skip_chunk false \
  	--resume false \
  	--skip_build false \
  	--skip_cdmsource false \
  	--skip_vocabulary false \
  	--skip_validation false \
  	--skip_merge false \
	--new true \
	--vendor ccae \
	-- batchSize 1000
.PHONY: etl-start
	


