
/*---------------------------------------------------------------
EDA - Customer Analysis

Purpose:
Analyze customer behavior, activity, and value contribution.

Key Insights:
- Identify top customers by transaction value.
- Find most active customers (transaction frequency).
- Analyze customer distribution across cities.
- Segment customers into high, medium, and low value.

Business Value:
Supports customer targeting and  retention strategies
----------------------------------------------------------------*/

---Who are the top customers by total transaction amount? (This tells you your highest-value customers)

select top 20
       c.full_name,
       sum(t.amount_usd) as total_transaction_amount
       

from gold.fact_transactions t
left join gold.dim_customer c
on t.customer_key = c.customer_key
group by  c.full_name
order by total_transaction_amount desc

--Which customers have the highest number of transactions? (These are the most active customers)

select  top 20
        c.customer_id,
        c.full_name,
        count(t.transaction_id) as total_number_transactions

 from  gold.fact_transactions t
 left join gold.dim_customer c
 on t.customer_key = c.customer_key
 
 group by  c.customer_id,c.full_name
 order by total_number_transactions desc
          
--Which cities have the highest transaction value? (Shows strongest cities by customer transaction behavior)

select  top 20
       c.city,
       sum(t.amount_usd) as transaction_value,
       avg(t.amount_usd) as avg_transaction_value,
       count(transaction_id) as total_number_transactions

       
from gold.fact_transactions t
left join gold.dim_customer c
 on t.customer_key = c.customer_key
 group by c.city
 order by transaction_value desc
 
--Which cities have the most active customers?

select    top 20
          c.city,
          count(distinct t.customer_key) as active_customers
          

from gold.fact_transactions t
left join gold.dim_customer c
 on t.customer_key = c.customer_key
 group by c.city
 order by active_customers desc

--What is the average credit score by city? (This is dimension analysis)

select
              city,
              avg(credit_score) as avg_credit_score
from gold.dim_customer
group by city
order by avg_credit_score desc

--Which customers are high-value, medium-value, low-value? (customer_segmentation based on sum of amount value of customer)

select 
       c.full_name,
       c.customer_id,
       sum(t.amount_usd) as total_amount,
       CASE WHEN sum(t.amount_usd) > 400000 THEN 'high_value'
            WHEN sum(t.amount_usd) > 100000 THEN 'medium_value'
            ELSE 'low_value'
       END AS customer_segmentation
from gold.fact_transactions t
left join gold.dim_customer c
on t.customer_key = c.customer_key
group by  c.full_name,c.customer_id
order by total_amount desc



