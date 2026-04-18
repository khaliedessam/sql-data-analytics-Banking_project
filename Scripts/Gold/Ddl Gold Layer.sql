/*
===================================================================================================
DDL Script: Create Gold Views
===================================================================================================
Script Purpose:
       This script creates views for the Gold Layer in the data warehouse.
       The Gold Layer represents the final dimension and fact tables (Star Schema)
         
       Each view performs transformations and combines data from the Silver layer 
       to produce a clean,enriched,and business-ready dataset.

Usage:
     - These views can be queried directly for analytics and reporting.
==================================================================================================
*/

--Create Dimension: (gold.dim_customers)
--Create surrogate key (customer_key) to use it to connect the data model 


IF OBJECT_ID('gold.dim_customer','V') IS NOT NULL
DROP VIEW  gold.dim_customer 
GO
create view gold.dim_customer as 
select 
         ROW_NUMBER() OVER(ORDER BY customer_id ) AS customer_key,
         customer_id,
         CONCAT(first_name,' ',last_name) AS full_name,
         email,
         credit_score,           
         city,
         created_at
from silver.customers 

--Create Dimension: (gold.dim_accounts)
--Create surrogate key (account_key) to use it to connect the data model 

IF OBJECT_ID('gold.dim_accounts','V') IS NOT NULL
DROP VIEW  gold.dim_accounts 
GO
create view gold.dim_accounts as 
select
        ROW_NUMBER() OVER(ORDER BY a.account_id) as account_key,
        a.account_id,
        a.customer_id,
        a.account_type,
        a.balance_usd,
        a.open_date,
        CASE WHEN COUNT(c.card_id) > 0 THEN 'Yes' 
             ELSE 'No'
             END AS has_card ,
             COUNT(c.card_id) AS total_cards     
from silver.accounts a
left join silver.cards c
on a.account_id=c.account_id
group by a.account_id,
         a.customer_id,
         a.account_type,
         a.balance_usd,
         a.open_date


--Create Dimension: (gold.dim_merchant)
--Create surrogate key (merchant_key) to use it to connect the data model 

IF OBJECT_ID('gold.dim_merchant','V') IS NOT NULL
    DROP VIEW gold.dim_merchant
GO

CREATE VIEW gold.dim_merchant AS
select    
        ROW_NUMBER() OVER(ORDER BY merchant_id) as merchant_key,
          merchant_id,
          merchant_name,
          city
from silver.merchants


--Create Dimension: (gold.dim_date)
--Create surrogate key (date_key) to use it to connect the data model 

IF OBJECT_ID('gold.dim_date','V') IS NOT NULL
    DROP VIEW gold.dim_date
GO

CREATE VIEW gold.dim_date AS

with dim_date as (
select distinct
           cast(transaction_date as date) as transaction_date 
              
from silver.transactions )
select 
        convert(int,format(transaction_date,'yyyyMMdd')) as date_key,
        transaction_date,
        day(transaction_date) as day_number,
        month(transaction_date) as month_number,
        year(transaction_date) as year_number,
        datename(month,transaction_date) as month_name,
        datename(weekday,transaction_date) as weekday_name,
        datepart(quarter,transaction_date) as quarter_number
from dim_date 

 

-----------------------------------------------------
select top 5 * from gold.dim_date
select top 5 * from silver.transactions
select top 5 * from gold.dim_merchant
select top 5 * from gold.dim_branches
select top 5 * from gold.dim_accounts
select top 5 * from gold.dim_customer


--Create Fact: (gold.fact_transactions) that has transactions and events.
--Fact is connecting multiple dimensions
--Use the dimension`s surrogate keys instead of IDs to easily connect facts with dimensions.(Join fact with four dimension tables)



IF OBJECT_ID('gold.fact_transactions','V') IS NOT NULL
DROP View gold.fact_transactions

GO

CREATE VIEW  gold.fact_transactions as
select  
        t.transaction_id,
        t.amount_usd,
        a.account_key,
        c.customer_key,
        m.merchant_key,
        d.date_key


from silver.transactions t
left join gold.dim_accounts a
on t.account_id = a.account_id 
left join gold.dim_customer c
on a.customer_id = c.customer_id
left join gold.dim_merchant m
on t.merchant_id = m.merchant_id
left join gold.dim_date d
on t.transaction_date  = d.transaction_date







