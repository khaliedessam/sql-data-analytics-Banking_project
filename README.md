# Banking SQL Data Analytics Project

This project builds a SQL Server data warehouse for banking data using a medallion-style architecture (`bronze` -> `silver` -> `gold`). It loads raw CSV files, standardizes them into curated warehouse objects, and exposes business-ready views for exploratory analysis and reporting.

## Project Overview

The repository is organized around three main goals:

1. Ingest banking source data from CSV files into SQL Server.
2. Transform raw operational data into clean analytical layers.
3. Produce reusable views and SQL reports for customer, account, merchant, and time-based analysis.

## Data Sources

The project uses two source domains stored in the `Datasets` folder:

- `Source_CRM`
  - `customers.csv`
- `Source_ERP`
  - `accounts.csv`
  - `cards.csv`
  - `merchants.csv`
  - `transactions.csv`

## Architecture

### Bronze Layer

The bronze layer stores raw ingested data with minimal transformation.

Tables:

- `bronze.customers`
- `bronze.accounts`
- `bronze.cards`
- `bronze.merchants`
- `bronze.transactions`

Main scripts:

- [Scripts/Bronze/inti database.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Bronze/inti%20database.sql)
- [Scripts/Bronze/Ddl Bronze Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Bronze/Ddl%20Bronze%20Layer.sql)
- [Scripts/Bronze/Stored Procedure For Bronze Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Bronze/Stored%20Procedure%20For%20Bronze%20Layer.sql)

### Silver Layer

The silver layer copies data from bronze into structured tables intended for cleansed and standardized data. In the current version of the project, transformations are light and mainly support type alignment and layer separation.

Tables:

- `silver.customers`
- `silver.accounts`
- `silver.cards`
- `silver.merchants`
- `silver.transactions`

Main scripts:

- [Scripts/Silver/Ddl Silver Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Silver/Ddl%20Silver%20Layer.sql)
- [Scripts/Silver/Stored Procedure For Silver Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Silver/Stored%20Procedure%20For%20Silver%20Layer.sql)

### Gold Layer - Business Model (Star Schema)

The Gold layer exposes business-ready data using a banking star schema built on top of the Silver layer.

It includes:

- 4 dimension views
- 1 fact view

#### Gold Objects

- `gold.dim_customer`
- `gold.dim_accounts`
- `gold.dim_merchant`
- `gold.dim_date`
- `gold.fact_transactions`

These objects are implemented as SQL views on top of the Silver tables.

#### Create Gold Views

Run:

- [Scripts/Gold/Ddl Gold Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Gold/Ddl%20Gold%20Layer.sql)

This script:

- drops existing Gold views if they already exist
- recreates `gold.dim_customer`
- recreates `gold.dim_accounts`
- recreates `gold.dim_merchant`
- recreates `gold.dim_date`
- recreates `gold.fact_transactions`

## Analytical Outputs

The `Scripts/Analytics` folder contains SQL for exploration, KPI generation, segmentation, and reporting.

Core report views:

- `gold.report_customer`
- `gold.account_report`
- `gold.report_merchant`
- `gold.report_time`

Analysis topics included in the repository:

- database exploration
- date exploration and time trend analysis
- customer analysis and segmentation
- account performance analysis
- merchant performance analysis
- KPI exploration
- advanced business analysis with window functions and CTEs

## Data Model and Documentation

The `Docs` folder includes visual project assets:

### Data Flow Diagram

![Data Flow Diagram](Docs/Data%20flow%20diagram.png)

### Data Modeling

![Data Modeling](Docs/Data%20Modeling.png)

### Integration Model

![Integration Model](Docs/Integration%20Model.png)

These diagrams illustrate the end-to-end warehouse flow, data model structure, and integration design used in the project.

## Repository Structure

```text
.
|-- Datasets/
|   |-- Source_CRM/
|   `-- Source_ERP/
|-- Docs/
|-- Scripts/
|   |-- Bronze/
|   |-- Silver/
|   |-- Gold/
|   `-- Analytics/
|-- Test/
`-- README.md
```

## How To Run

Run the scripts in this order inside SQL Server:

1. Execute [Scripts/Bronze/inti database.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Bronze/inti%20database.sql) to create the `bank` database and schemas.
2. Execute [Scripts/Bronze/Ddl Bronze Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Bronze/Ddl%20Bronze%20Layer.sql) to create bronze tables.
3. Review and update the file paths in [Scripts/Bronze/Stored Procedure For Bronze Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Bronze/Stored%20Procedure%20For%20Bronze%20Layer.sql) so `BULK INSERT` points to your local `Datasets` folder.
4. Run `EXEC bronze.load_bronze`.
5. Execute [Scripts/Silver/Ddl Silver Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Silver/Ddl%20Silver%20Layer.sql).
6. Execute [Scripts/Silver/Stored Procedure For Silver Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Silver/Stored%20Procedure%20For%20Silver%20Layer.sql), then run `EXEC silver.load_silver`.
7. Execute [Scripts/Gold/Ddl Gold Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Gold/Ddl%20Gold%20Layer.sql) to create dimensions and fact views.
8. Run any script from `Scripts/Analytics` for reporting and analysis.
9. Run [Test/Data Quality Check.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Test/Data%20Quality%20Check.sql) to validate key warehouse objects.

## Key Business Questions Answered

This project helps answer questions such as:

- Which customers generate the highest transaction value?
- Which account types perform best?
- Which merchants drive the highest revenue?
- How do transactions trend by month, quarter, and weekday?
- Which customer credit segments contribute the most value?

## Current Notes

- The bronze loading procedure currently uses hardcoded local file paths that do not match this repository layout. Update them before running the load.
- Some scripts reference `gold.dim_branches`, but that object is not created in the current gold DDL. Those branch-related queries will fail unless that dimension is added.
- The database creation script drops and recreates the `bank` database. Do not run it against an environment that contains data you need to keep.

## Skills Demonstrated

- SQL Server DDL and DML
- `BULK INSERT` ingestion
- stored procedures
- medallion architecture
- dimensional modeling
- analytical SQL
- CTEs and window functions
- reporting views
- data quality validation
