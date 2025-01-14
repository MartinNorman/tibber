
select 
    'Now' AS tmpKey,
    group_concat(CheapStart,' ' separator ',') AS FullDetails 
from {{ ref('Next_Cheap_Hour_Step_4') }}
;