CREATE TABLE IF NOT EXISTS routes (
	route_id SERIAL PRIMARY KEY,
	name TEXT,
	description TEXT,
	start_time TIMESTAMP,
	end_time TIMESTAMP,
	'type_id INT,
	access_id INT
);