What is our user repeat rate?: 79.84%
```
select 
    (select count(distinct user_id) 
    from    
        (select user_id, count(distinct order_id) as num_orders
         from stg_postgres_orders
         group by user_id) as users
         where num_orders>1)/
    
    (select count(distinct user_id) 
    from 
        (select user_id, count(distinct order_id) as num_orders
         from stg_postgres_orders
         group by user_id) as users)
as repeat_rate
```

What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
1. Time spent on website 
2. Time between events
3. Did they use promos? 
4. Is there a change in money spent between different orders? 