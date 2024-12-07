WITH market_values AS (

SELECT
    md5(CONCAT(player_id, '-' ,loaded_date)::text) AS market_value_id,
    player_id,
    market_value,
    loaded_date
FROM {{ref("raw_comunio_players_and_market_values")}}

)

SELECT * FROM market_values