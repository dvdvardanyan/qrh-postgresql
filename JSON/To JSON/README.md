# Generate JSON

### JSON for each row

Use **row_to_json** to generate json from the data set row.

See example below:

```sql
select
    tbl.oid,
    (
        select row_to_json(t) from ( select sch.nspname as "schemaName", tbl.relname as "tableName") as t 
    ) as table_json
from pg_catalog.pg_class as tbl
inner join pg_catalog.pg_namespace as sch on tbl.relnamespace = sch.oid
where tbl.relkind in ('r', 'p')
limit 10;
```

For each required JSON tag add a row_to_json select statement.

See example below:

```sql
select
    tbl.oid,
    (
        select row_to_json(t) from (
            select
                (
                    select row_to_json(t) from (select sch.nspname as "schemaName") as t 
                ) as "schema",
                (
                    select row_to_json(t) from (select tbl.relname as "tableName") as t 
                ) as "table"
        ) as t 
    ) as table_json
from pg_catalog.pg_class as tbl
inner join pg_catalog.pg_namespace as sch on tbl.relnamespace = sch.oid
where tbl.relkind in ('r', 'p')
limit 10;
```

### Aggregate a data set into a JSON row

Use **json_agg()** to generate a JSON from the complete data set.

See example below:

```sql
select
    tbl.oid,
    tbl.relname,
    (
        select json_agg(t) from (
            select col.attname as "name"
            from pg_catalog.pg_attribute as col
            where col.attrelid = tbl.oid
        ) as t
    ) as "columns_json"
from pg_catalog.pg_class as tbl
inner join pg_catalog.pg_namespace as sch on tbl.relnamespace = sch.oid
where tbl.relkind in ('r', 'p')
limit 10;
```

### Enclosing column inside a JSON array

Use **array()** if array elements should be retrieved from a select statement. Note that subquery must return only 1 column, as every value inside the column will be an array item. You can use row_to_json to combine columns into a single JSON object.

Use **array[]** if every array element should be set explicitly, It can also be used to generate an empty array.

If **NULL** values should be eliminated from the array - **array_remove** function can be used.

See example below:

```sql
select
    tbl.oid,
    (
        select row_to_json(t) from (
            select
                array(select tbl.relname) as "tableName",
                array(select row_to_json(t) from (select sch.nspname as "schema", tbl.relname as "name") as t) as "table",
                array_remove(array[sch.nspname, tbl.relname], null),
                array[]::varchar[] as "additionalData"
        ) as t 
    ) as table_json
from pg_catalog.pg_class as tbl
inner join pg_catalog.pg_namespace as sch on tbl.relnamespace = sch.oid
where tbl.relkind in ('r', 'p')
limit 10;
```

