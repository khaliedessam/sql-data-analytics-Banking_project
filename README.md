<<<<<<< HEAD
<<<<<<< HEAD
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

### Gold Layer

The gold layer exposes analytical views in a star-schema style model.

Dimensions:

- `gold.dim_customer`
- `gold.dim_accounts`
- `gold.dim_merchant`
- `gold.dim_date`

Fact:

- `gold.fact_transactions`

Main script:

- [Scripts/Gold/Ddl Gold Layer.sql](/abs/path/d:/SQL%20ITI/banking/sql-data-analytics-Banking_project/Scripts/Gold/Ddl%20Gold%20Layer.sql)

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
=======
=======
>>>>>>> 779bd3e5d42e0f50cb6fe671580074c7548a4568
# Data Warehouse and Analytics Project

Welcome to the Data Warehouse and Analytics Project repository.
This project demonstrates a comprehensive data warehousing and analytics solution — from building a data warehouse to generating actionable insights.
, it highlights industry best practices in data engineering and analytics.

## 📖 Project Overview
This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports  for actionable insights.
---
# 🛠️ Important Links & Tools:

Everything is for Free!
- **[Datasets](datasets/):** Access to the project dataset (csv files).
- **[SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads):** Lightweight server for hosting your SQL database.
- **[SQL Server Management Studio (SSMS)](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16):** GUI for managing and interacting with databases.
- **[Git Repository](https://github.com/):** Set up a GitHub account and repository to manage, version, and collaborate on your code efficiently.
- **[DrawIO](https://www.drawio.com/):** Design data architecture, models, flows, and diagrams.
## 🚀 Project Requirements

#### Objective
Develop a modern data warehouse using SQL Server to consolidate banking transaction data, enabling analytical reporting, customer insights, and data-driven decision-making.
- **Customer Behavior**
- **Transaction Activity**
- **Financial Trends**

#### Specifications
- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.
<<<<<<< HEAD
>>>>>>> 779bd3e5d42e0f50cb6fe671580074c7548a4568
=======
>>>>>>> 779bd3e5d42e0f50cb6fe671580074c7548a4568

## Data Model and Documentation

The `Docs` folder includes visual project assets:

### Data Flow Diagram

![Data Flow Diagram](Docs/Data%20flow%20diagram.png)

<<<<<<< HEAD
<<<<<<< HEAD
### Data Modeling

![Data Modeling](Docs/Data%20Modeling.png)

=======
>>>>>>> 779bd3e5d42e0f50cb6fe671580074c7548a4568
=======
>>>>>>> 779bd3e5d42e0f50cb6fe671580074c7548a4568
### Integration Model

![Integration Model](Docs/Integration%20Model.png)

<<<<<<< HEAD
<<<<<<< HEAD
These diagrams illustrate the end-to-end warehouse flow, data model structure, and integration design used in the project.
=======
### Data Modeling

![Data Modeling](Docs/Data%20Modeling.png)
>>>>>>> 779bd3e5d42e0f50cb6fe671580074c7548a4568
=======
### Data Modeling

![Data Modeling](Docs/Data%20Modeling.png)
>>>>>>> 779bd3e5d42e0f50cb6fe671580074c7548a4568

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
<<<<<<< HEAD
<<<<<<< HEAD

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
=======
=======
>>>>>>> 779bd3e5d42e0f50cb6fe671580074c7548a4568
## 🚀 How to Run This Project 
### 1️⃣ Prerequisites

Make sure you have:

- SQL Server (2019 or later recommended)
- SQL Server Management Studio (SSMS)
- - Access to create databases and run stored procedures
- The project folder including:
- - `/datasets` CSV files
  - `/bronze` scripts
  - `/silver` scripts
  - `/gold` scripts
   - `/analytics` scripts

---

## 🥉 Step 1 — Create Bronze Layer (Raw Data Ingestion)
### 1️⃣ Initialize Database

Run:

`init_database.sql`

This will:
- Drop and recreate the database
- Create schemas:
  - `bronze`
  - `silver`
  - `gold`
## 2️⃣ Create Bronze Tables

Run:

`Ddl Query for Bronze Layer.sql`

This creates raw source tables in the `bronze` schema.

---

### 3️⃣ Create Bronze Load Procedure

Run:

`Stored Procedures for Bronze Layer.sql`

This creates:

`bronze.load_bronze`

---
### 4️⃣ Update CSV File Paths

Inside `bronze.load_bronze`, update the `BULK INSERT` file paths to match your local machine.

---

### 5️⃣ Load Bronze Data

Execute:

```sql
EXEC bronze.load_bronze;
```
---
## 🥈 Step 2 — Create Silver Layer (Data Cleaning & Transformation)

The Silver layer transforms raw Bronze data into clean, structured, and standardized datasets.

---

## 1️⃣ Create Silver Tables

Run:

`Ddl Query for Silver Layer.sql`

This will:

- Drop existing Silver tables (if any)
- Create structured tables in the `silver` schema

---

## 2️⃣ Create Silver Load Procedure

Run:

`Stored Procedures for Silver Layer.sql`

This creates:

`silver.load_silver`

---

## 3️⃣ Execute Silver ETL Process

Run:

```sql
EXEC silver.load_silver;
```
---
## 🥇 Step 3 —Gold Layer — Business Model (Star Schema)

The Gold layer exposes business-ready data using a Star Schema design.

It includes:

- 4 Dimension Views
- 1 Fact View

---

## 🎯 Gold Objects

- `gold.dim_customer`
- `gold.dim_accounts`
- `gold.dim_date`
- `gold.dim_merchant`
- `gold.fact_transactions`

These are implemented as SQL Views built on top of Silver tables.

---

## 1️⃣ Create Gold Views

Run:

`Ddl gold layer.sql`

This script:

- Drops existing Gold views (if they exist)
- Recreates:
  - `gold.dim_customer`
  - `gold.dim_accounts`
  - `gold.dim_date`
  - `gold.dim_merchant`
  - `gold.fact_transactions`

---
<<<<<<< HEAD
>>>>>>> 779bd3e5d42e0f50cb6fe671580074c7548a4568
=======
>>>>>>> 779bd3e5d42e0f50cb6fe671580074c7548a4568
