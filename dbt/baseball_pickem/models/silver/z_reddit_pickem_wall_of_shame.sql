with init_clean as (
    select
        m as username,
        n as streak,
        o as pick,
        ROW_NUMBER() over () as row_num
    from {{ ref("stg_reddit_pickem_submissions") }}
),

lower_bound as (
    select row_num as lower_bound
    from init_clean
    where
        streak = 'Losing Streak'
),

trim_lower_bound as (
    select
        username::text,
        streak::text,
        pick::text,
        ROW_NUMBER() over () as row_num
    from init_clean
    where
        row_num > (select lower_bound.lower_bound from lower_bound)
),

upper_bound as (
    select MIN(row_num) as upper_bound
    from trim_lower_bound
    where username is NULL
)

select
    username::text,
    streak::text,
    pick::text
from trim_lower_bound
where
    row_num < (select upper_bound.upper_bound from upper_bound)
