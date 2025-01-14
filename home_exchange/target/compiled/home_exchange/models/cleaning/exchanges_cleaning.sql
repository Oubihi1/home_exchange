-- dbt model for cleaning and transforming exchanges data


WITH cleaned_exchanges AS (
    -- Basic data cleaning and type conversion
    SELECT
        -- Ensure proper date parsing and handling
        SAFE.PARSE_DATE('%Y-%m-%d', created_at) AS created_at,
        SAFE.PARSE_DATE('%Y-%m-%d', start_on) AS start_on,
        SAFE.PARSE_DATE('%Y-%m-%d', end_on) AS end_on,

        -- Rename or clean specific columns
        COALESCE(guest_countguest_count, guest_count) AS guest_count,

        -- Rest of the columns
        * EXCEPT(created_at, start_on, end_on, guest_countguest_count, guest_count)

    FROM `mywagon-445720`.`home_exchange`.`base_bigquery_exchanges`
),

-- Count conversations
conversation_counts AS (
    SELECT
        conversation_id,
        COUNT(*) AS conversation_count
    FROM cleaned_exchanges
    GROUP BY conversation_id
),

-- Filter out problematic records
filtered_exchanges AS (
    SELECT e.*
    FROM cleaned_exchanges e
    LEFT JOIN conversation_counts cc ON e.conversation_id = cc.conversation_id
    WHERE
        -- Remove rows with inconsistent cancellation data
        NOT (
            (e.canceled_at IS NOT NULL AND e.user_cancellation_id IS NULL) OR
            (e.canceled_at IS NULL AND e.user_cancellation_id IS NOT NULL) OR
            (e.finalized_at IS NULL AND e.canceled_at IS NOT NULL)
        )

        -- Ensure valid date range
        AND e.start_on < e.end_on

        -- Filter out conversations based on repetition and type
        AND NOT (
            -- Remove conversations repeated 3 times
            (cc.conversation_count = 3) OR

            -- Remove conversations repeated 2 times with NON_RECIPROCAL type
            (cc.conversation_count = 2 AND e.exchange_type = 'NON_RECIPROCAL') OR

            -- Remove conversations repeated 1 time with RECIPROCAL type
            (cc.conversation_count = 1 AND e.exchange_type = 'RECIPROCAL')
        )
),

-- Recalculate night count
final_exchanges AS (
    SELECT
        *,
        -- Recalculate night_count based on date difference
        DATE_DIFF(end_on, start_on, DAY) AS night_count
    FROM filtered_exchanges
)

SELECT * FROM final_exchanges