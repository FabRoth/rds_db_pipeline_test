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
    players.player_id,
    players.player_name,
    players.position,
    clubs.club_id,
    players.loaded_date 
FROM players LEFT JOIN {{ ref('stg_clubs') }} AS clubs
ON clubs.comunio_club_id = players.club_id
WHERE row_number = 1
