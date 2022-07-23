select
    tbl.oid as "TableId",
    current_database() as "Database",
    schm.nspname as "Schema",
    tbl.relname as "Name",
    rls.rolname as "Owner",
    case tbl.relkind
        when 'r' then 'Ordinary table'
        when 'i' then 'Index'
        when 'S' then 'Sequence'
        when 't' then 'TOAST table'
        when 'v' then 'View'
        when 'm' then 'Materialized view'
        when 'c' then 'Composite type'
        when 'f' then 'Foreign table'
        when 'p' then 'Partitioned table'
        when 'I' then 'Partitioned index'
        end as "Kind",
    dscr.description as "Comment",
    'alter table ' || schm.nspname || '.' || tbl.relname || ' owner to USERNAME;' as script_set_owner
from pg_class as tbl
inner join pg_namespace as schm
    on tbl.relnamespace = schm.oid
left outer join pg_catalog.pg_roles as rls
    on tbl.relowner = rls.oid
left outer join pg_description as dscr
    on tbl.oid = dscr.objoid and dscr.objsubid = 0
where tbl.relkind in ('r', 'p')
    and schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog')
order by schm.nspname, tbl.relname;