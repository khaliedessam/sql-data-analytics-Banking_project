
/*---------------------------------------------------------------
EDA - Advanced Business Analysis

Purpose:
Answer complex business questions using advanced SQL techniques.

Key Insights:
- Top customers per city.
- Most used merchants per city.
- Best performing account type per month.

Techniques Used:
- Window functions (ROW_NUMBER)
- CTEs
- Partitioning

Business Value:
Provides deep insights for strategic decision-making.
----------------------------------------------------------------*/
--Which customers in each city generate the highest value?
WITH ranked_customers as (
select
        
        c.full_name,
        c.city,
        sum(t.amount_usd) as total_value,
        ROW_NUMBER() OVER(partition by c.city order by sum(t.amount_usd) desc ) as RN

from   gold.fact_transactions  t
left join gold.dim_customer c
on t.customer_key = c.customer_key
group by c.full_name,c.city )

select 
            full_name,
            city,
            total_value,
            RN
from ranked_customers
where RN = 1


--Which merchant is most used by each city’s customers?

with ranked_merchant as (
select
         m.merchant_name,
         c.city,
         count(t.transaction_id) as transaction_count,
         ROW_NUMBER() OVER(partition by c.city order by count(t.transaction_id) desc ) as RN

from gold.fact_transactions  t
left join gold.dim_customer c
on t.customer_key = c.customer_key

left join gold.dim_merchant m
on t.merchant_key = m.merchant_key

group by  m.merchant_name,c.city )

select
          merchant_name,
          city,
          transaction_count,
          RN

from ranked_merchant
where RN = 1


--Which account type performs best in each month?
--Which account type had the highest total transaction amount in each month of each year?

with best_account as (
select
        a.account_type,
        d.year_number,
        d.month_name,
        d.month_number,
        sum(t.amount_usd) as total_amount,
        ROW_NUMBER() OVER(partition by d.year_number,d.month_name order by sum(t.amount_usd) desc ) as RN

from gold.fact_transactions  t
left join gold.dim_date d
on t.date_key = d.date_key

left join gold.dim_accounts a
on t.account_key = a.account_key

group by a.account_type,d.year_number,d.month_name,d.month_number )

select
        account_type,year_number,month_name,month_number,total_amount,RN

from best_account
where RN = 1

