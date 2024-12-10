WITH clubs AS (
    SELECT DISTINCT
        CAST(SPLIT_PART(club_id, '-', 1) AS INTEGER) AS club_id,
        club_id as comunio_club_id,
        club_title
    FROM {{ref("raw_comunio_players_and_market_values")}}
)

SELECT * FROM clubs