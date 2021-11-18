--> Temporary Files

select
	datname as "Database Name",
	temp_files as "Files Count",
	temp_bytes as "Files Size",
	pg_size_pretty(temp_bytes) as "Files Size Readable"
from pg_stat_database ;

/* Temporary files are created for sorts, hashes, and temporary query results.
 * A log entry is made for each temporary file when the file is deleted.
 * To track the creation of temporary space used by a single query, set log_temp_files
 * in a custom parameter group. This parameter controls the logging of temporary file
 * names and sizes. If you set the log_temp_files value to 0, all temporary file
 * information is logged. If you set the parameter to a positive value, only files
 * sizes that are greater than or equal to the specified number of kilobytes are logged.
 * The default setting is -1, which logs the creation of temporary files and the executed
 * statements.*/
