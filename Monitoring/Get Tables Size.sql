select
	schm.nspname || '.' || cls.relname as "Object",
	case cls.relkind
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
	end as "Type",
	cls.reltuples as "Number of Records",
	pg_size_pretty(pg_total_relation_size(cls.oid)) as "Size"
from pg_class as cls
inner join pg_namespace as schm
	on cls.relnamespace = schm.oid
where schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog')
order by schm.nspname, pg_total_relation_size(cls.oid) desc;
