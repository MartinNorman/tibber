select 
    a.timestamp AS timestamp,
    a.date AS date,
    a.hour AS hour,
    a.price AS price,
    a.timestamp_original_format AS timestamp_original_format,
    (select avg(b.price) from Energy.Price b where b.timestamp > current_timestamp()) AS average,
    (select avg(c.price) from Energy.Price c where c.date >= curdate()) AS average_inc_current_day,
    a.price / (select avg(b.price) from Energy.Price b where b.timestamp > current_timestamp()) AS compared_to_avg,
    a.price / (select avg(c.price) from Energy.Price c where c.date >= curdate()) AS compared_to_avg_inc_current_day 
from Energy.Price a 
where 
    a.timestamp > current_timestamp()
;
# Adding comment
