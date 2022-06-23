{{
  config(
    materialized='table'
  )
}}

SELECT
    u.*,
    a.address,
    a.state,
    a.zipcode,
    a.country
FROM {{ ref('stg_greenery__users') }} u
LEFT JOIN {{ ref('stg_greenery__addresses') }} a
    ON u.address_id = a.address_id