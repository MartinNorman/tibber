{% snapshot countrycodes_snapshot %}

{{
    config(
      target_database='dbt_dev',
      target_schema='dbt_dev',
      unique_key='country',
      strategy='check',
      check_cols='all'
    )
}}

select 
    * 
from {{ source('tibber', 'countrycodes') }}

{% endsnapshot %}