WITH matchdays AS (
    SELECT 
        *
    FROM {{ ref('raw_comunio_matchday_matches') }}
),

last_loaded_matchday AS (
    SELECT
        matchday,
        MAX(loaded_date) AS last_loaded_date
    FROM matchdays
    GROUP BY matchday
),

last_loaded_matchdays AS (
    SELECT 
        m.*
    FROM matchdays AS m
    INNER JOIN last_loaded_matchday AS l
    ON m.matchday = l.matchday
    AND m.loaded_date = l.last_loaded_date
)

SELECT DISTINCT
    m.matchday,
    m.matchday_date AS match_date,
    CAST(REPLACE(m.match_id,'matchTitle_','') AS INTEGER) AS match_id, 
    m.home_club_id,
    m.home_club_title,
    m.away_club_id,
    m.away_club_title,
    kickoff_times.kickoff_time,
    m.match_status,
    m.goals_home,
    m.goals_away,
    m.expected_goals_home,
    m.expected_goals_away,
    m.loaded_date

FROM last_loaded_matchdays AS m LEFT JOIN (
    SELECT match_id, kickoff_time
    FROM matchdays
    WHERE kickoff_time IS NOT NULL
) AS kickoff_times
ON m.match_id = kickoff_times.match_id
ORDER BY m.matchday
