{{
  config(
    materialized='table'
  )
}}

SELECT
       orders.*,
       promos.discount,
       promos.status as promo_status,
       adresses.address,
       adresses.state,
       adresses.country,
       adresses.zipcode
FROM {{ ref('stg_greenery__orders') }} orders
LEFT JOIN {{ ref('stg_greenery__promos') }} promos
    ON orders.promo_id = promos.promo_id
LEFT JOIN {{ ref('stg_greenery__addresses') }} adresses
    ON orders.address_id = adresses.address_id
