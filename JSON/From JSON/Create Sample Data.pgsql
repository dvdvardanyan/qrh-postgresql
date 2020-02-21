create table person
(
	id serial primary key,
	person_data json not null,
	person_data_b jsonb not null
);

insert into person(person_data, person_data_b)
values
(
'{
	"id": "lidsf90394",
	"first": "John",
	"last": "Star",
	"dob": {
		"year": 1954,
		"month": 3,
		"day": 3
	},
	"employers": [
		{
			"name": "Star Systems",
			"position": "Intern",
			"period": {
				"start": "01/01/1970",
				"end": "12/31/1970"
			}
		}, {
			"name": "Star Systems",
			"position": "Junior Developer",
			"period": {
				"start": "01/01/1971",
				"end": "01/01/1973"
			}
		}, {
			"name": "Endostar Company",
			"position": "Mid Developer",
			"period": {
				"start": "02/01/1973",
				"end": "01/01/1978"
			}
		}
	],
	"addresses": [
		{
			"buildingno": "4f",
			"street": "Elm Str.",
			"unit": "34",
			"city": "Lancaster",
			"state": "Vermont",
			"zip": "34536",
			"period": {
				"start": "01/01/1970",
				"end": "01/01/1973"
			}
		}
	]
}',
'{
	"id": "lidsf90394",
	"first": "John",
	"last": "Star",
	"dob": {
		"year": 1954,
		"month": 3,
		"day": 3
	},
	"employers": [
		{
			"name": "Star Systems",
			"position": "Intern",
			"period": {
				"start": "01/01/1970",
				"end": "12/31/1970"
			}
		}, {
			"name": "Star Systems",
			"position": "Junior Developer",
			"period": {
				"start": "01/01/1971",
				"end": "01/01/1973"
			}
		}, {
			"name": "Endostar Company",
			"position": "Mid Developer",
			"period": {
				"start": "02/01/1973",
				"end": "01/01/1978"
			}
		}
	],
	"addresses": [
		{
			"buildingno": "4f",
			"street": "Elm Str.",
			"unit": "34",
			"city": "Lancaster",
			"state": "Vermont",
			"zip": "34536",
			"period": {
				"start": "01/01/1970",
				"end": "01/01/1973"
			}
		}
	]
}'
);

insert into person(person_data, person_data_b)
values
(
'{
	"id": "kuhasd83fdf",
	"first": "Linda",
	"last": "Det",
	"dob": {
		"year": 1964,
		"month": 4,
		"day": 21
	},
	"employers": [
		{
			"name": "Kartan",
			"position": "Human Resource",
			"period": {
				"start": "03/15/1980",
				"end": "12/31/1985"
			}
		}, {
			"name": "Unicomp",
			"position": "Business Analyst",
			"period": {
				"start": "01/01/1986",
				"end": "01/01/1990"
			}
		}
	],
	"addresses": [
		{
			"buildingno": "34",
			"street": "Easy Str.",
			"city": "Blanka",
			"state": "Michigan",
			"zip": "34543",
			"period": {
				"start": "01/01/1980",
				"end": "01/01/2000"
			}
		}
	]
}',
'{
	"id": "kuhasd83fdf",
	"first": "Linda",
	"last": "Det",
	"dob": {
		"year": 1964,
		"month": 4,
		"day": 21
	},
	"employers": [
		{
			"name": "Kartan",
			"position": "Human Resource",
			"period": {
				"start": "03/15/1980",
				"end": "12/31/1985"
			}
		}, {
			"name": "Unicomp",
			"position": "Business Analyst",
			"period": {
				"start": "01/01/1986",
				"end": "01/01/1990"
			}
		}
	],
	"addresses": [
		{
			"buildingno": "34",
			"street": "Easy Str.",
			"city": "Blanka",
			"state": "Michigan",
			"zip": "34543",
			"period": {
				"start": "01/01/1980",
				"end": "01/01/2000"
			}
		}
	]
}'
);

insert into person(person_data, person_data_b)
values
(
'{
	"id": "2039840f9du093",
	"first": "Dick",
	"last": "Plat",
	"dob": {
		"year": 1955,
		"month": 4,
		"day": 21
	},
	"dod": {
		"year": 1986,
		"month": 3,
		"day": 31
	},
	"employers": [
		{
			"name": "Kilo",
			"position": "CEO",
			"period": {
				"start": "08/17/1981",
				"end": "03/31/1986"
			}
		}
	],
	"addresses": [
		{
			"buildingno": "34",
			"street": "Easy Str.",
			"city": "Blanka",
			"state": "Michigan",
			"zip": "34543",
			"period": {
				"start": "01/01/1980",
				"end": "01/01/2000"
			}
		}
	]
}',
'{
	"id": "2039840f9du093",
	"first": "Dick",
	"last": "Plat",
	"dob": {
		"year": 1955,
		"month": 4,
		"day": 21
	},
	"dod": {
		"year": 1986,
		"month": 3,
		"day": 31
	},
	"employers": [
		{
			"name": "Kilo",
			"position": "CEO",
			"period": {
				"start": "08/17/1981",
				"end": "03/31/1986"
			}
		}
	],
	"addresses": [
		{
			"buildingno": "34",
			"street": "Easy Str.",
			"city": "Blanka",
			"state": "Michigan",
			"zip": "34543",
			"period": {
				"start": "01/01/1980",
				"end": "01/01/2000"
			}
		}
	]
}'
);