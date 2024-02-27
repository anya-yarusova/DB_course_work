CREATE TABLE IF NOT EXISTS comments (
	comment_id SERIAL PRIMARY KEY,
	name TEXT,
	description TEXT,
	rate_numeric INT,
	comment_date DATE,
	author_login TEXT,
	place_id INT,
	trip_id INT,
	route_id INT
);