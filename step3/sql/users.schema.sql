CREATE TABLE IF NOT EXISTS users (
	login TEXT PRIMARY KEY,
	password TEXT NOT NULL,
	name TEXT NOT NULL,
	surname TEXT NOT NULL,
	birt_date DATE
);