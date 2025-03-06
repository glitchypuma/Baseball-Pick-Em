with init_clean as (
    select
        h as username,
        k as guesses,
        j,
        ROW_NUMBER() over () as row_num
    from {{ ref("stg_reddit_pickem_submissions") }}
    where k !~ '\D'
),

bound as (
    select MIN(row_num) as lower_bound
    from init_clean
    where j is not NULL
)

select
    username::text,
    guesses::int
from init_clean
where
    username is not NULL
    and guesses is not NULL
    and row_num > (select bound.lower_bound from bound)
