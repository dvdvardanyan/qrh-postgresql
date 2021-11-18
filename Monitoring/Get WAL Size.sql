--> WAL File Count

select
	name as "WAL File Name",
	size as "Size",
	pg_size_pretty(size) as "Size Readable",
	modification as "Modification"
from pg_catalog.pg_ls_waldir()
order by modification desc;

--> Ready-to-archive WAL file count

select
	name as "WAL File Name",
	size as "Size",
	pg_size_pretty(size) as "Size Readable",
	modification as "Modification"
from pg_catalog.pg_ls_archive_statusdir()
order by modification desc;

--> WAL archiver process activity

select * from pg_catalog.pg_stat_archiver;













