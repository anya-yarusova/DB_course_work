CREATE TABLE IF NOT EXISTS places (
	place_id SERIAL PRIMARY KEY,
	name TEXT,
	description TEXT,
	location POINT,
	access_id INT
);