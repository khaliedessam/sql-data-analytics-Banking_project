/*======================================================================
DDL Script: Create Silver Tables
======================================================================
Script Purpose:
This Script creates tables in the 'silver schema',dropping existing tables 
if they already exist.
Run this script to re-define the DDL structure of 'silver' Tables 
======================================================================*/

if OBJECT_ID('silver.customers','U') IS NOT NULL
   drop table silver.customers
CREATE TABLE silver.customers(
 customer_id VARCHAR(20) PRIMARY KEY,
 first_name VARCHAR(50),
 last_name VARCHAR(50),
 email VARCHAR(100),
 city VARCHAR(50),
 credit_score INT,
 created_at DATE
);

if OBJECT_ID('silver.accounts','U') IS NOT NULL
   drop table silver.accounts
CREATE TABLE silver.accounts(
 account_id VARCHAR(20) PRIMARY KEY,
 customer_id VARCHAR(20),
 account_type VARCHAR(20),
 balance_usd DECIMAL(12,2),
 open_date DATE,
);

if OBJECT_ID('silver.cards','U') IS NOT NULL
   drop table silver.cards
CREATE TABLE silver.cards(
 card_id VARCHAR(20) PRIMARY KEY,
 account_id VARCHAR(20),
 card_type VARCHAR(20),
 expiration_date DATETIME,
);

if OBJECT_ID('silver.merchants','U') IS NOT NULL
   drop table silver.merchants
CREATE TABLE silver.merchants(
 merchant_id VARCHAR(20) PRIMARY KEY,
 merchant_name VARCHAR(100),
 city VARCHAR(50)
);


if OBJECT_ID('silver.transactions','U') IS NOT NULL
   drop table silver.transactions
CREATE TABLE silver.transactions(
 transaction_id VARCHAR(25) PRIMARY KEY,
 account_id VARCHAR(20),
 merchant_id VARCHAR(20),
 amount_usd DECIMAL(12,2),
 transaction_date date,
 
);
