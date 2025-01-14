
WITH cleaned AS (
    SELECT
        -- Correct date parsing
        PARSE_DATE('%Y-%m-%d', CAST(first_subscription_date AS STRING)) AS first_subscription_date,
        PARSE_DATE('%Y-%m-%d', CAST(subscription_date AS STRING)) AS subscription_date,
        country AS sub_country,
        region AS sub_region,
        department AS sub_department,
        city AS sub_city,
        -- -- Preserve other columns
        * EXCEPT(first_subscription_date, subscription_date,country, region, department, city),
        ROW_NUMBER() OVER (PARTITION BY user_id, subscription_date ) AS row_num

    FROM {{  ref('base_bigquery_subscriptions') }}
)
SELECT *
EXCEPT(row_num)
FROM cleaned
WHERE row_num = 1
