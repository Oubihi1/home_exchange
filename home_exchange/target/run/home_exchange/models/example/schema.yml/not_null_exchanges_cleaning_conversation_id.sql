select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select conversation_id
from `mywagon-445720`.`home_exchange`.`exchanges_cleaning`
where conversation_id is null



      
    ) dbt_internal_test