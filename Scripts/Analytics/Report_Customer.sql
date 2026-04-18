/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors
      (a complete view of each customer)

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Aggregates customer-level metrics:
	   - total transactions
	   - total spent
	   - avg_transaction
	   - first_transaction
	   - last_transaction

===============================================================================
*/

IF OBJECT_ID('gold.report_customer', 'V') IS NOT NULL 
    DROP VIEW gold.report_customer;
GO

CREATE View gold.report_customer as 
select
        c.customer_key,
		c.full_name,
		c.city,
		c.credit_score,
		a.account_type,
		a.total_cards,


--core metrics
		count(t.transaction_id) as total_transactions,
		sum(t.amount_usd) as totaL_spent,
		avg(t.amount_usd) as avg_amount,
--time line
		min(d.transaction_date) as first_transaction,
		max(d.transaction_date) as last_transaction,
		datediff(day,max(d.transaction_date),GETDATE()) as recency_days,

--customer segmentation
       CASE WHEN sum(t.amount_usd) > 400000 THEN 'high_value'
            WHEN sum(t.amount_usd) > 100000 THEN 'medium_value'
            ELSE 'low_value'
       END AS customer_segmentation,
	     
      CASE WHEN credit_score >= 750 THEN 'Excellent'
           WHEN credit_score >= 650 THEN 'Good'
           WHEN credit_score >= 550 THEN 'Fair'
           ELSE 'Poor'
      END AS credit_segment


from gold.fact_transactions t
left join gold.dim_customer c
on t.customer_key = c.customer_key
left join gold.dim_date d
on t.date_key = d.date_key
left join gold.dim_accounts a
on t.account_key = a.account_key
group by 
               c.customer_key,
		       c.full_name,
		       c.city,
		       c.credit_score,
			   a.account_type,
			   a.total_cards
			  
----------Checking View For Customer Report--------
select * from gold.report_customer