{{
  config({    
    "materialized": "ephemeral",
    "database": "danyelle",
    "schema": "demo"
  })
}}

WITH customers AS (

  SELECT * 
  
  FROM {{ source('danyelle.demo', 'customers') }}

),

orders AS (

  SELECT * 
  
  FROM {{ source('danyelle.demo', 'orders') }}

),

customer_orders_join AS (

  SELECT 
    customers.customer_id AS CUSTOMER_ID,
    customers.first_name AS FIRST_NAME,
    customers.last_name AS LAST_NAME,
    customers.first_order AS FIRST_ORDER,
    customers.most_recent_order AS MOST_RECENT_ORDER,
    customers.total_orders AS TOTAL_ORDERS,
    customers.customer_lifetime_value AS CUSTOMER_LIFETIME_VALUE,
    orders.amount
  
  FROM customers
  INNER JOIN orders
     ON customers.customer_id = orders.customer_id

),

customer_spend_aggregation AS (

  SELECT 
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    FIRST_ORDER,
    MOST_RECENT_ORDER,
    TOTAL_ORDERS,
    CUSTOMER_LIFETIME_VALUE,
    SUM(amount) AS TOTAL_SPEND
  
  FROM customer_orders_join
  
  GROUP BY 
    CUSTOMER_ID, FIRST_NAME, LAST_NAME, FIRST_ORDER, MOST_RECENT_ORDER, TOTAL_ORDERS, CUSTOMER_LIFETIME_VALUE

),

sort_by_total_spend AS (

  SELECT * 
  
  FROM customer_spend_aggregation
  
  ORDER BY TOTAL_SPEND DESC NULLS FIRST

),

top_10_customers_by_spend AS (

  SELECT * 
  
  FROM sort_by_total_spend
  
  LIMIT 10

)

SELECT *

FROM top_10_customers_by_spend
