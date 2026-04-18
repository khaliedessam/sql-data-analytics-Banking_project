/*
===============================================================================
Merchant Report
===============================================================================
Purpose:
    - This report consolidates key merchant metrics and performance
      to provide a complete view of each merchant.

Highlights:
    1. Gathers essential fields such as merchant_key, merchant_name, and city.
    
    2. Aggregates merchant-level metrics:
       - total_transactions
       - total_revenue
       - avg_transaction
       - first_transaction
       - last_transaction
       - recency_days

     3. Merchant segmentation
    
===============================================================================
*/
IF OBJECT_ID('gold.report_merchant','V') IS NOT NULL
Drop View gold.report_merchant;

Go

CREATE View gold.report_merchant as 
select
        m.merchant_key,
        m.merchant_name,
        m.city,
        count(t.transaction_id) as total_transactions,
        sum(t.amount_usd) as total_revenue,
        avg(t.amount_usd) as avg_amount,
        min(d.transaction_date) as first_transaction,
        max(d.transaction_date) as last_transaction,
        datediff(day,max(d.transaction_date),GETDATE()) as recency_days,
        count(distinct t.customer_key) as total_customers,
--merchant segmentation
        CASE WHEN sum(t.amount_usd) > 1000000 THEN 'Top Merchant'
             WHEN sum(t.amount_usd) > 800000 THEN 'Mid Merchant'
             ELSE 'Small Merchant'
        END AS merchant_segment


from gold.fact_transactions t
left join gold.dim_merchant m
on t.merchant_key = m.merchant_key
left join gold.dim_date d
on t.date_key = d.date_key

group by m.merchant_key,
         m.merchant_name,
         m.city

---Checking merchant report----

select * from gold.report_merchant

       
        
         
         
