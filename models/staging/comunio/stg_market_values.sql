with market_values as(

select
    concat(comstats_data_player_id, '-' ,loaded_date) as market_value_id,
    comstats_data_player_id as player_id,
    market_value,
    loaded_date
from {{ source('comunio', 'raw_comunio_players') }}

)

select * from market_values