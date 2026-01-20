WITH customers AS (

  {#Retrieves the complete list of customers for analysis.#}
  SELECT * 
  
  FROM {{ ref('customers')}}

),

orders AS (

  {#Retrieves all order records for comprehensive analysis.#}
  SELECT * 
  
  FROM {{ ref('orders')}}

),

customer_order_details AS (

  {#Compiles detailed order information along with customer names for better insights into customer spending.#}
  SELECT 
    customers.CUSTOMER_ID,
    customers.FIRST_NAME,
    customers.LAST_NAME,
    CONCAT(customers.FIRST_NAME, ' ', customers.LAST_NAME) AS FULL_NAME,
    orders.AMOUNT,
    orders.ORDER_ID
  
  FROM customers
  INNER JOIN orders
     ON customers.CUSTOMER_ID = orders.CUSTOMER_ID

),

revenue_by_customer AS (

  {#Calculates total revenue and order count for each customer.#}
  SELECT 
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    SUM(AMOUNT) AS TOTAL_REVENUE,
    COUNT(ORDER_ID) AS ORDER_COUNT
  
  FROM customer_order_details
  
  GROUP BY 
    CUSTOMER_ID, FIRST_NAME, LAST_NAME

),

revenue_order_summary AS (

  {#Ranks customers based on total revenue and order count for better sales insights.#}
  SELECT * 
  
  FROM revenue_by_customer
  
  ORDER BY TOTAL_REVENUE DESC, ORDER_COUNT DESC

),

top_10_rows AS (

  {#Identifies the top 10 revenue-generating orders for performance evaluation.#}
  SELECT * 
  
  FROM revenue_order_summary
  
  LIMIT 10

)

SELECT *

FROM top_10_rows
