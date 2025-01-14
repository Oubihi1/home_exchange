
    
    

with all_values as (

    select
        exchange_type as value_field,
        count(*) as n_records

    from `mywagon-445720`.`home_exchange`.`exchanges_cleaning`
    group by exchange_type

)

select *
from all_values
where value_field not in (
    'RECIPROCAL','NON_RECIPROCAL'
)


