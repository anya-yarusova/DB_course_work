CREATE TABLE IF NOT EXISTS trips (
	trip_id SERIAL PRIMARY KEY,
	login TEXT NOT NULL REFERENCES users(login),
	name TEXT,
	start_date DATE,
	end_date DATE,
	description TEXT,
	status_id INT,
	access_id INT
);