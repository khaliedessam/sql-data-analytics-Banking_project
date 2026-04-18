
/*
===============================================================================
Time Report
===============================================================================
Purpose:
    - This report analyzes transaction performance over time
      to provide a complete view of historical trends, growth,
      seasonality, and cumulative performance.

Highlights: 
    1. Gathering essential fields :
       - year_number
       - quarter_number
       - month_number
       - month_name

    2. Aggregates period-level metrics:
       - total_transactions
       - total_revenue
       - avg_transaction

    3. Derives trend and performance indicators:
       - previous_month_revenue
       - monthly_change
       - monthly_change_percentage
       - cumulative_revenue
       - revenue_percentage (related to overall revenue)

Business Value:
    - Helps identify monthly and quarterly transaction trends.
    - Supports growth analysis and performance monitoring.
    - Highlights seasonality and period-over-period changes.

===============================================================================
*/

IF OBJECT_ID('gold.report_time','V') IS NOT NULL
Drop View gold.report_time

GO

Create View gold.report_time as

with monthly_summary as (
select

         d.year_number,
         d.month_number,
         d.month_name,
         d.quarter_number,

--Aggregations
         count(t.transaction_id) as total_transactions,
         sum(t.amount_usd) as total_revenue,
         avg(t.amount_usd) as avg_transaction

from gold.fact_transactions t
left join gold.dim_date d
on t.date_key = d.date_key

group by   d.year_number,
           d.month_number,
           d.month_name,
           d.quarter_number  ),

percentage_value as (


select   year_number,
         month_number,
         month_name,
         quarter_number,
         total_transactions,
         total_revenue,
         sum(total_revenue) over(order by year_number,month_number ROWS Between unbounded preceding and current row) as cumulative_revenue,
         sum(total_revenue) over() as overall_revenue,
         avg_transaction,
         round(cast(avg(total_revenue) over(order by year_number,month_number ROWS Between 2 preceding and current row) as float),2) as rolling_3_month_avg_revenue,
         lag(total_revenue) over(order by year_number,month_number) as previous_month_revenue,
         total_revenue - lag(total_revenue) over(order by year_number,month_number) as monthly_change


from monthly_summary )

select    *,
          concat(round(monthly_change / previous_month_revenue *100,2),'%') as monthly_change_percentage,
          concat(round(total_revenue / overall_revenue *100,2),'%') as revenue_percentage


from percentage_value


---Checking report_time View---

select * from gold.report_time












