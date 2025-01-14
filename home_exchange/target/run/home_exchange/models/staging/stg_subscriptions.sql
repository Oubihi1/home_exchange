
  
    

    create or replace table `mywagon-445720`.`home_exchange`.`stg_subscriptions`
      
    
    

    OPTIONS()
    as (
      

WITH cleaned AS (
    SELECT
        -- Correct date parsing
        PARSE_DATE('%Y-%m-%d', CAST(first_subscription_date AS STRING)) AS first_subscription_date,
        PARSE_DATE('%Y-%m-%d', CAST(subscription_date AS STRING)) AS subscription_date,

        CAST(user_id AS STRING) AS user_id,
        -- -- Preserve other columns
        * EXCEPT(first_subscription_date, subscription_date, user_id)

    FROM `mywagon-445720`.`home_exchange`.`base_bigquery_subscriptions`
)
SELECT * FROM cleaned
    );
  