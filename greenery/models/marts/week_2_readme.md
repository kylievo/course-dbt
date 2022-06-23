### Week 2 Project

1. **What is our user repeat rate?**

`repeated_rate = 79%`

```
SELECT count(distinct case when repeated_customer_ind = 1 then uid end)/count(distinct uid)::float as repeated_rate
FROM dbt_kylie_v.fact_user_order_summary
```

2. **What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?**

**Good indicators**
- Frequent website visit, visit to order conversion
- Number of purchases, time between purchases
- Number of items purchased, total/average spend
- Same item purchares

**Indicators of users who are likely NOT to purchase again**
- Low site visit to order conversion
- Only purchase with promo code or have one purchase with single promo
- Low total spend

**If you had more data, what features would you want to look into to answer this question?**
- Return data/indicator, return reasons
- Net Promotor Score survet results/rating
- User site feedback

3. **Marts folder**

* Core
- `dim_users`: users info + adresses
- `fact_orders`: orders info + promos + addresses
- `fact_products`: products_info + number of orders + quatities ordered

* Marketing
- `fact_user_order_summary`: users' number of orders and summary order details + repeated user indicator

* Product
- `int_event_summary`: users' events by session + number of events for each event category
- `fact_user_page_views_to_orders`: users' number of sessions, page views, and orders + sessions to orders ratio

4. **Tests**
In `marts/marts_schema.yml`

sessions_id is not unique as I expected. Also, the user_id vs. session_id is not a 1-1 relationship