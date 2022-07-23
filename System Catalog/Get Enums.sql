select
	current_database() as "Database",
	schm.nspname as "Schema",
	typ.typname as "Name",
	(
		select array_agg((e.enumlabel) order by (e.enumsortorder))
		from pg_enum as e
		where e.enumtypid = typ.oid
	) as "Values"
from pg_type as typ
inner join pg_namespace as schm
	on typ.typnamespace = schm.oid
where typ.typtype = 'e'
order by schm.nspname, typ.typname;