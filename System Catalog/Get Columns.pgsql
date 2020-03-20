select
	tbl.oid as "TableId",
	current_database() as "Database Name",
	schm.nspname as "Schema Name",
	tbl.relname as "Table Name",
	col.attnum as "Column Index",
    col.attname as "Column Name",
    not col.attnotnull as "Is Nullable",
    typ.typtype as "Type Group Code",
    case typ.typtype
    	when 'b' then 'Base Type'
    	when 'c' then 'Composite Type'
    	when 'd' then 'Domain Type'
    	when 'e' then 'Enum Type'
    	when 'p' then 'Pseudo Type'
    	when 'r' then 'Range Type'
    	else 'Unknown'
    end as "Type Group",
    typ.typname as "Type Name",
    case col.atttypid
	    when 1043 then nullif(col.atttypmod, -1) - 4
	    when 1042 then nullif(col.atttypmod, -1) - 4
	    when 1114 then nullif(col.atttypmod, -1)
	    when 1184 then nullif(col.atttypmod, -1)
	    when 1083 then nullif(col.atttypmod, -1)
	    when 1266 then nullif(col.atttypmod, -1)
	    when 1560 then nullif(col.atttypmod, -1)
	    when 1562 then nullif(col.atttypmod, -1)
	    else null
	end as "length",
	case
	    when col.atttypid = 1700 then ((nullif(col.atttypmod, -1) - 4) >> 16) & 65535
	    else null
	end as "precision",
	case
	    when col.atttypid = 1700 then (nullif(col.atttypmod, -1) - 4) & 65535
	    else null
	end as "scale",
	col.attndims as "dimension",
	(select array_agg((e.enumlabel) order by (e.enumsortorder)) from pg_enum as e where e.enumtypid = col.atttypid) as "Enumerates",
	pg_get_expr(dflt.adbin, dflt.adrelid) as "Default Expression",
	cls.relname as "Sequence Name",
    seq.seqstart as "Sequence Start Value",
    seq.seqmin as "Sequence Min Value",
    seq.seqmax as "Sequence Max Value",
    seq.seqincrement as "Sequence Increment",
    seq.seqcache as "Sequence Cache",
    dscr.description as "Comment"
from pg_namespace as schm
inner join pg_class as tbl on schm.oid = tbl.relnamespace
inner join pg_attribute as col on tbl.oid = col.attrelid and col.attnum > 0
inner join pg_type as typ on col.atttypid = typ.oid
left outer join pg_attrdef as dflt on dflt.adrelid = tbl.oid and dflt.adnum = col.attnum
left outer join pg_depend as dep on dep.refobjid = tbl.oid and dep.refobjsubid = col.attnum
left outer join pg_sequence as seq on dep.objid = seq.seqrelid
left outer join pg_class as cls on seq.seqrelid = cls.oid
left outer join pg_description as dscr on col.attrelid = dscr.objoid and col.attnum = dscr.objsubid
where tbl.relkind in ('r', 'p') and schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog');
