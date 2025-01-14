select 
    timestamp,
    date,
    hour,
    price,
    timestamp_original_format,
    average,
    average_inc_current_day,
    compared_to_avg,
    compared_to_avg_inc_current_day,
    IsCheap,
    ResetCounter,
    count(0) over ( partition by ResetCounter order by hour desc) AS ReverseCheapCount 
from {{ ref('Next_Cheap_Hour_Step_2') }} 
where 
    IsCheap = 1
;