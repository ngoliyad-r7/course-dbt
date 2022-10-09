{% snapshot orders_snapshot %}

  {{
  config(
    target_database = 'dev_db',
    target_schema = 'dbt_ninagoliyad',
    strategy='check',
    unique_key='order_id',
    check_cols=['status'],
   )
}}

  SELECT * FROM {{ source('postgres_greenery', 'orders') }}

{% endsnapshot %}
