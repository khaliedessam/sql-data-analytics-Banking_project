
/*---------------------------------------------------------------
EDA - Customer Segmentation (Risk Analysis)

Purpose:
Segment customers based on credit score and analyze behavior.

Key Insights:
- Distribution of customers across risk segments.
- Transaction value contribution per segment.

Business Value:
Supports risk assessment, credit policy, and customer profiling.
----------------------------------------------------------------*/


--Segment customers by credit score (based on credit score max = 850 , min = 300)

select
           
        
      CASE WHEN credit_score >= 750 THEN 'Excellent'
           WHEN credit_score >= 650 THEN 'Good'
           WHEN credit_score >= 550 THEN 'Fair'
           ELSE 'Poor'
      END AS credit_segment,
      count(*) as customers_count
      
          
from gold.dim_customer 
group by CASE WHEN credit_score >= 750 THEN 'Excellent'
           WHEN credit_score >= 650 THEN 'Good'
           WHEN credit_score >= 550 THEN 'Fair'
           ELSE 'Poor'
           END 
order by customers_count desc


--Using CTE 
with credit_segment as (

select
           
        
      CASE WHEN credit_score >= 750 THEN 'Excellent'
           WHEN credit_score >= 650 THEN 'Good'
           WHEN credit_score >= 550 THEN 'Fair'
           ELSE 'Poor'
      END AS credit_segment
              
from gold.dim_customer  )

select credit_segment,count(*) as customers_count
from credit_segment
group by credit_segment
order by customers_count desc


-----Which credit segment generates the highest transaction value?

select
           
      CASE WHEN credit_score >= 750 THEN 'Excellent'
           WHEN credit_score >= 650 THEN 'Good'
           WHEN credit_score >= 550 THEN 'Fair'
           ELSE 'Poor'
      END AS credit_segment,
      count(*) as customers_count,
      sum(t.amount_usd) as total_amount
      
          
from gold.fact_transactions t
left join gold.dim_customer c
on t.customer_key = c.customer_key
group by CASE WHEN credit_score >= 750 THEN 'Excellent'
           WHEN credit_score >= 650 THEN 'Good'
           WHEN credit_score >= 550 THEN 'Fair'
           ELSE 'Poor'
         END 
order by total_amount desc


