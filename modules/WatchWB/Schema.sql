PRAGMA foreign_keys = ON;

-- object: instances | type: TABLE --
CREATE TABLE IF NOT EXISTS instances (
	id		integer PRIMARY KEY,
	instname	text UNIQUE,
	insttype	text
);

insert into instances	(id, instname,insttype)
		values	(0,'Unknown','Common');

-- object: "Webhogs" | type: TABLE --
CREATE TABLE IF NOT EXISTS "webhogs" (
	-- Module identity
	origin		text,
	-- Tracking block
	IP		text PRIMARY KEY,
	type		text,
	class		text,
	web_class	text,
	affairs		integer,
	method		text,
	hterr		text,
	state		text,
	date_intro	date,
	date_event	date,
	instance	integer DEFAULT 0,
	comment		text,
	-- Admin block
	ruleset         text,    -- special for WEB module
	rule            text,
	severity        text,
	initiator       text,
	FOREIGN KEY     (instance) REFERENCES instances (id)
			ON UPDATE CASCADE
			ON DELETE CASCADE
);

-- object: affairs_by_ip | type: TABLE --
CREATE TABLE IF NOT EXISTS affairs_by_ip (
	id              integer PRIMARY KEY AUTOINCREMENT,
	ip_addr         text,
	affair_num      integer,
	rule            text,
	ruleset         text,
	date_event      date,
	time_useconds   integer,
	instance        integer,
	FOREIGN KEY     (instance) REFERENCES instances (id)
);

-- Performance
CREATE INDEX IF NOT EXISTS idx_ip ON webhogs (IP);

