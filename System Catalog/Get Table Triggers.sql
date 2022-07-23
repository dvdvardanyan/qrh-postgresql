select 
    schm.nspname as "Schema",
    tbl.relname as "Name",
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
    end as "Table Kind",
    trg.tgname as "Trigger Name",
    case trg.tgenabled
        when 'O' then 'Origin and Local modes'
        when 'D' then 'Disabled'
        when 'R' then 'Replica mode'
        when 'A' then 'Always'
    end as "Firing Mode",
    case when (tgtype::int::bit(7) & b'0000001')::int = 0 then 'STATEMENT' else 'EACH ROW' end as "Row Condition",
      coalesce(
        case when (tgtype::int::bit(7) & b'0000010')::int = 0 then null else 'BEFORE' end,
        case when (tgtype::int::bit(7) & b'0000010')::int = 0 then 'AFTER' else null end,
        case when (tgtype::int::bit(7) & b'1000000')::int = 0 then null else 'INSTEAD OF' end,
        ''
      )::text as "Timing Condition", 
        (case when (tgtype::int::bit(7) & b'0000100')::int = 0 then '' else ' INSERT' end) ||
        (case when (tgtype::int::bit(7) & b'0001000')::int = 0 then '' else ' DELETE' end) ||
        (case when (tgtype::int::bit(7) & b'0010000')::int = 0 then '' else ' UPDATE' end) ||
        (case when (tgtype::int::bit(7) & b'0100000')::int = 0 then '' else ' TRUNCATE' end)
      as "Event Condition",
    fnc_schm.nspname || '.' || fnc.proname as "Trigger Function",
    trg.tgnargs as "Function Arguments",
    trg.tgisinternal as "Is Internal"
from pg_catalog.pg_class as tbl
inner join pg_catalog.pg_namespace as schm
    on tbl.relnamespace = schm.oid
inner join pg_catalog.pg_trigger as trg
    on tbl.oid = trg.tgrelid
left outer join pg_catalog.pg_proc as fnc
    on trg.tgfoid = fnc.oid
left outer join pg_catalog.pg_namespace as fnc_schm
    on fnc.pronamespace = fnc_schm.oid
where tbl.relkind in ('r', 'p')
    and schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog')
    and trg.tgisinternal = false
    and tbl.relname in ('TABLE_NAME_HERE')
order by schm.nspname, tbl.relname, trg.tgname;