# Setting up ETL of IBM Truven CCAE Files to CDM
This repo aims to streamline the setup effort to run the ETL processing of the CCAE files using the  [ETL-LambdaBuilder Project](https://github.com/OHDSI/ETL-LambdaBuilder) maintained by [OHDSI](https://www.ohdsi.org/). This setup uses Gradle, a popular automation tool for multi-language software development. Gradle controls the development process from compilation and packaging to testing, deployment, and publishing.

##
## Clone this project
Be aware that this project has the [ETL-LambdaBuilder Project](https://github.com/OHDSI/ETL-LambdaBuilder) as a submodule so be aware and clone project the following way:
``` sh
git clone --recurse-submodules https://github.com/ecruz165/truven-ccae-etl-setup.git
```
 if the repository was already cloned without this option,  initialize and update the submodules manually:
 ``` sh
git submodule update --init --recursive
 ```
## Prerequisites 
- Windows OS on Intel Chipset
- Dotnet 8
- Java 21
- Python 11

## The Project Project Outline
- Setup personal computer and/or VDI
- Build and Run Unit Test for **ETL-LambdaBuilder** project 
- Obtain AWS access 
- Obtain access to IBM Truven Files (.sas7bdat)
- Obttain latest Vocabulary Data
- Create a bucket to hold data sources: **cdm-builder-setup-files** 
- Upload large data files to **cdm-builder-setup-files**
  - Upload at least 2 years worth of data
  - Upload the Vocab data 
- Create Infrastructure 
    -  create buckets
    -  deploy CdmBuilkderLambda
    -  deploy Merge Lambda
    -  Create Redshift schema and tables for source data 
    -  Create Redshift schema and tables for vocab data 
 -  Configure AppSettings Files (1-3 days) **<-current status**
 -  Perform Test Run (2-4 days)
 -  Migrate, Load and Validate Test Run Results (2-4 days)
 -  Perform Incremental Test RUn (2-4 days)
 -  Migrate, Load and Validate Test RUn  (2-3)
 -  Prep for Full Run (1 day)
 -  Run Full Test (2-3 weeks) 
 -  Migrate Load, and Validate result data to Azure(2-5 days: over ~152 million records)
 -  Proces CDM data for Atlas use.(1 day)

  