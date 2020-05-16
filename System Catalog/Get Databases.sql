select
	dbase.datname as "Database Name",
	dbase.datcollate as "Database Collation",
	pg_size_pretty(pg_database_size(dbase.datname)) as "Size",
	own.usename as "Owner Name",
	tsps.spcname as "Tablespace Name",
	case
		when dbase.datallowconn = true then 'Yes'
		else 'No'
	end as "Allow Connections",
	case
		when dbase.datconnlimit = -1 then 'Unlimited'
		else cast(dbase.datconnlimit as varchar(30))
	end as "Connections Limit"
from pg_database as dbase
inner join pg_tablespace as tsps on dbase.dattablespace = tsps.oid
left outer join pg_user as own on dbase.datdba = own.usesysid
where dbase.datistemplate = false
order by dbase.datname;