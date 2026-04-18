
/*---------------------------------------------------------------
EDA - Accounts Analysis

Purpose:
Analyze account behavior and performance across different account types.

Key Insights:
- Identify which account types generate the highest transaction value.
- Understand balance distribution (avg, min, max).
- Explore relationship between account balance and transaction activity.

----------------------------------------------------------------*/

--Which account type generates the highest transaction value?
--Insight : Shows which account product performs best.

select
           sum(t.amount_usd) as total_amount,
           avg(t.amount_usd) as avg_amount,
           count(transaction_id) as transaction_count,
           a.account_type

from gold.fact_transactions t
left join gold.dim_accounts a
on t.account_key = a.account_key
group by a.account_type
order by total_amount desc


--What is the average balance by account type? (dimension analysis)
--Insight:Shows wealth concentration across account types.
select 
        account_type, 
        avg(balance_usd) as avg_balance,
        max(balance_usd) as max_balance,
        min(balance_usd) as min_balance
        
from gold.dim_accounts
group by account_type
order by avg_balance desc


--Which accounts have the highest number of cards?

select
              top 20
              account_id,
              account_type,
              total_cards 
from gold.dim_accounts
order by total_cards desc


--Do customers with cards spend more?
--Insight:Compares card holders vs non-card holders.
select
          sum(t.amount_usd) as total_amount,
          a.has_card 

from gold.fact_transactions t
left join  gold.dim_accounts a
on t.account_key = a.account_key
group by a.has_card 
order by total_amount desc

--Does higher balance relate to higher transaction activity?
--Insight:Lets you inspect whether richer accounts transact more.
select
           a.account_id,
           a.account_type,
           a.balance_usd,
           count(t.transaction_id) as count_transactions,
           sum(t.amount_usd) as total_amount

from gold.fact_transactions t
left join  gold.dim_accounts a
on t.account_key = a.account_key

group by a.account_id,a.account_type,a.balance_usd
order by total_amount DESC

