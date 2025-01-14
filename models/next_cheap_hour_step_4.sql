select 
    ResetCounter,
    concat(substr(min(timestamp),9,2),':e@',substr(min(timestamp),12,2),'(',count(distinct ReverseCheapCount),'h)') AS CheapStart
from {{ ref('next_cheap_hour_step_3') }}
group by    
    ResetCounter
;
