/*---------------------------------------------------------------
EDA - Merchant Analysis

Purpose:
Analyze merchant performance and transaction distribution.

Key Insights:
- Identify top merchants by revenue and transaction count.
- Analyze strongest merchant locations (cities).
- Calculate merchant contribution percentage to total revenue.

Business Value:
Helps understand partner performance and market concentration.
----------------------------------------------------------------*/-


--Which merchants generate the highest total transaction value?

select
          top 20
          m.merchant_name,
          m.city,
          sum(t.amount_usd) as total_amount

from gold.fact_transactions t
left join gold.dim_merchant m
on t.merchant_key = m.merchant_key
group by  m.city,m.merchant_name
order by  total_amount desc

--Which merchants have the highest number of transactions?

select
           top 20
           m.merchant_name,
           m.city,
           count(t.transaction_id) as total_number_transactions
from gold.fact_transactions t
left join gold.dim_merchant m
on t.merchant_key = m.merchant_key

group by m.merchant_name,m.city
order by total_number_transactions desc

--Which merchant cities are strongest?

select
        top 20
        m.city,
        sum(t.amount_usd) as total_amount,
        count(t.transaction_id) as total_number_transactions

from gold.fact_transactions t
left join gold.dim_merchant m
on t.merchant_key = m.merchant_key

group by m.city
order by total_amount desc

--What percentage of total transaction value does each merchant contribute?
--Insight:Shows market concentration. 

with merchant_contribute as (

select
        m.merchant_name,
        sum(t.amount_usd) as total_amount

from gold.fact_transactions t
left join gold.dim_merchant m
on t.merchant_key = m.merchant_key
group by merchant_name
  )

select     
           top 10
           merchant_name,
           total_amount,
           sum(total_amount) over() as total_running,
           concat(round(cast(total_amount as float) / sum(total_amount) over() *100,2),'%') as contribution_pct


from merchant_contribute
order by contribution_pct desc
