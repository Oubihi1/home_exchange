
    
    

with dbt_test__target as (

  select conversation_id as unique_field
  from `mywagon-445720`.`home_exchange`.`exchanges_cleaning`
  where conversation_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


