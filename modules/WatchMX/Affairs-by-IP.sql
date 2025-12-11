-- object: affairs_by_ip | type: TABLE --
DROP TABLE IF EXISTS affairs_by_ip ;
CREATE TABLE "affairs_by_ip" (
	id		integer,
	origin		text,
	ip_addr		text,
	affair_num	integer,
	rule		text,
	event_date	date,
	time_useconds	integer,
	PRIMARY KEY ("id")
);
