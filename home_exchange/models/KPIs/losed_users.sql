WITH losed_users AS (
  SELECT
    sub_month,
    payment3x_count - payment2_count AS pay2_losed_users,
    payment2_count - payment3_count AS pay3_losed_users,
    payment3x_count - payment3_count AS total_losed_users
  FROM {{ ref('payment') }}
)
SELECT * FROM losed_users;
