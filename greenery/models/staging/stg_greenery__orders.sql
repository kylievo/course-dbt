{{
  config(
    materialized='table'
  )
}}

SELECT
    order_id,
    user_id as uid,
    created_at as created_at_utc,
    order_cost,
    shipping_cost,
    order_total,
    promo_id,
    status,
    shipping_service,
    address_id,
    tracking_id,
    estimated_delivery_at as estimated_delivery_at_utc,
    delivered_at as delivered_at_utc
    
FROM {{ source('src_greenery', 'orders') }}