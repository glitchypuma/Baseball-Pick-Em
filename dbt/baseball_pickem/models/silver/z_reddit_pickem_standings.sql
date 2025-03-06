with init_clean as (
    select
        b as rank,
        c as username,
        d as score,
        e as win_pct,
        f as streak
    from {{ ref("stg_reddit_pickem_submissions") }}
    where b !~ '\D'
)

select
    rank::int,
    username::text,
    score::int,
    win_pct::text,
    streak::int
from init_clean
where
    rank is not NULL
    and username is not NULL
