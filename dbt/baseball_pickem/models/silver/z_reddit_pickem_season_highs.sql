with init_clean as (
    select
        h as username,
        j as streak_type,
        k as streak_length,
        ROW_NUMBER() over (
            order by
                j
        ) as row_num
    from {{ ref("stg_reddit_pickem_submissions") }}
    where k !~ '\D'
)

-- bound as (
--     select MIN(row_num) as upper_bound
--     from init_clean
--     where streak_length is not NULL
-- )

select
    username::text,
    streak_type::text,
    streak_length::int
from init_clean
where
    username is not NULL
    and streak_type is not NULL
    and streak_length is not NULL
