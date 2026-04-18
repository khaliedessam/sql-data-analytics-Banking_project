
/*
---------------------------------------------------------------
Count all major entities
---------------------------------------------------------------
*/


--Total Customers

select count(customer_key) as total_customers
from gold.dim_customer

--Total Unique active customers making transactions (How many customers actually made transactions)

select count(distinct customer_key) as total_unique_customer
from gold.fact_transactions

--Total Accounts

select count(*) as total_accounts
from gold.dim_accounts

--Total Unique active accounts

select count(distinct account_key) as total_unique_accounts
from gold.fact_transactions


--Total Merchants

select count(*) as total_merchants
from gold.dim_merchant
SELECT 

--Total Branches

select count(*) as total_branches
from gold.dim_branches

--Total Transactions

select  count(*) as total_number_transactions
from gold.fact_transactions

--Avg Transaction per customer

select 
         round( cast(count(*) as float) / count(distinct customer_key),2) as avg_number_transactions_per_customer
from gold.fact_transactions

--Total Transaction Value (Total money moved in all transactions)

select sum(amount_usd) as total_transaction_amount
from gold.fact_transactions

--Avg Transaction Value 

select round(cast(avg(amount_usd) as float),2) as total_transaction_amount
from gold.fact_transactions

--Transaction amount amount per customer

select
         round( cast(sum(amount_usd) as float) / count(distinct customer_key),2) as avg_value_per_customer
from gold.fact_transactions

-- Revenue per transaction

select sum(amount_usd) / count(*) as revenue_per_transaction
from gold.fact_transactions



select  'total_customers' as measure_name, count(customer_key) as measure_value from gold.dim_customer
union all
select  'total_active_customer' as measure_name , count(distinct customer_key) from gold.fact_transactions
union all
select 'total_accounts'   as measure_name, count(account_key)  as measure_value from gold.dim_accounts
union all
select 'total_merchants' as measure_name, count(merchant_key) as measure_value from gold.dim_merchant
union all
select 'total_branches' as measure_name, count(branch_id) as measure_value from gold.dim_branches
union all
select 'total_number_transactions' as measure_name, count(transaction_id) as measure_value  from gold.fact_transactions
union all
select 'avg_number_transaction_per_customer' as measure_name, round( cast(count(*) as float) / count(distinct customer_key),2) as measure_value
from gold.fact_transactions
union all
select 'total_transaction_amount' as measure_name, sum(amount_usd) as measure_value from gold.fact_transactions
union all
select 'avg_transaction_amount' as measure_name, round(cast(avg(amount_usd) as float),2) as measure_value from gold.fact_transactions
union all
select 'avg_amount_per_customer' as measure_anme, round( cast(sum(amount_usd) as float) / count(distinct customer_key),2) as measure_value
from gold.fact_transactions
union all
select 'revenue_per_transaction' as measure_anme , sum(amount_usd) / count(*) as measure_value from gold.fact_transactions