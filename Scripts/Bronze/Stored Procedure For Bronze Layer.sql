/*
==============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)

Script Purpose:
      This stored procedure loads data into the 'bronze' schema from external CSV files.

Actions Perofrmed:
      -Truncate the bronze tables before loading data
      -use the 'Bulk insert' command to load data from csv files to bronze tables.

Parameters:
      None.
      This stored procedure does not accept any parameters or return any values.

Usage Example:
      EXEC bronze.load_bronze;
==============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN

    -------------------------------
    -- CUSTOMERS
    -------------------------------
    TRUNCATE TABLE bronze.customers;

    BULK INSERT bronze.customers
    FROM 'D:\SQL ITI\banking\banking_dataset_kaggle\data\csv\customers.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK
    );


    -------------------------------
    -- ACCOUNTS
    -------------------------------
    TRUNCATE TABLE bronze.accounts;

    BULK INSERT bronze.accounts
    FROM 'D:\SQL ITI\banking\banking_dataset_kaggle\data\csv\accounts.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK
    );


    -------------------------------
    -- CARDS
    -------------------------------
    TRUNCATE TABLE bronze.cards;

    BULK INSERT bronze.cards
    FROM 'D:\SQL ITI\banking\banking_dataset_kaggle\data\csv\cards.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK
    );


    -------------------------------
    -- MERCHANTS
    -------------------------------
    TRUNCATE TABLE bronze.merchants;

    BULK INSERT bronze.merchants
    FROM 'D:\SQL ITI\banking\banking_dataset_kaggle\data\csv\merchants.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK
    );


    -------------------------------
    -- TRANSACTIONS
    -------------------------------
    TRUNCATE TABLE bronze.transactions;

    BULK INSERT bronze.transactions
    FROM 'D:\SQL ITI\banking\banking_dataset_kaggle\data\csv\transactions.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK
    );

END;

-------
EXEC bronze.load_bronze