/*
======================================================================
DDL Script: Create Bronze Tables
======================================================================
Script Purpose:
This Script creates tables in the 'bronze schema',dropping existing tables 
if they already exist.
Run this script to re-define the DDL structure of 'bronze' Tables 
======================================================================
*/


if OBJECT_ID('bronze.customers','U') IS NOT NULL
drop table bronze.customers
CREATE TABLE bronze.customers(
 customer_id VARCHAR(20) PRIMARY KEY,
 first_name VARCHAR(50),
 last_name VARCHAR(50),
 email VARCHAR(100),
 city VARCHAR(50),
 credit_score INT,
 created_at DATE
);

if OBJECT_ID('bronze.accounts','U') IS NOT NULL
drop table bronze.accounts
CREATE TABLE bronze.accounts(
 account_id VARCHAR(20) PRIMARY KEY,
 customer_id VARCHAR(20),
 account_type VARCHAR(20),
 balance_usd DECIMAL(12,2),
 open_date DATETIME,
);

if OBJECT_ID('bronze.cards','U') IS NOT NULL
drop table bronze.cards
CREATE TABLE bronze.cards(
 card_id VARCHAR(20) PRIMARY KEY,
 account_id VARCHAR(20),
 card_type VARCHAR(20),
 expiration_date DATETIME,
);

if OBJECT_ID('bronze.merchants','U') IS NOT NULL
drop table bronze.merchants
CREATE TABLE bronze.merchants(
 merchant_id VARCHAR(20) PRIMARY KEY,
 merchant_name VARCHAR(100),
 city VARCHAR(50)
);

if OBJECT_ID('bronze.transactions','U') IS NOT NULL
drop table bronze.transactions
CREATE TABLE bronze.transactions(
 transaction_id VARCHAR(25) PRIMARY KEY,
 account_id VARCHAR(20),
 merchant_id VARCHAR(20),
 amount_usd DECIMAL(12,2),
 transaction_date DATETIME,
);


