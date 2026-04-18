/*
==========================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
==========================================================
Script Purpose:
       This stored procedure performs the ETL (Extract, Transform, Load) process to
       populate the 'silver' schema tables from the 'bronze' schema.

Actoins Performed:
       -Truncate Silver Tables.
	   -Inserts transformed and cleansed data from Bronze into Silver tables.

Parameters:
	   None.
	   This stored procedure does not accept any parameters or return values.
	
Usage Example:
       EXEC Silver.load_silver;
============================================================
*/




CREATE OR ALTER PROCEDURE silver.load_silver
AS
BEGIN

    
-- Truncate and Insert silver.customers
  TRUNCATE TABLE silver.customers  
        INSERT INTO silver.customers (
            customer_id,
            first_name,
            last_name,
            email,
            city,
            credit_score,
            created_at
        )
        SELECT
            customer_id,
            first_name,
            last_name,
            email,
            city,
            credit_score,
            created_at
        FROM bronze.customers;


-- Truncate and Insert silver.merchants
  TRUNCATE TABLE silver.merchants  
        INSERT INTO silver.merchants (
            merchant_id,
            merchant_name,
            city
        )
        SELECT
            merchant_id,
            merchant_name,
            city
        FROM bronze.merchants;

-- Truncate and Insert silver.accounts
TRUNCATE TABLE silver.accounts
        INSERT INTO silver.accounts (
            account_id,
            customer_id,
            account_type,
            balance_usd,
            open_date
        )
        SELECT
            account_id,
            customer_id,
            account_type,
            balance_usd,
            open_date
        FROM bronze.accounts;

-- Truncate and Insert silver.cards
TRUNCATE TABLE silver.cards
        INSERT INTO silver.cards (
            card_id,
            account_id,
            card_type,
            expiration_date
        )
        SELECT
            card_id,
            account_id,
            card_type,
            expiration_date
        FROM bronze.cards;

 -- Truncate and Insert silver.transactions
  TRUNCATE TABLE silver.transactions
        INSERT INTO silver.transactions (
            transaction_id,
            account_id,
            merchant_id,
            amount_usd,
            transaction_date
        )
        SELECT
            transaction_id,
            account_id,
            merchant_id,
            amount_usd,
            transaction_date
        FROM bronze.transactions;

 END;

 -------------------------
 EXEC silver.load_silver