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
    -- sum of first_subscription users by month
    SUM(first_subscription) AS first_subscription_count,
    -- did the user re-subscribe the following year (the month of the expiration of his subscription) by month
    SUM(renew) AS renew_count,
    -- sum of users has been sponsored by month
    SUM(referral) AS referral_count,
    -- sum of users had a promotion for his subscription by month
    SUM(promotion) AS promotion_count,
    -- sum of users has used the 3x payment to subscribe by month
    SUM(payment3x) AS payment3x_count,
    -- sum of users has paid his 2nd payment by month
    SUM(payment2) AS payment2_count,
    -- sum user has paid his 3rd payment by month
    SUM(payment3) AS payment3_count
  FROM {{ ref('stg_subscriptions') }}
  WHERE subscription_date BETWEEN '2019-01-01' AND '2021-12-31'
  GROUP BY sub_month
  ORDER BY sub_month ASC
)
SELECT * FROM payment
