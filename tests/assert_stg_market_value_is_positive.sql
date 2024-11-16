with market_values as (
    select 
        market_value_id,
        sum(market_value) as total_market_value
    from {{ ref("stg_market_values")}}
    group by
        market_value_id
    having
        sum(market_value) < 0
)

select
*
from market_values


