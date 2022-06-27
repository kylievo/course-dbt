## Week 3 Project

#### PART 1

1. **What is our overall conversion rate?**

`conversion_rate = 62.46%`

```
SELECT round((sum(checkout)/count(distinct session_id))*100,2) as conversion_rate
FROM dbt_kylie_v.int_event_summary
```

2. **What is our conversion rate by product?**

![Alt text](/image/week3_q2.png?raw=true "")

```
SELECT
  p.product_id,
  p.name,
  (p.times_ordered::float / pv.page_view::float)*100 as product_conversion_rate
FROM dbt_kylie_v.fact_products p
LEFT JOIN dbt_kylie_v.int_event_summary_by_product pv
    on p.product_id = pv.product_id
ORDER BY 3 DESC
LIMIT 5
```

3. **Why might certain products be converting at higher/lower rates than others?**
- Product demand
- Visibility on the website, descriptions, product image
- Price
- Sesonality/Inventory
- Reviews (if available)

#### PART 2

**Create a macro to simplify part of a model(s)**

```
{% macro event_grouping(event_name) %}

    SUM(CASE WHEN event_type = '{{ event_name }}' THEN 1 ELSE 0 END)

{% endmacro %}
```

`int_event_summary model`

```
{{
  config(
    materialized='table'
  )
}}

{% set events = dbt_utils.get_column_values(table=ref('stg_greenery__events'), column='event_type') %}

SELECT
    uid,
    session_id,
    created_at_utc,
    COUNT(DISTINCT event_id) AS num_events,
    COUNT(DISTINCT order_id) AS num_orders
    {% for event_name in events %}
      , {{event_grouping(event_name)}} AS {{event_name}}
    {% endfor %}
FROM {{ ref('stg_greenery__events') }}
GROUP BY 1, 2, 3
```

#### PART 3

**Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.**

```
on-run-end:
 - "GRANT USAGE ON SCHEMA {{ 'dbt_kylie_v' }} TO reporting"

```

#### PART 4

**Install dbt packages**

```
packages:
  - package: dbt-labs/dbt_utils
    version: 0.8.6
  - package: calogica/dbt_expectations
    version: 0.5.8
  - package: dbt-labs/codegen
    version: 0.7.0

```

Applied `dbt_utils` on `models/marts/Product/int_event_summary.sql`

#### PART 5
**Updated model DAGs**

![Alt text](/image/dbt-dag-graph.png?raw=true "")

