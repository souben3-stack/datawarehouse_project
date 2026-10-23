
    
    

select
    order_detail_id as unique_field,
    count(*) as n_records

from "dev"."staging"."fct_sales"
where order_detail_id is not null
group by order_detail_id
having count(*) > 1


