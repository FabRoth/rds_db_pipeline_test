SELECT *
    FROM {{ ref('raw_comunio_players_and_market_values') }}
WHERE 
    matches_played IS NOT NULL AND matches_played < 0 OR 
    matches_rated IS NOT NULL AND matches_rated < 0 OR
    market_value IS NOT NULL AND market_value < 0 OR 
    shots IS NOT NULL AND shots < 0 OR
    shots_on_target IS NOT NULL AND shots_on_target < 0