

  create or replace view `mywagon-445720`.`home_exchange`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `mywagon-445720`.`home_exchange`.`my_first_dbt_model`
where id = 1;

