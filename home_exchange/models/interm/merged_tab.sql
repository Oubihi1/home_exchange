
with
stg_exchanges as (
    select * from {{ ref('stg_exchanges') }}
),
stg_subscriptions as (
    select * from {{ ref('stg_subscriptions') }}
)
SELECT * FROM stg_exchanges
left join stg_subscriptions on stg_exchanges.creator_id = stg_subscriptions.user_id
