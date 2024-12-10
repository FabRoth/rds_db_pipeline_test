WITH comunio_players AS (
    SELECT 
        club_id,
        club_title,
        position,
        comstats_data_player_id AS player_id,
        comunio_profile_url,
        player_name,
        points,
        matches_played,
        matches_rated,
        CASE 
            WHEN points_per_match = '-' THEN NULL
            ELSE REPLACE(points_per_match, ',', '.')
        END AS points_per_match,
        -- CAST(REPLACE(points_per_match, ',', '.') AS FLOAT) AS points_per_match,
        CAST(shots AS INTEGER) AS shots,
        CAST(shots_on_target AS INTEGER) AS shots_on_target,
        CASE
            WHEN passing_accuracy = '-' THEN NULL
            ELSE REPLACE(passing_accuracy, '%', '')
        END AS passing_accuracy_percentage,
        CASE
            WHEN tackling_success_rate = '-' THEN NULL
            ELSE REPLACE(tackling_success_rate, '%', '')
        END AS tackling_success_rate_percentage,
        market_value,
        trend,
        CASE
            WHEN loaded_date LIKE '%/%' THEN 
                REPLACE(loaded_date, '/', '-') || ' 00:00:00'
            ELSE 
                loaded_date
        END
        loaded_date
    FROM {{source("comunio", "raw_comunio_players")}}
)

SELECT
        club_id,
        club_title,
        position,
        CAST(player_id AS INTEGER) AS player_id,
        comunio_profile_url,
        player_name,
        CAST(points AS FLOAT) AS points,
        CAST(matches_played AS INTEGER) AS matches_played,
        CAST(matches_rated AS INTEGER) AS matches_rated,
        CAST(points_per_match AS FLOAT) AS points_per_match,
        CAST(shots AS INTEGER) AS shots,
        CAST(shots_on_target AS INTEGER) AS shots_on_target,
        CAST(passing_accuracy_percentage AS FLOAT) AS passing_accuracy_percentage,
        CAST(tackling_success_rate_percentage AS FLOAT) AS tackling_success_rate_percentage,
        CAST(market_value AS FLOAT) AS market_value,
        trend,
        CAST(loaded_date AS TIMESTAMP) AS loaded_date

FROM comunio_players
