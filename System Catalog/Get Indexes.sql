select
    schm.nspname as "Schema Name",
    tbl.relname as "Table Name",
    inx.relname as "Index Name",
    array_to_string((
        select array_agg(col.attname)
        from pg_attribute as col
        where col.attrelid = tbl.oid and col.attnum = any(inx_dtl.indkey)
    ), ', ') as "Index Columns",
    inx_dtl.indisprimary as "Is Primary Key",
    inx_dtl.indisunique as "Is Unique",
    inx_dtl.indisclustered as "Table Is Clustered On",
    inx_dtl.indnkeyatts as "Number of Keys",
    inx_dtl.indnatts as "Number of Columns",
    inx_dtl.indkey as "Index Keys",
    inx_def.indexdef as "Definition"
from pg_class as tbl
left outer join pg_namespace as schm
    on tbl.relnamespace = schm.oid
left outer join pg_index as inx_dtl
    on tbl.oid = inx_dtl.indrelid
left outer join pg_class as inx
    on inx_dtl.indexrelid = inx.oid
left outer join pg_indexes as inx_def
    on schm.nspname = inx_def.schemaname
    and tbl.relname = inx_def.tablename
    and inx.relname = inx_def.indexname
where tbl.relkind in ('r', 'p')
    and schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog')
    and tbl.relname = 'TABLE_NAME_HERE'
order by inx.relname;