-- object: bandits | type: TABLE --
CREATE TABLE IF NOT EXISTS "bandits" (
	-- Module identifier
	origin          text,
	-- Tracking Block
	IP		text PRIMARY KEY,
	type		text,
	class		text,
	affairs		integer,
	state		text,
	comment 	text,
	date_intro	date DEFAULT current_timestamp,
	date_event	date,
	-- Admin block
	rule		text,
	severity	text,
	initiator	text
);


-- object: affairs_by_ip | type: TABLE --
CREATE TABLE IF NOT EXISTS "affairs_by_ip" (
	id		integer PRIMARY KEY,
	ip_addr		text,
	affair_num	integer,
	rule		text,
	event_date	date,
	time_useconds	integer
);

-- Performance
CREATE INDEX idx_ip	ON bandits (IP);

