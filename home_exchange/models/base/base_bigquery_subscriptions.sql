with source as (
      select * from {{ source('bigquery', 'subscriptions') }}
),
renamed as (
    select
        {{ adapter.quote("subscription_date") }},
        {{ adapter.quote("user_id") }},
        {{ adapter.quote("renew") }},
        {{ adapter.quote("first_subscription_date") }},
        {{ adapter.quote("first_subscription") }},
        {{ adapter.quote("referral") }},
        {{ adapter.quote("promotion") }},
        {{ adapter.quote("payment3x") }},
        {{ adapter.quote("payment2") }},
        {{ adapter.quote("payment3") }},
        {{ adapter.quote("country") }},
        {{ adapter.quote("region") }},
        {{ adapter.quote("department") }},
        {{ adapter.quote("city") }}

    from source
)
select * from renamed
  