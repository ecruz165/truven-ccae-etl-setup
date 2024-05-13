/************************
*************************																																			ALTER TABLE [omop_vocab].
*************************
*************************

Primary key constraints

*************************
*************************
*************************
************************/



/************************

Standardized vocabulary

************************/
ALTER TABLE [omop_vocab].concept ADD CONSTRAINT xpk_concept PRIMARY KEY NONCLUSTERED (concept_id);

ALTER TABLE [omop_vocab].vocabulary ADD CONSTRAINT xpk_vocabulary PRIMARY KEY NONCLUSTERED (vocabulary_id);

ALTER TABLE [omop_vocab].domain ADD CONSTRAINT xpk_domain PRIMARY KEY NONCLUSTERED (domain_id);

ALTER TABLE [omop_vocab].concept_class ADD CONSTRAINT xpk_concept_class PRIMARY KEY NONCLUSTERED (concept_class_id);

ALTER TABLE [omop_vocab].concept_relationship ADD CONSTRAINT xpk_concept_relationship PRIMARY KEY NONCLUSTERED (concept_id_1,concept_id_2,relationship_id);

ALTER TABLE [omop_vocab].relationship ADD CONSTRAINT xpk_relationship PRIMARY KEY NONCLUSTERED (relationship_id);

ALTER TABLE [omop_vocab].concept_ancestor ADD CONSTRAINT xpk_concept_ancestor PRIMARY KEY NONCLUSTERED (ancestor_concept_id,descendant_concept_id);

ALTER TABLE [omop_vocab].drug_strength ADD CONSTRAINT xpk_drug_strength PRIMARY KEY NONCLUSTERED (drug_concept_id, ingredient_concept_id);

/************************
*************************
*************************
*************************

Indices

*************************
*************************
*************************
************************/


/************************

Standardized vocabulary

************************/
CREATE UNIQUE CLUSTERED INDEX idx_concept_concept_id ON [omop_vocab].concept (concept_id ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_concept_code ON [omop_vocab].concept (concept_code ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_concept_vocabluary_id ON [omop_vocab].concept (vocabulary_id ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_concept_domain_id ON [omop_vocab].concept (domain_id ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_concept_class_id ON [omop_vocab].concept (concept_class_id ASC) WITH ( DATA_COMPRESSION = PAGE );

CREATE UNIQUE CLUSTERED INDEX idx_vocabulary_vocabulary_id ON [omop_vocab].vocabulary (vocabulary_id ASC) WITH ( DATA_COMPRESSION = PAGE );

CREATE UNIQUE CLUSTERED INDEX idx_domain_domain_id ON [omop_vocab].domain (domain_id ASC) WITH ( DATA_COMPRESSION = PAGE );

CREATE UNIQUE CLUSTERED INDEX idx_concept_class_class_id ON [omop_vocab].concept_class (concept_class_id ASC) WITH ( DATA_COMPRESSION = PAGE );

CREATE INDEX idx_concept_relationship_id_1 ON [omop_vocab].concept_relationship (concept_id_1 ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_concept_relationship_id_2 ON [omop_vocab].concept_relationship (concept_id_2 ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_concept_relationship_id_3 ON [omop_vocab].concept_relationship (relationship_id ASC) WITH ( DATA_COMPRESSION = PAGE );

CREATE UNIQUE CLUSTERED INDEX idx_relationship_rel_id ON [omop_vocab].relationship (relationship_id ASC) WITH ( DATA_COMPRESSION = PAGE );

CREATE CLUSTERED INDEX idx_concept_synonym_id ON [omop_vocab].concept_synonym (concept_id ASC) WITH ( DATA_COMPRESSION = PAGE );

CREATE CLUSTERED INDEX idx_concept_ancestor_id_1 ON [omop_vocab].concept_ancestor (ancestor_concept_id ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_concept_ancestor_id_2 ON [omop_vocab].concept_ancestor (descendant_concept_id ASC) WITH ( DATA_COMPRESSION = PAGE );

CREATE CLUSTERED INDEX idx_drug_strength_id_1 ON [omop_vocab].drug_strength (drug_concept_id ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_drug_strength_id_2 ON [omop_vocab].drug_strength (ingredient_concept_id ASC) WITH ( DATA_COMPRESSION = PAGE );

--index for the new table for standard concepts
CREATE INDEX idx_source_concept_id ON [omop_vocab].standard_concepts (source_concept_id ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_source_code ON [omop_vocab].standard_concepts (source_code ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_source_vocabluary_id ON [omop_vocab].standard_concepts (source_vocabulary_id ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_source_domain_id ON [omop_vocab].standard_concepts (source_domain_id ASC) WITH ( DATA_COMPRESSION = PAGE );

CREATE INDEX idx_target_concept_id ON [omop_vocab].standard_concepts (target_concept_id ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_target_code ON [omop_vocab].standard_concepts (target_code ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_target_vocabluary_id ON [omop_vocab].standard_concepts (target_vocabulary_id ASC) WITH ( DATA_COMPRESSION = PAGE );
CREATE INDEX idx_target_domain_id ON [omop_vocab].standard_concepts (target_domain_id ASC) WITH ( DATA_COMPRESSION = PAGE );