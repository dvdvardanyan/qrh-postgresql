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
	cstr.conname as "Constraint Name",
	case cstr.contype
		when 'c' then 'Check Constraint'
		when 'f' then 'Foreign Key Constraint'
		when 'p' then 'Primary Key Constraint'
		when 'u' then 'Unique Constraint'
		when 't' then 'Constraint Trigger'
		when 'x' then 'Exclusion Constraint'
	end as "Constraint Type",
	case cstr.confupdtype
		when 'a' then 'NO ACTION'
		when 'r' then 'RESTRICT'
		when 'c' then 'CASCADE'
		when 'n' then 'SET NULL'
		when 'd' then 'SET DEFAULT'
	end as "FK On Update",
	case cstr.confdeltype
		when 'a' then 'NO ACTION'
		when 'r' then 'RESTRICT'
		when 'c' then 'CASCADE'
		when 'n' then 'SET NULL'
		when 'd' then 'SET DEFAULT'
	end as "FK On Delete",
	cstr.conkey as "FK Referencing Columns",
	cstr.confkey as "FK Referenced Columns"
from pg_namespace as schm
inner join pg_class as tbl
	on schm.oid = tbl.relnamespace
left outer join pg_constraint as cstr
	on cstr.conrelid = tbl.oid
	and cstr.contype in ('f')
where tbl.relkind in ('r', 'p')
	and schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog')
	and tbl.relname in ('TABLE_NAME_HERE')
order by schm.nspname, tbl.relname, cstr.conname;