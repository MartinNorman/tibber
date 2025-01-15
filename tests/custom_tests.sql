{{ config(severity='warn') }}


select  
    country,
    count(*) as no_codes
from {{ ref('countrycodes_snapshot') }}
group by 
    country
