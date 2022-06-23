{{
  config(
    materialized='table'
  )
}}
SELECT
    p.product_id,
    name,
    price,
    inventory,
    count(distinct oi.order_id) as times_ordered,
    sum(oi.quantity) as quantities_ordered
FROM {{ ref('stg_greenery__products') }} p
LEFT JOIN {{ ref('stg_greenery__order_items') }} oi
    ON p.product_id = oi.product_id
GROUP BY 1,2,3,4