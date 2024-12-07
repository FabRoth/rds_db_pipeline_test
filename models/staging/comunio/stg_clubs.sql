with clubs as (
    select distinct
        CAST(SPLIT_PART(club_id, '-', 1) AS INTEGER) AS club_id_nr,
        club_id,
        club_title 
    from {{ref("raw_comunio_players_and_market_values")}}
)

select * from clubs