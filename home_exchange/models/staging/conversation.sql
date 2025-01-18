
{{ config(
    materialized='table'
) }}

WITH conversation AS (

  SELECT
  DATE(Created_at) AS Created_at,
  DATE(Canceled_at) AS Canceled_at,
  * EXCEPT(
  Created_at,
  Canceled_at
  ),

  DATE_DIFF(DATE(Canceled_at), DATE(Created_at), DAY) AS gap_in_days,
  capacity - guest_count AS guest_capa,
  CASE
    WHEN User_cancellation_id = Guest_user_id THEN 'Guest'
    WHEN User_cancellation_id = Host_user_id THEN 'Host'
    ELSE 'Unknown'
  END AS cancellation_type

FROM {{ ref('stg_exchanges') }}
)
SELECT * FROM conversation
where (canceled_at IS NOT NULL AND finalized_at IS NOT NULL)
