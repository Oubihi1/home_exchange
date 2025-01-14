with source as (
      select * from {{ source('bigquery', 'exchanges') }}
),
renamed as (
    select
        {{ adapter.quote("conversation_id") }},
        {{ adapter.quote("exchange_id") }},
        {{ adapter.quote("created_at") }},
        {{ adapter.quote("creator_id") }},
        {{ adapter.quote("guest_user_id") }},
        {{ adapter.quote("host_user_id") }},
        {{ adapter.quote("finalized_at") }},
        {{ adapter.quote("canceled_at") }},
        {{ adapter.quote("start_on") }},
        {{ adapter.quote("end_on") }},
        {{ adapter.quote("guest_countguest_count") }},
        {{ adapter.quote("night_count") }},
        {{ adapter.quote("user_cancellation_id") }},
        {{ adapter.quote("exchange_type") }},
        {{ adapter.quote("home_type") }},
        {{ adapter.quote("residence_type") }},
        {{ adapter.quote("capacity") }},
        {{ adapter.quote("country") }},
        {{ adapter.quote("region") }},
        {{ adapter.quote("department") }},
        {{ adapter.quote("city") }}

    from source
)
select * from renamed
  