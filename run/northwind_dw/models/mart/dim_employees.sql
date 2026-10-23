
    

    create  table
      "dev"."staging"."dim_employees__dbt_tmp"
  
    
    as (
      with employees as (
    select * from "dev"."staging"."stg_employees"
)

select
    employee_id,
    concat(first_name, ' ', last_name) as employee_full_name,
    job_title
from employees
    );
    
  