select 
    ResetCounter,
    concat(substr(min(timestamp),9,2),':e@',substr(min(timestamp),12,2),'(',count(distinct ReverseCheapCount),'h)') AS CheapStart
from {{ ref('Next_Cheap_Hour_Step_3') }}
group by    
    ResetCounter
;
