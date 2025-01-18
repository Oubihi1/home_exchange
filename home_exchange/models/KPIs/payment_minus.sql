{{ config(
    partition_by={
      "field": "subscription_date",
      "data_type": "DATE",
      "granularity": "month"
    }
)}}

WITH payment AS (
  SELECT
    -- date in yyyy-mm
    FORMAT_TIMESTAMP('%Y-%m', subscription_date) AS sub_month,
    -- total of users by month
    COUNT(user_id) AS user_count,
   --
    COUNT(first_subscription) - SUM(first_subscription) AS first_subscription_minus,
    --
    COUNT(renew) - SUM(renew) AS renew_minus,
    --
    COUNT(referral) - SUM(referral) AS referral_minus,
    --
    COUNT(promotion) - SUM(promotion) AS promotion_minus,
    --
    COUNT(payment3x) - SUM(payment3x) AS payment3x_minus,
    --
    COUNT(payment2) - SUM(payment2) AS payment2_minus,
    --
    COUNT(payment3) - SUM(payment3) AS payment3_minus
  FROM {{ ref('stg_subscriptions') }}
  WHERE subscription_date BETWEEN '2019-01-01' AND '2021-12-31'
  GROUP BY sub_month
  ORDER BY sub_month ASC
)
SELECT * FROM payment
