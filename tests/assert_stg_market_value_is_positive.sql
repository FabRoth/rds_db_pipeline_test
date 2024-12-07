WITH market_values AS (
    SELECT 
        market_value_id,
        SUM(market_value) AS total_market_value
    FROM {{ ref("stg_market_values")}}
    GROUP BY
        market_value_id
    HAVING
        SUM(market_value) < 0
)

SELECT
*
FROM market_values


