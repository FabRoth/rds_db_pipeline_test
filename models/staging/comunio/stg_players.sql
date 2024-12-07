WITH players AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY player_id
            ORDER BY loaded_date DESC
        ) AS row_number
    FROM {{ ref('raw_comunio_players_and_market_values') }}
)

SELECT DISTINCT
    player_id,
    player_name,
    position,
    comunio_profile_url,
    club_id,
    loaded_date 
FROM players
WHERE row_number = 1
