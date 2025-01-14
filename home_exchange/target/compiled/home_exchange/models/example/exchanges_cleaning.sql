

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

-- -- Conversation count analysis
-- conversation_counts AS (
--     SELECT
--         conversation_id,
--         COUNT(*) AS conversation_count
--     FROM cleaned_exchanges
--     GROUP BY conversation_id
-- ),

-- -- Advanced filtering
-- filtered_exchanges AS (
--     SELECT e.*
--     FROM cleaned_exchanges e
--     LEFT JOIN conversation_counts cc
--         ON e.conversation_id = cc.conversation_id
--     WHERE
--         -- Cancellation logic
--         NOT (
--             (e.canceled_at IS NOT NULL AND e.user_cancellation_id IS NULL) OR
--             (e.canceled_at IS NULL AND e.user_cancellation_id IS NOT NULL) OR
--             (e.finalized_at IS NULL AND e.canceled_at IS NOT NULL)
--         )

--         -- Date range validation
--         AND e.start_on < e.end_on

--         -- Conversation filtering
--         AND NOT (
--             (cc.conversation_count = 3) OR
--             (cc.conversation_count = 2 AND e.exchange_type = 'NON_RECIPROCAL') OR
--             (cc.conversation_count = 1 AND e.exchange_type = 'RECIPROCAL')
--         )
-- ),

-- -- Final transformations
-- final_exchanges AS (
--     SELECT
--         *,
--         -- Night count calculation
--         DATE_DIFF(end_on, start_on, DAY) AS calculated_night_count,

--         -- Optional: Validate existing night_count
--         CASE
--             WHEN night_count != DATE_DIFF(end_on, start_on, DAY)
--             THEN DATE_DIFF(end_on, start_on, DAY)
--             ELSE night_count
--         END AS corrected_night_count

--     FROM filtered_exchanges
-- )

SELECT * FROM cleaned_exchanges