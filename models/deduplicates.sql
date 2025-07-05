{{ dbt_utils.deduplicate(
    relation='our_first_db.DBO.FINAL_SALES',
    partition_by='ID',
    order_by="STARTDATE desc",
   )
}}