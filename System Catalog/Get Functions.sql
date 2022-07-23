select
	proc."oid" as "Id",
	schm.nspname as "Schema",
	proc.proname as "Name",
	case proc.prokind
		when 'f' then 'Function'
		when 'p' then 'Procedure'
		when 'a' then 'Aggregate Function'
		when 'w' then 'Window Function'
	end as "Kind",
	rls.rolname as "Owner",
	proc.prosecdef as "Security Definer",
	'alter function ' || schm.nspname || '.' || proc.proname || ' owner to USERNAME;' as script_set_owner
from pg_catalog.pg_proc as proc
inner join pg_namespace as schm
	on proc.pronamespace = schm.oid
left outer join pg_catalog.pg_roles as rls
	on proc.proowner = rls.oid
where schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog')
order by schm.nspname, proc.proname;