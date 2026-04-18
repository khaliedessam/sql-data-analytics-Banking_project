/*---------------------------------------------------------------
EDA - Time Analysis (Historical Trends)

Purpose:
Analyze transaction trends over time using the date dimension.

Key Insights:
- Yearly and monthly transaction trends.
- Peak activity days (weekdays).
- Quarterly performance.
- Month-over-month growth analysis.

Business Value:
Supports trend analysis, forecasting, and seasonality understanding.
----------------------------------------------------------------*/

--What is total transaction value by year?
--Insight:Shows yearly trend.


select
        year_number,
        sum(t.amount_usd) as total_amount
        

from gold.fact_transactions t
left join gold.dim_date d
on t.date_key = d.date_key

group by year_number
order by total_amount desc

--What is total transaction value by month?
--Insight:Shows monthly trend.
select
        d.year_number,
        d.month_number,
        d.month_name,
        sum(t.amount_usd) as total_amount
        

from gold.fact_transactions t
left join gold.dim_date d
on t.date_key = d.date_key

group by year_number,month_number,month_name
order by total_amount desc

--What is transaction count by month?

select
           d.year_number,
           d.month_number,
           d.month_name,
           count(t.transaction_id) as transaction_count

from gold.fact_transactions t
left join gold.dim_date d
on t.date_key = d.date_key

group by d.year_number,d.month_number,d.month_name
order by transaction_count desc

--Which weekdays have the highest activity?

select
          d.weekday_name,
          count(t.transaction_id) as transaction_count,
          sum(t.amount_usd) as total_amount

from gold.fact_transactions t
left join gold.dim_date d
on t.date_key = d.date_key

group by d.weekday_name
order by total_amount desc

--Which quarter performs best?

select
           d.year_number, 
           d.quarter_number,
           sum(t.amount_usd) as total_amount

from gold.fact_transactions t
left join gold.dim_date d
on t.date_key = d.date_key

group by d.year_number,d.quarter_number
order by total_amount desc

--Month-over-month growth in transaction value
with previous_month as (
select
               d.year_number,
               d.month_number,
               sum(t.amount_usd) as total_amount
               
from gold.fact_transactions t
left join gold.dim_date d
on t.date_key = d.date_key

group by d.year_number,d.month_number )

select
          year_number,
          month_number,
          total_amount,
          lag(total_amount) over( order by year_number,month_number) as previous_month_amount,
          total_amount-lag(total_amount) over( order by year_number,month_number) as growth_amount
          

from previous_month

---adding growth rate

with previous_month as (
select
               d.year_number,
               d.month_number,
               sum(t.amount_usd) as total_amount
               
from gold.fact_transactions t
left join gold.dim_date d
on t.date_key = d.date_key

group by d.year_number,d.month_number ) ,

growth_rate as (
select
          year_number,
          month_number,
          total_amount,
          lag(total_amount) over( order by year_number,month_number) as previous_month_amount,
          total_amount-lag(total_amount) over( order by year_number,month_number) as growth_amount
          

from previous_month )

select    year_number,
          month_number,
          total_amount,
          previous_month_amount,
          growth_amount,
     CASE WHEN growth_amount > 0 THEN 'increase'
          ELSE 'decrease'
     END AS growth_rate

from      growth_rate

