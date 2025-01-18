WITH losed_users AS (
  SELECT
  -- date in yyyy-mm
    sub_month,
    -- number of users lost after the 1st payment
    payment3x_count - payment2_count AS pay2_lost_users,
    -- number of users lost after the 2nd payment
    payment2_count - payment3_count AS pay3_lost_users,
    -- total number of users lost
    payment3x_count - payment3_count AS total_lost_users
  FROM {{ ref('payment') }}
)
SELECT *
FROM losed_users
