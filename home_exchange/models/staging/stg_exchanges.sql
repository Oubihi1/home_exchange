

WITH cleaned_exchanges AS (
    SELECT
        -- Correct date parsing
        PARSE_DATE('%Y-%m-%d', CAST(created_at AS STRING)) AS created_at,
        PARSE_DATE('%Y-%m-%d', CAST(start_on AS STRING)) AS start_on,
        PARSE_DATE('%Y-%m-%d', CAST(end_on AS STRING)) AS end_on,
        guest_countguest_count AS guest_count,
        country AS ex_country,
        region AS ex_region,
        department AS ex_department,
        city AS ex_city,

        -- -- Preserve other columns
        * EXCEPT(created_at, start_on, end_on, guest_countguest_count, country, region, department, city)

    FROM {{  ref('base_bigquery_exchanges') }}
)
SELECT * FROM cleaned_exchanges
WHERE NOT (
    -- Condition 1: Exclude rows where 'canceled_at' is null but 'user_cancellation_id' has a value
    (canceled_at IS NOT NULL AND user_cancellation_id IS NULL)

    OR

    -- Condition 2: Exclude rows where 'finalized_at' is null but 'canceled_at' has a value
    (finalized_at IS NOT NULL AND canceled_at IS NULL)

    OR

    -- Condition 3: Exclude rows where 'start_on' date is greater than or equal to 'end_on' date
    (start_on >= end_on)
)
