with players as (
    select distinct
        comstats_data_player_id as player_id,
        player_name,
        position,
        comunio_profile_url,
        club_id
    from {{ source('comunio', 'raw_comunio_players') }}
)

select * from players