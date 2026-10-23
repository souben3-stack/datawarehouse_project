
    

    create  table
      "dev"."staging"."dim_products__dbt_tmp"
  
    
    as (
      with products as (
    select * from "dev"."staging"."stg_products"
)

select
    product_id,
    product_name,
    category
from products
    );
    
  