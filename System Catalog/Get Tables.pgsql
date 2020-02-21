select
	tbl.oid as "TableId",
	current_database() as "Database",
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
		end as "Kind",
	dscr.description as "Comment"
from pg_class as tbl
inner join pg_namespace as schm on tbl.relnamespace = schm.oid
left outer join pg_description as dscr on tbl.oid = dscr.objoid
where tbl.relkind in ('r', 'p') and schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog');
