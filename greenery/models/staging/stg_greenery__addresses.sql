{{
  config(
    materialized='table'
  )
}}

SELECT
    address_id,
    address,
    state,
    country,
    zipcode
    
FROM {{ source('src_greenery', 'addresses') }}