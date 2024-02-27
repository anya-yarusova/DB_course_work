CREATE TABLE IF NOT EXISTS places (
	place_id SERIAL PRIMARY KEY,
	name TEXT,
	description TEXT,
	location POINT,
	amount_comments INT,
	rating_numeric INT,
	access_id INT NOT NULL REFERENCES accesses(access_id)
);