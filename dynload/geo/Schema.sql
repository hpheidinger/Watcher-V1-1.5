-- Zone metadata: tracks active zone files and their MD5 state
CREATE TABLE zones (
    zone        TEXT PRIMARY KEY,       -- e.g. 'ru', 'cn'
    filename    TEXT NOT NULL,          -- e.g. 'ru-aggregated.zone'
    md5sum      TEXT,                   -- last known MD5 hash
    last_update TEXT,                   -- ISO timestamp
    active      INTEGER DEFAULT 1       -- 1 = active, 0 = removed
);

-- IP entries with optional counter tracking
CREATE TABLE ipset (
    ip          TEXT PRIMARY KEY,       -- IPv4 or IPv6
    zone        TEXT NOT NULL,          -- reference to zones.zone
    packets     INTEGER DEFAULT 0,      -- last known packet count
    bytes       INTEGER DEFAULT 0,      -- last known byte count
    first_seen  TEXT,                   -- ISO timestamp
    last_seen   TEXT,                   -- ISO timestamp
    comment     TEXT                    -- optional label
);

-- Historical snapshots for analysis
CREATE TABLE ipset_history (
    ip          TEXT,
    zone        TEXT,
    packets     INTEGER,
    bytes       INTEGER,
    timestamp   TEXT                    -- snapshot time
);

-- Runtime metadata (e.g. last run, backend type, flags)
CREATE TABLE meta (
    key         TEXT PRIMARY KEY,
    value       TEXT
);

