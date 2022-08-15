select
    tbl.oid as "Object Id",
    current_database() as "Database",
    schm.nspname as "Schema",
    tbl.relname as "Name",
    rls.rolname as "Owner",
    case tbl.relkind
        when 'r' then 'Ordinary Table'
        when 'i' then 'Index'
        when 'S' then 'Sequence'
        when 't' then 'TOAST Table'
        when 'v' then 'View'
        when 'm' then 'Materialized View'
        when 'c' then 'Composite Type'
        when 'f' then 'Foreign Table'
        when 'p' then 'Partitioned Table'
        when 'I' then 'Partitioned Index'
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
where tbl.relkind in ('v', 'm')
    and schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog')
order by schm.nspname, tbl.relname;