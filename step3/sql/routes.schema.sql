CREATE TABLE IF NOT EXISTS routes (
	route_id SERIAL PRIMARY KEY,
	name TEXT,
	description TEXT,
	start_time TIMESTAMP NOT NULL,
	end_time TIMESTAMP NOT NULL,
	type_id INT,
	access_id INT NOT NULL REFERENCES accesses(access_id)
);