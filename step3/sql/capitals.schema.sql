CREATE TABLE IF NOT EXISTS capitals (
	capital_id SERIAL PRIMARY KEY,
	capital_name TEXT NOT NULL UNIQUE,
	capital_location POINT NOT NULL
);