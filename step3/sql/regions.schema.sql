CREATE TABLE IF NOT EXISTS regions (
	region_id SERIAL PRIMARY KEY,
	name TEXT NOT NULL UNIQUE,
	capital_id INT NOT NULL REFERENCES capitals(capital_id)
);