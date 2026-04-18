/*
=======================================================================================
Qualtiy Checks
=======================================================================================
Script Purpose:
       This script performs various quality checks for data consistency, accuracy,
       and standardization 

======================================================================================
*/



---Checking customer id duplication
select customer_id , count(*)
from silver.customers
group by customer_id
having count(*) > 1


-----Checking account_key duplication


with cte as (
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
         a.open_date )
 
 select account_id , count(*)  as duplicate_count 
 from cte
 group by account_id
 having count(*) > 1

-----Checking account_key duplication

with dim_accounts_checks as (
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
         a.open_date )
 
select count(*) as total_rows,
       count(distinct account_id) as distinct_accounts 
from dim_accounts_checks

-----Checking merchant_key duplication
with dim_merchant_check as (
select    
        ROW_NUMBER() OVER(ORDER BY merchant_id) as merchant_key,
          merchant_id,
          merchant_name,
          city
from silver.merchants )

select  merchant_id , count(*)
from  dim_merchant_check 
group by merchant_id
having count(*) > 1

----Checking date_key duplication (transaction_id duplicate)


with dim_date as (
select distinct
           cast(transaction_date as date) as transaction_date 
              
from silver.transactions ) ,

dim_date_check as (
select 
        convert(int,format(transaction_date,'yyyyMMdd')) as date_key,
        transaction_date,
        day(transaction_date) as day_number,
        month(transaction_date) as month_number,
        year(transaction_date) as year_number,
        datename(month,transaction_date) as month_name,
        datename(weekday,transaction_date) as weekday_name,
        datepart(quarter,transaction_date) as quarter_number
from dim_date )

select transaction_date , count(*) as duplicate_count
from dim_date_check 
group by transaction_date
having count(*) > 1

----checking dim_date (date_key duplicate)

with dim_date as (
select distinct
           cast(transaction_date as date) as transaction_date 
              
from silver.transactions ) ,

dim_date_check as (
select 
        convert(int,format(transaction_date,'yyyyMMdd')) as date_key,
        transaction_date,
        day(transaction_date) as day_number,
        month(transaction_date) as month_number,
        year(transaction_date) as year_number,
        datename(month,transaction_date) as month_name,
        datename(weekday,transaction_date) as weekday_name,
        datepart(quarter,transaction_date) as quarter_number
from dim_date )

select date_key , count(*) as duplicate_count
from dim_date_check 
group by date_key
having count(*) > 1


----------------


