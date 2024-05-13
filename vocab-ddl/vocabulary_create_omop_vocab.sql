IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[standard_concepts]') AND type in (N'U'))
  DROP TABLE [omop_vocab].[standard_concepts]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[vocabulary]') AND type in (N'U'))
DROP TABLE [omop_vocab].[vocabulary]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[relationship]') AND type in (N'U'))
DROP TABLE [omop_vocab].[relationship]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[drug_strength]') AND type in (N'U'))
DROP TABLE [omop_vocab].[drug_strength]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[domain]') AND type in (N'U'))
DROP TABLE [omop_vocab].[domain]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[concept_synonym]') AND type in (N'U'))
DROP TABLE [omop_vocab].[concept_synonym]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[concept_relationship]') AND type in (N'U'))
DROP TABLE [omop_vocab].[concept_relationship]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[concept_class]') AND type in (N'U'))
DROP TABLE [omop_vocab].[concept_class]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[concept_ancestor]') AND type in (N'U'))
DROP TABLE [omop_vocab].[concept_ancestor]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[concept]') AND type in (N'U'))
DROP TABLE [omop_vocab].[concept]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[concept]') AND type in (N'U'))
BEGIN
CREATE TABLE [omop_vocab].[concept](
	[concept_id] [int] NOT NULL,
	[concept_name] [varchar](1000) NOT NULL,
	[domain_id] [varchar](20) NOT NULL,
	[vocabulary_id] [varchar](20) NOT NULL,
	[concept_class_id] [varchar](20) NOT NULL,
	[standard_concept] [varchar](1) NULL,
	[concept_code] [varchar](50) NOT NULL,
	[valid_start_date] [date] NOT NULL,
	[valid_end_date] [date] NOT NULL,
	[invalid_reason] [varchar](1) NULL
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[concept_ancestor]') AND type in (N'U'))
BEGIN
CREATE TABLE [omop_vocab].[concept_ancestor](
	[ancestor_concept_id] [int] NOT NULL,
	[descendant_concept_id] [int] NOT NULL,
	[min_levels_of_separation] [int] NOT NULL,
	[max_levels_of_separation] [int] NOT NULL
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[concept_class]') AND type in (N'U'))
BEGIN
CREATE TABLE [omop_vocab].[concept_class](
	[concept_class_id] [varchar](20) NOT NULL,
	[concept_class_name] [varchar](255) NOT NULL,
	[concept_class_concept_id] [int] NOT NULL
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[concept_relationship]') AND type in (N'U'))
BEGIN
CREATE TABLE [omop_vocab].[concept_relationship](
	[concept_id_1] [int] NOT NULL,
	[concept_id_2] [int] NOT NULL,
	[relationship_id] [varchar](20) NOT NULL,
	[valid_start_date] [date] NOT NULL,
	[valid_end_date] [date] NOT NULL,
	[invalid_reason] [varchar](1) NULL
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[concept_synonym]') AND type in (N'U'))
BEGIN
CREATE TABLE [omop_vocab].[concept_synonym](
	[concept_id] [int] NOT NULL,
	[concept_synonym_name] [varchar](1000) NOT NULL,
	[language_concept_id] [int] NOT NULL
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[domain]') AND type in (N'U'))
BEGIN
CREATE TABLE [omop_vocab].[domain](
	[domain_id] [varchar](20) NOT NULL,
	[domain_name] [varchar](255) NOT NULL,
	[domain_concept_id] [int] NOT NULL
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[drug_strength]') AND type in (N'U'))
BEGIN
CREATE TABLE [omop_vocab].[drug_strength](
	[drug_concept_id] [int] NOT NULL,
	[ingredient_concept_id] [int] NOT NULL,
	[amount_value] [float] NULL,
	[amount_unit_concept_id] [int] NULL,
	[numerator_value] [float] NULL,
	[numerator_unit_concept_id] [int] NULL,
	[denominator_value] [float] NULL,
	[denominator_unit_concept_id] [int] NULL,
  [box_size]						[int]		NULL,
	[valid_start_date] [date] NOT NULL,
	[valid_end_date] [date] NOT NULL,
	[invalid_reason] [varchar](1) NULL
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[relationship]') AND type in (N'U'))
BEGIN
CREATE TABLE [omop_vocab].[relationship](
	[relationship_id] [varchar](20) NOT NULL,
	[relationship_name] [varchar](255) NOT NULL,
	[is_hierarchical] [varchar](1) NOT NULL,
	[defines_ancestry] [varchar](1) NOT NULL,
	[reverse_relationship_id] [varchar](20) NOT NULL,
	[relationship_concept_id] [int] NOT NULL
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[vocabulary]') AND type in (N'U'))
BEGIN
CREATE TABLE [omop_vocab].[vocabulary](
	[vocabulary_id] [varchar](20) NOT NULL,
	[vocabulary_name] [varchar](255) NOT NULL,
	[vocabulary_reference] [varchar](255) NULL,
	[vocabulary_version] [varchar](255) NULL,
	[vocabulary_concept_id] [int] NOT NULL
)
END
GO

--Table that contains the standard concepts for each concept
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[omop_vocab].[standard_concepts]') AND type in (N'U'))
BEGIN
CREATE TABLE [omop_vocab].[standard_concepts](
  [SOURCE_CODE] [varchar](50) NOT NULL,
  [SOURCE_CONCEPT_ID] [int] NOT NULL,
  [SOURCE_CODE_NAME] [varchar](255) NULL,
  [SOURCE_VOCABULARY_ID] [varchar](20) NOT NULL,
  [SOURCE_DOMAIN_ID] [varchar](20) NULL,
  [SOURCE_CONCEPT_CLASS_ID] [varchar](20) NULL,
  [TARGET_CODE] [varchar](50) NULL,
  [TARGET_CONCEPT_ID] [int] NULL,
  [TARGET_CONCEPT_NAME] [varchar](255) NULL,
  [TARGET_VOCABULARY_ID] [varchar](20)  NULL,
  [TARGET_DOMAIN_ID] [varchar](20) NULL,
  [TARGET_CONCEPT_CLASS_ID] [varchar](20) NULL
)
END
GO
