
  
  create view "dev"."staging"."stg_customers__dbt_tmp" as (
    with source as (
    select * from "dev"."raw"."customers"
),

renamed as (
    select
        -- On garde le cast uniquement sur la clé primaire
        cast(id as integer) as customer_id,

        -- Les champs texte sont simplement renommés
        company as company_name,
        last_name,
        first_name,
        email_address,
        job_title,
        business_phone,
        home_phone,
        mobile_phone,
        fax_number,
        address,
        city,
        state_province,
        zip_postal_code,
        country_region,
        web_page,
        notes

    from source
    where id is not null
)

select * from renamed
  );
