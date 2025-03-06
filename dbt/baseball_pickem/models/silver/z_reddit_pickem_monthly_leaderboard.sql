with init_clean as (
    select
        g as rank,
        h as username,
        k as score,
        j,
        ROW_NUMBER() over (
            order by
                g
        ) as row_num
    from {{ ref("stg_reddit_pickem_submissions") }}
    where k !~ '\D'
),

bound as (
    select MIN(row_num) as upper_bound
    from init_clean
    where j is not NULL
)

select
    rank::int,
    username::text,
    score::int
from init_clean
where
    rank is not NULL
    and username is not NULL
    and score is not NULL
    and row_num < (select bound.upper_bound from bound)
