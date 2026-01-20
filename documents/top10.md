# Introduction
This document describes the data pipeline designed to generate a ranked list of top customers by total spend. The pipeline integrates and processes customer and order data to deliver actionable insights for business analytics. It outlines the process of joining customer details with their corresponding order information, aggregating their spending, and producing an ordered list of the highest-value customers.

![](data:prophecy_json/%7B%22type%22%3A%22Canvas%22%2C%22version%22%3A1%2C%22id%22%3A%22top10_canvas%22%2C%22properties%22%3A%7B%22pipelineId%22%3A%22top10%22%2C%22shouldAutoRefresh%22%3Atrue%7D%7D)

# Data Sources
| Question | Answer |
| - | - |
| List the sources | ![](data:prophecy_json/%7B%22type%22%3A%22CopilotQuestion%22%2C%22version%22%3A1%2C%22id%22%3A%220f7d40a7-4bd5-4af3-88d8-da2945d45f18%22%2C%22properties%22%3A%7B%22question%22%3A%22How%20many%20sources%20and%20what%20are%20they%3F%22%2C%22response%22%3A%22There%20are%202%20sources%3A%20customers%20and%20orders.%22%2C%22placeholder%22%3A%22Enter%20a%20response...%22%2C%22tooltip%22%3A%22This%20is%20an%20AI%20generated%20response.%20Please%20check%20for%20correctness.%22%7D%7D) | 

Customer and order data from the sales database.



**Source:** @dataset:danyelle.demo.customers
**Description**: This source contains customer profile data, including identifiers, names, order history, and customer lifetime value. It is used to provide a comprehensive view of each customer for analytics and reporting purposes.
| Name | Type |
|------|------|
| customer_id | Bigint |
| first_name | String |
| last_name | String |
| first_order | Date |
| most_recent_order | Date |
| total_orders | Bigint |
| customer_lifetime_value | Double |



**Source:** @dataset:danyelle.demo.orders
**Description**: This source contains order transaction data, capturing details such as order identifiers, customer associations, order dates, payment breakdowns, and order statuses. It is used to analyze purchasing behavior, payment methods, and order trends.
| Name | Type |
|------|------|
| order_id | Bigint |
| customer_id | Bigint |
| order_date | Date |
| status | String |
| credit_card_amount | Double |
| coupon_amount | Double |
| bank_transfer_amount | Double |
| gift_card_amount | Double |
| amount | Double |


# Data Targets
| Question | Answer |
| - | - |
| Number of targets | ![](data:prophecy_json/%7B%22type%22%3A%22CopilotQuestion%22%2C%22version%22%3A1%2C%22id%22%3A%22815f87ae-8e11-40dd-8dc8-7e551ee31875%22%2C%22properties%22%3A%7B%22question%22%3A%22How%20many%20targets%20are%20there%20and%20what%20are%20they%3F%22%2C%22response%22%3A%22There%20are%20no%20explicit%20target%20components%20defined%20in%20this%20pipeline.%22%2C%22placeholder%22%3A%22Enter%20a%20response...%22%2C%22tooltip%22%3A%22This%20is%20an%20AI%20generated%20response.%20Please%20check%20for%20correctness.%22%7D%7D) | 

A ranked list of top customers by total spend, used for business analytics and reporting.



# Pipeline Specific Questions
| Question | Answer | 
| - | - | 
| Does the joined input data have different schema? | ![](data:prophecy_json/%7B%22type%22%3A%22CopilotQuestion%22%2C%22version%22%3A1%2C%22id%22%3A%22c2608ae4-dbc2-40c1-a9ed-f582506b2070%22%2C%22properties%22%3A%7B%22question%22%3A%22Does%20joined%20input%20data%20from%20the%20gl%20and%20coa%20have%20different%20schema%3F%22%2C%22response%22%3A%22Yes%2C%20the%20customers%20and%20orders%20tables%20have%20different%20schemas%20as%20inputs%20to%20the%20join%20component.%22%2C%22placeholder%22%3A%22Enter%20a%20response...%22%2C%22tooltip%22%3A%22This%20is%20an%20AI%20generated%20response.%20Please%20check%20for%20correctness.%22%7D%7D) | 
| Does the unioned input data have different schema? | ![](data:prophecy_json/%7B%22type%22%3A%22CopilotQuestion%22%2C%22version%22%3A1%2C%22id%22%3A%2274c4707d-6f6a-459a-a26c-116b98a9380d%22%2C%22properties%22%3A%7B%22question%22%3A%22Does%20unioned%20coa%20input%20data%20have%20different%20schema%3F%22%2C%22response%22%3A%22There%20are%20no%20union%20operations%20in%20this%20pipeline.%22%2C%22placeholder%22%3A%22Enter%20a%20response...%22%2C%22tooltip%22%3A%22This%20is%20an%20AI%20generated%20response.%20Please%20check%20for%20correctness.%22%7D%7D) | 

# Transformation Steps

This pipeline delivers actionable insights into customer purchasing behavior by identifying the top customers based on their total spending. By combining customer profiles with their order histories, the process enables the business to recognize high-value customers and better target retention or reward strategies.

- **Step 1: Combine customer profiles with order histories**
    - Integrate customer information from @dataset:danyelle.demo.customers with order transaction data from @dataset:danyelle.demo.orders using @gem:customer_orders_join, associating each customer with their corresponding orders and purchase amounts.

- **Step 2: Calculate total spend per customer**
    - Aggregate the combined data using @gem:customer_spend_aggregation to compute each customer’s total spend, along with retaining key customer attributes such as name, order history, and lifetime value.

- **Step 3: Rank customers by total spend**
    - Sort the aggregated customer data in descending order of total spend using @gem:sort_by_total_spend to prioritize the highest spenders.

- **Step 4: Select top 10 highest-spending customers**
    - Limit the results to the top 10 customers by total spend using @gem:top_10_customers_by_spend, providing a focused list of the most valuable customers for targeted business actions.

# Documentation Sign-off
| Reviewer | Date | 
| - | - | 
| ![](data:prophecy_json/%7B%22type%22%3A%22Question%22%2C%22version%22%3A1%2C%22id%22%3A%2215b3229b-20ac-4164-8f5f-75dfc79fe675%22%2C%22properties%22%3A%7B%22question%22%3A%22Confirm%20that%20you%20have%20reviewed%20the%20generated%20documentation%20by%20entering%20your%20full%20name.%22%2C%22response%22%3A%22%22%2C%22placeholder%22%3A%22Enter%20a%20response...%22%2C%22tooltip%22%3A%22%22%7D%7D) | ![](data:prophecy_json/%7B%22type%22%3A%22CopilotQuestion%22%2C%22version%22%3A1%2C%22id%22%3A%22ff337742-f5c5-44de-8106-2aa62f3f83ca%22%2C%22properties%22%3A%7B%22question%22%3A%22Enter%20the%20current%20date%20time%20stamp%22%2C%22response%22%3A%222026-01-20%2019%3A38%3A12%20UTC%22%2C%22placeholder%22%3A%22Enter%20a%20response...%22%2C%22tooltip%22%3A%22This%20is%20an%20AI%20generated%20response.%20Please%20check%20for%20correctness.%22%7D%7D) |