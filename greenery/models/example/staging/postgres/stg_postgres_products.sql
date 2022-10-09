{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id,
    name,
    price,
    inventory
FROM {{ source('postgres_greenery', 'products') }}