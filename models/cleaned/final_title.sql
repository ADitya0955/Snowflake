-- depends_on {{ ref ('stg_titles')}}
{{
    config(
        materialized='incremental',
        alias='MAIN_TITLES',
        incremental_strategy='append',
        unique_key=['title','director'],
        merge_exclude_columns=['title','director']

        
        )
}}


select * from {{ ref ('stg_titles')}}



