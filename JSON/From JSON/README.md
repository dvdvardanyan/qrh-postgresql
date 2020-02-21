# Parse JSON

### Get key/path value

->     Get value of the key as JSON
->>    Get value of the key as TEXT

```
select
	prs.id,
	prs.person_data ->> 'first' as "First Name",
	prs.person_data ->> 'last' as "Last Name",
	prs.person_data -> 'employers' -> 0 ->> 'name' as "First Employer"
from person as prs;
```

json_extract_path / jsonb_extract_path                        Get value of the path as JSON
json_extract_path_text / jsonb_extract_path_text functions    Get value of the path as TEXT

```
select
	prs.id,
	json_extract_path_text(prs.person_data, 'first') as "First Name",
	json_extract_path_text(prs.person_data, 'last') as "Last Name",
	json_extract_path_text(prs.person_data, 'employers', '0', 'name') as "First Employer"
from person as prs;
```

![](images/get_by_key.PNG)

### Get Key as table

json_object_keys/jsonb_object_keys    Get key as TEXT column

```
select prs.id, json_object_keys(prs.person_data)
from person as prs;
```

![](images/json_object_keys.PNG)

### Get Key/Value as table

json_each/jsonb_each              Get key/value as TEXT/JSON columns
json_each_text/jsonb_each_text    Get key/value as TEXT/TEXT columns

```
select prs.id, (json_each(prs.person_data)).*
from person as prs;
```

Using implicit lateral join:

```
select prs.id, KeyValueOfJson.key, KeyValueOfJson.value
from person as prs, json_each(prs.person_data) as KeyValueOfJson;
```
![](images/json_each.PNG)

### Get key/path value

json_array_elements / jsonb_array_elements              Get array elements as JSON column
json_array_elements_text / jsonb_array_elements_text    Get array elements as TEXT column

```
select
	prs.id,
	prs.person_data ->> 'first' as "First Name",
	prs.person_data ->> 'last' as "Last Name",
	json_array_elements(prs.person_data -> 'employers') ->> 'name' as "Employer Name"
from person as prs;
```

Using implicit lateral join:

```
select
	prs.id,
	prs.person_data ->> 'first' as "First Name",
	prs.person_data ->> 'last' as "Last Name",
	employers ->> 'name' as "Employer Name"
from person as prs, json_array_elements(prs.person_data -> 'employers') as employers
```

![](images/json_array_elements.PNG)