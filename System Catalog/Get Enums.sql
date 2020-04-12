select
	current_database() as "database",
	schm.nspname as "schema",
	typ.typname as "name",
	(select array_agg((e.enumlabel) order by (e.enumsortorder)) from pg_enum as e where e.enumtypid = typ.oid) as "values"
from pg_type as typ
inner join pg_namespace as schm on typ.typnamespace = schm.oid
where typ.typtype = 'e'
