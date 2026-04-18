
---Date Exploration

--Identify the earliest and latest dates (boundaries) and years between them (time span of business).
-- Find the date of the first and last transaction.


select
       min(transaction_date) as first_transaction_date,
       max(transaction_date) as last_transaction_date ,
       DATEDIFF(year,min(transaction_date),max(transaction_date)) as time_span
from gold.dim_date

