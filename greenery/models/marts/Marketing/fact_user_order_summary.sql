{{
  config(
    materialized='table'
  )
}}

WITH
 user_orders as (
    SELECT
      uid,
      count(distinct order_id) as num_purchases,
      sum(order_cost) all_purchases_amount,
      avg(order_cost) avg_order_amount,
      min(created_at_utc) first_order_timestamp_utc,
      max(created_at_utc) last_order_timestamp_utc,
      count(distinct case when status = 'delivered' then order_id end) as num_order_delivered
      
    FROM {{ ref('stg_greenery__orders') }}
    GROUP BY 1
 )
 
 SELECT 
  user_orders.*,
  case when num_purchases >= 2 then 1 else 0
    end as repeated_customer_ind
 FROM user_orders