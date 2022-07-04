## Week 4 Project

#### Part 1: dbt Snapshots

1. **Create a snapshot model using the orders source in the /snapshots/ directory of our dbt project that monitors the status column.**

```
{% snapshot order_status_snapshot %}

  {{
    config(
      target_schema='snapshots',
      strategy='check',
      unique_key='order_id',
      check_cols=['status'],
    )
  }}

  SELECT * FROM {{ source('src_greenery', 'orders') }}

{% endsnapshot %}
```
2-4. **How the data has changed for the two provided orders with `dbt snapshot`.**

```
SELECT order_id, status, dbt_updated_at, dbt_valid_from, dbt_valid_to
FROM snapshots.order_status_snapshot
WHERE order_id in ('914b8929-e04a-40f8-86ee-357f2be3a2a2', '05202733-0e17-4726-97c2-0520c024ab85')
```

![Alt text](/greenery/image/order_snapshot_pre.png)

![Alt text](/greenery/image/order_snapshot_post.png)


#### Part 2: Modeling challenge

```
SELECT 
  round(sum(has_add_to_cart)::numeric/count(distinct session_id),2) as add_to_cart_conv,
  round(sum(has_check_out)::numeric/count(distinct session_id), 2) as check_out_conv,
  round(sum(has_add_to_cart)::numeric/sum(has_page_view), 2) as page_view_to_add_to_card,
  round(sum(has_check_out)::numeric/sum(has_add_to_cart), 2) as add_to_card_to_check_out
  
FROM dbt_kylie_v.fact_funnel_events
```
`add_to_cart_conv = 0.81`

`check_out_conv = 0.62`

`page_view_to_add_to_card = 0.81`

`add_to_card_to_check_out = 0.77`

#### Part 3: Reflection questions

3A. We're been using dbt at our company. I would recommend to my team to review model layers and re-organize everything as needed. We built large/complex models already but naming convention and model structure are not very clean. We don't have very good tests either that we need to add/improve.

