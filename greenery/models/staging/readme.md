### Week 1 Project

* **How many users do we have?**

`num_users = 130`

```
SELECT count(distinct uid) as num_users
FROM dbt_kylie_v.stg_greenery__users
```

* **On average, how many orders do we receive per hour?**

`avg_num_orders = 7.5208333333333333`
```
WITH 
  hour_num_orders as (
    SELECT
      date_trunc('hour', created_at_utc) as order_hour_utc,
      count(distinct order_id) as num_orders
    FROM dbt_kylie_v.stg_greenery__orders
    GROUP BY 1
  )
  
  SELECT avg(num_orders) as avg_num_orders
  FROM hour_num_orders
  ```
* **On average, how long does an order take from being placed to being delivered?**

`avg_num_hours = 93.4032786885246`

```
SELECT 
    avg(extract(epoch from (delivered_at_utc - created_at_utc)) / 3600) as avg_num_hours
  FROM dbt_kylie_v.stg_greenery__orders
  WHERE delivered_at_utc is not null
  ```
* **How many users have only made one purchase? Two purchases? Three+ purchases?**

`1 order: 25 ; 2 orders: 28 users ; 3+ orders: 71 users`
```
WITH
 user_orders as (
    SELECT
      uid,
      count(distinct order_id) as num_purchases
    FROM dbt_kylie_v.stg_greenery__orders
    GROUP BY 1
 )
 
 SELECT 
  case when num_purchases = 1 then '1 order'
      when num_purchases = 2 then '2 orders'
      when num_purchases >= 3 then '3+ orders'
  end as num_orders,
  count(uid) as num_users
 FROM user_orders
 GROUP BY 1
 ORDER BY 1
 ```

 * **On average, how many unique sessions do we have per hour?**
 
`avg_num_sessions = 16.3275862068965517`

 ```
 WITH
  sessions_per_hour AS (
    SELECT
      date_trunc('hour', created_at_utc) as created_hour,
      count(distinct session_id) as num_sessions
    FROM dbt_kylie_v.stg_greenery__events
    GROUP BY 1
  )

SELECT avg(num_sessions) as avg_num_sessions
FROM sessions_per_hour
```