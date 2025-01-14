
  
    

    create or replace table `mywagon-445720`.`home_exchange`.`test`
      
    
    

    OPTIONS()
    as (
      /*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/



with source_exchange as (

    select exchange_id as id
    from `mywagon-445720`.`home_exchange`.`base_bigquery_exchanges`

),
source_subs as (

    select subscription_date as id
    from `mywagon-445720`.`home_exchange`.`base_bigquery_subscriptions`

)


select *
from source_subs

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
    );
  