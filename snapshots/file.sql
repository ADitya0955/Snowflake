{% snapshot check_data %}

{{
    config(
        target_schema='dbo',
        unique_key='id',
        strategy='check',
        check_cols=['name','address']

    )
}}

select * from our_first_db.dbo.sales

{% endsnapshot%}