
select 
    'Now' AS tmpKey,
    group_concat(CheapStart,' ' separator ',') AS FullDetails 
from {{ ref('next_cheap_hour_step_4') }}
;