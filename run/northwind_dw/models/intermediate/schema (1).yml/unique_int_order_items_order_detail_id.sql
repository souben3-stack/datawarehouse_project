
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    order_detail_id as unique_field,
    count(*) as n_records

from "dev"."staging"."int_order_items"
where order_detail_id is not null
group by order_detail_id
having count(*) > 1



  
  
      
    ) dbt_internal_test