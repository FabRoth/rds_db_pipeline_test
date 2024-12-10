WITH matches AS (
    SELECT 
        CAST(matchday AS INTEGER) AS matchday,
        TO_DATE(
            TRIM(SPLIT_PART(date, ', ', 2)),
            'DD.MM.YYYY'
        ) AS matchday_date,
        match_id,
        CAST(kickoff_time AS TIME) AS kickoff_time,
        CAST(home_club_id AS INTEGER) AS home_club_id,
        home_club_title,
        CAST(away_club_id AS INTEGER) AS away_club_id,
        away_club_title,
        CAST(goals_home AS FLOAT) AS goals_home,
        CAST(goals_away AS FLOAT) AS goals_away,
        CAST(REPLACE(expected_goals_home, ',', '.') AS FLOAT) AS expected_goals_home,
        CAST(REPLACE(expected_goals_away, ',', '.') AS FLOAT) AS expected_goals_away,
        match_status,
        CAST(loaded_date AS TIMESTAMP) AS loaded_date

    FROM {{source("comunio", "raw_comunio_matches")}}

)

SELECT * FROM matches
