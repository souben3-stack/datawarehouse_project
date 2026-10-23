
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_detail_id
from "dev"."staging"."fct_sales"
where order_detail_id is null



  
  
      
    ) dbt_internal_test