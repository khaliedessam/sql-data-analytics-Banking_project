/*
===============================================================================
Account Type Report
===============================================================================
Purpose:
    - This report summarizes account performance at the account type level
      to provide a clear view of how each banking product performs.

Highlights:
    1. Groups data by account type.
    2. Aggregates account-type metrics:
       - total_accounts
       - total_customers
       - total_transactions
       - total_amount
       - avg_transaction
       - avg_balance
       - first_transaction
       - last_transaction
    3. Derives useful business indicators:
       - accounts_with_card
       - card_penetration_rate
       - revenue_percentage

Business Value:
    - Helps compare banking products such as Savings vs Current accounts.
    - Identifies which account types drive the most activity and value.
    - Supports product analysis, performance tracking, and reporting.

===============================================================================
*/
IF OBJECT_ID('gold.account_report','V') IS NOT NULL
Drop View gold.account_report;

GO

CREATE View gold.account_report as

with account_type as (
select
           a.account_type,
         
--Aggregates account-type metrics
         count(distinct a.account_id) as total_accounts,
         count(distinct a.customer_id) as total_customers,
         count(t.transaction_id) as total_transactions,
         sum(t.amount_usd) as total_amount,
         avg(t.amount_usd) as avg_amount,
         max(a.balance_usd) as max_balance,
         min(a.balance_usd) as min_balance,
         avg(a.balance_usd) as avg_balance,
         min(d.transaction_date) as first_transaction,
         max(d.transaction_date) as last_transaction


from gold.fact_transactions t
left join gold.dim_accounts a
on t.account_key = a.account_key
left join gold.dim_date d
on t.date_key = d.date_key

group by a.account_type )

select       *,
            concat(round(cast(total_amount as float) / sum(total_amount) over() *100,2),'%') as revenue_percentage

from account_type

--Checking Account Report---

select * from gold.account_report

 



