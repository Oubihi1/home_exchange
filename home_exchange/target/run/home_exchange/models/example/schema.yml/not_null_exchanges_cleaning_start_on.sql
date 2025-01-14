select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select start_on
from `mywagon-445720`.`home_exchange`.`exchanges_cleaning`
where start_on is null



      
    ) dbt_internal_test