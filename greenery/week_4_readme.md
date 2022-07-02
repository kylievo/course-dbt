## Week 3 Project

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

