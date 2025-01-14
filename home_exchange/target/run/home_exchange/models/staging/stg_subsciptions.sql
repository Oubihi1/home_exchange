
  
    

    create or replace table `mywagon-445720`.`home_exchange`.`stg_subsciptions`
      
    
    

    OPTIONS()
    as (
      

WITH cleaned_exchanges AS (
    SELECT
        -- Correct date parsing
        first_subscription_date = STR_TO_DATE(first_subscription_date, '%Y-%m-%d'),
        subscription_date = STR_TO_DATE(subscription_date, '%Y-%m-%d'),
        MODIFY COLUMN user_id VARCHAR(255),
        -- -- Preserve other columns
        * EXCEPT(first_subscription_date, subscription_date, user_id)

    FROM `mywagon-445720`.`home_exchange`.`base_bigquery_subscriptions`
)
SELECT * FROM cleaned_exchanges
    );
  