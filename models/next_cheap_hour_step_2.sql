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
    case when compared_to_avg < '0.5' then 1 else 0 end AS IsCheap,
    sum(case when compared_to_avg < '0.5' then 0 else 1 end) over ( order by timestamp rows between unbounded preceding and current row ) AS ResetCounter 
from {{ ref('next_cheap_hour_step_1') }}
;

