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
count(user_id) as user_count,
sum(renew) as renew_count,

 FROM {{ ref('stg_subscriptions') }}
 WHERE subscription_date between '2019-01-01' and '2021-12-31'
 group by sub_month
 order by sub_month asc
