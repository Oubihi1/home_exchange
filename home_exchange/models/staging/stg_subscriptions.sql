{{ config(
    materialized='table',

) }}

WITH cleaned AS (
    SELECT
        -- Correct date parsing
        PARSE_DATE('%Y-%m-%d', CAST(first_subscription_date AS STRING)) AS first_subscription_date,
        PARSE_DATE('%Y-%m-%d', CAST(subscription_date AS STRING)) AS subscription_date,

        CAST(user_id AS STRING) AS user_id,
        -- -- Preserve other columns
        * EXCEPT(first_subscription_date, subscription_date, user_id)

    FROM {{  ref('base_bigquery_subscriptions') }}
)
SELECT * FROM cleaned
