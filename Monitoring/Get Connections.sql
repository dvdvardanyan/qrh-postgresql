select
	act.pid as "Process Id",
	act.usesysid as "User Id",
	act.usename as "User Name",
	act.state as "Connection State",
	act.datid as "Database ID",
	act.datname as "Database Name",
	act.query as "Query",
	act.wait_event_type as "Wait Event Type",
	act.wait_event as "Wait Event",
	act.xact_start as "Transaction Start",
	act.backend_xid as "Top-level Transaction Identifier",
	act.backend_xmin as "Current Transaction Identifier",
	act.query_start as "Query Start",
	act.backend_start as "Connection Start",
	act.application_name as "Application Name",
	act.client_addr as "Client IPv4",
	act.client_hostname||':'||act.client_port as "Client Hostname"
from pg_stat_activity as act;