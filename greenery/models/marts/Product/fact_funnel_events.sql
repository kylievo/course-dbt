{{
  config(
    materialized='table'
  )
}}

SELECT
    session_id,
    max(CASE WHEN e.page_view > 0 THEN 1 ELSE 0 END) AS has_page_view,
    max(CASE WHEN e.add_to_cart > 0 THEN 1 ELSE 0 END) AS has_add_to_cart,
    max(CASE WHEN e.checkout > 0 THEN 1 ELSE 0 END) AS has_check_out

FROM {{ ref('int_event_summary') }} e 
GROUP BY 1