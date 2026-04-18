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

## Data Model and Documentation

The `Docs` folder includes visual project assets:

### Data Flow Diagram

![Data Flow Diagram](Docs/Data%20flow%20diagram.png)

### Integration Model

![Integration Model](Docs/Integration%20Model.png)

### Data Modeling

![Data Modeling](Docs/Data%20Modeling.png)

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
