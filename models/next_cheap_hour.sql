with GroupedData as (
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
        ReverseCheapCount 
    from {{ ref('Next_Cheap_Hour_Step_3') }}
    where 
        IsCheap = 1
    ), AggregatedData as (
    select 
        ResetCounter,
        concat(substr(min(timestamp),9,2),':e@',substr(min(timestamp),12,2),'(',count(distinct ReverseCheapCount),'h)') AS CheapStart
    from {{ ref('Next_Cheap_Hour_Step_3') }}
    group by    
    ResetCounter
    ), Result as (
    select 
        'Now' AS tmpKey,
        group_concat(CheapStart,' ' separator ',') AS full_details 
    from AggregatedData
    )
    select 
        GroupedData.timestamp AS timestamp,
        GroupedData.date AS date,
        GroupedData.hour AS hour,
        GroupedData.price AS price,
        GroupedData.timestamp_original_format AS timestamp_original_format,
        GroupedData.average AS average,
        GroupedData.average_inc_current_day AS average_inc_current_day,
        GroupedData.compared_to_avg AS compared_to_avg,
        GroupedData.compared_to_avg_inc_current_day AS compared_to_avg_inc_current_day,
        GroupedData.ResetCounter AS ResetCounter,
        GroupedData.ReverseCheapCount AS ReverseCheapCount,
        cast(Result.full_details as char(150) charset utf8mb4) AS full_details 
    from (GroupedData 
    left join Result on(Result.tmpKey = Result.tmpKey)) 
    order by GroupedData.timestamp 
    limit 1
;
