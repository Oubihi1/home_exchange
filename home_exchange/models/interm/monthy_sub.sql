{{ config(
    partition_by={
      "field": "subscription_date",
      "data_type": "DATE",
      "granularity": "month"
    },
    cluster_by=["user_id"]
)}}

SELECT

FORMAT_TIMESTAMP('%Y-%m', subscription_date) AS sub_month,

*
 FROM {{ ref('stg_subscriptions') }}
 WHERE subscription_date between '2019-01-01' and '2021-12-31'
