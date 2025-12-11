drop	table if exists geocount;
create	table geocount (
country		text,
count		integer,
lasttime	date,
primary key	(country)
);
