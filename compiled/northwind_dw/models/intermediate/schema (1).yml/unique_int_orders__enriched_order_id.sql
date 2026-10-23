
    
    

select
    order_id as unique_field,
    count(*) as n_records

from "dev"."staging"."int_orders__enriched"
where order_id is not null
group by order_id
having count(*) > 1


