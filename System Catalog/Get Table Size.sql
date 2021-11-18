select
	schm.nspname as "Schema Name",
	cls.relname as "Object Name",
	pg_size_pretty(pg_total_relation_size(cls.oid)) as "Total Size",
	pg_size_pretty(pg_table_size(cls.oid)) as "Table Size",
	pg_size_pretty(pg_indexes_size(cls.oid)) as "Indexes Size",
	pg_size_pretty(pg_relation_size(cls.oid, 'main')) as "Main Size",
	pg_size_pretty(pg_relation_size(cls.oid, 'fsm')) as "Free Space Map Size",
	pg_size_pretty(pg_relation_size(cls.oid, 'vm')) as "Visibility Map Size",
	pg_size_pretty(pg_relation_size(cls.oid, 'init')) as "Initialization Fork Size"
from pg_class as cls
inner join pg_namespace as schm on cls.relnamespace = schm.oid
where schm.nspname not in ('pg_toast', 'information_schema', 'pg_catalog')
and cls.relname in ('TABLE_NAME_HERE');
