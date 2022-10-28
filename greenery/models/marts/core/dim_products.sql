{{
    config(
        materialized='table'
    )
}}
with products as (
    select * from {{ ref('stg_postgres_products')}}
)
select * from products