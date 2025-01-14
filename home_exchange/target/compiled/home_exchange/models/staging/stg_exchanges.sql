

WITH cleaned_exchanges AS (
    SELECT
        -- Correct date parsing
        PARSE_DATE('%Y-%m-%d', CAST(created_at AS STRING)) AS created_at,
        PARSE_DATE('%Y-%m-%d', CAST(start_on AS STRING)) AS start_on,
        PARSE_DATE('%Y-%m-%d', CAST(end_on AS STRING)) AS end_on,
        guest_countguest_count AS guest_count,

        -- -- Preserve other columns
        * EXCEPT(created_at, start_on, end_on, guest_countguest_count)

    FROM `mywagon-445720`.`home_exchange`.`base_bigquery_exchanges`
)
SELECT * FROM cleaned_exchanges