select
    schm.nspname as "Schema",
    cls.relname as "Name",
    seq.seqstart as "Start Value",
    seq.seqmin as "Min Value",
    seq.seqmax as "Max Value",
    seq.seqincrement as "Increment",
    seq.seqcache as "Cache",
    seq.seqcycle as "Cycle",
    case dep.deptype
        when 'n' then 'DEPENDENCY_NORMAL'
        when 'a' then 'DEPENDENCY_AUTO'
        when 'i' then 'DEPENDENCY_INTERNAL'
        when 'P' then 'DEPENDENCY_PARTITION_PRI'
        when 'S' then 'DEPENDENCY_PARTITION_SEC'
        when 'e' then 'DEPENDENCY_EXTENSION'
        when 'x' then 'DEPENDENCY_AUTO_EXTENSION'
        when 'p' then 'DEPENDENCY_PIN'
        else '(unknown)'
    end as "Dependency Type",
    tbl.relname as "Dependent Table Name",
    col.attname as "Dependent Column Name",
    'select ''' || schm.nspname || '.' || cls.relname || ''' as sequence_name, is_called, last_value from ' || schm.nspname || '."' || cls.relname || '";' as script_get_current_value
from pg_sequence as seq
inner join pg_class as cls
    on seq.seqrelid = cls.oid
inner join pg_namespace as schm
    on cls.relnamespace = schm.oid
left outer join pg_depend as dep
    on dep.objid = seq.seqrelid and dep.refclassid = 1259
left outer join pg_attribute as col
    on dep.refobjid = col.attrelid
    and dep.refobjsubid = col.attnum
left outer join pg_class as tbl
    on col.attrelid = tbl.oid
where schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog')
order by cls.relname;