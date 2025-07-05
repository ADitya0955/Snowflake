{{
    config(
        pre_hook="alter external table {{ source('raw_title','EXT_TABLE')}} refresh;"
    )
}}

with CTE AS(

SELECT 
$1:c1::varchar as SHOW_ID,
$1:c2::varchar as TYPE,
$1:c3::varchar as TITLE,
$1:c4::varchar as DIRECTOR,
$1:c5::varchar as CAST,
$1:c6::varchar as COUNTRY,
$1:c7::varchar as DATE_ADDED,
$1:c8::varchar as RELEASE_YEAR,
$1:c9::varchar as RATING,
$1:c10::varchar as DURATION,
$1:c11::varchar as LISTED_IN,
$1:c12::varchar as DESCRIPTION,
SPLIT_PART(SPLIT_PART(metadata$filename,'/',2),'.',1)::VARCHAR AS SOURCEFILENAME

FROM {{ source('raw_title','EXT_TABLE')}}

)
select * from CTE