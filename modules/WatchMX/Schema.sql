CREATE TABLE IF NOT EXISTS mailhogs (
	-- Module identifier
	origin		text,
	-- Tracking block
	IP		text	PRIMARY KEY,
	type		text,
	class		text,
	affairs		int,
	state		text,
	mb_class	text,
	comment		text,
	date_intro	date,
	date_event	date,
	-- Admin block
	rule		text,
	severity        text,
        initiator       text
) WITHOUT ROWID;

-- object: affairs_by_ip | type: TABLE --
DROP TABLE IF EXISTS affairs_by_ip;
CREATE TABLE affairs_by_ip (
	-- Module identifier
	origin		text,
	-- Tracking block
	id		INTEGER		PRIMARY KEY AUTOINCREMENT,
	ip_addr		TEXT 		NOT NULL,
	affair_num	INTEGER		NOT NULL,
	rule		TEXT,
	event_date	DATE		NOT NULL,
	time_useconds	INTEGER,
	FOREIGN KEY	(ip_addr)	REFERENCES mailhogs(IP)
			ON DELETE	CASCADE
);

-- Optional for better performance
DROP	INDEX IF EXISTS idx_mailhogs_ipr;
CREATE	INDEX idx_mailhogs_ipr	ON mailhogs (IP);

DROP	INDEX IF EXISTS idx_affairs_ip;
CREATE	INDEX idx_affairs_ip	ON affairs_by_ip (ip_addr);

