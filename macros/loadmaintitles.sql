{% macro loadmaintitles() %}

{% set main_query %} 

CREATE OR REPLACE TEMPORARY TABLE OUR_FIRST_DB.DBO.FILESTOPROCESS AS
select distinct src.SOURCEFILENAME from {{ref('stg_titles')}} src
left join 
OUR_FIRST_DB.DBO.MAIN_TITLES target on src.SOURCEFILENAME=target.SOURCEFILENAME
where target.SOURCEFILENAME is null;

{% endset %}
{{ run_query(main_query)}}

{% set sql_count %}

select 1 from OUR_FIRST_DB.DBO.FILESTOPROCESS;

{% endset %}
{% set data_exist=run_query(sql_count)%}

{% for data in data_exist %}

    {% set filename %}
        select distinct sourcefilename from OUR_FIRST_DB.DBO.FILESTOPROCESS order by sourcefilename limit 1;
    {% endset %}
    {% set SOURCEFILENAME=run_query(filename)[0][0]%}
  
    {% set insert_query %}
        INSERT INTO OUR_FIRST_DB.DBO.MAIN_TITLES
        SELECT * FROM {{ref("stg_titles")}} where SOURCEFILENAME='{{SOURCEFILENAME}}';
    {% endset %}
    {{ run_query(insert_query) }}

    {% set delete_query %}
        DELETE FROM OUR_FIRST_DB.DBO.FILESTOPROCESS WHERE SOURCEFILENAME='{{SOURCEFILENAME}}';
    {% endset %}
    {{ run_query(delete_query) }}

   
{% endfor %}
{% endmacro %}





