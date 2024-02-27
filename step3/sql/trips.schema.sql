CREATE TABLE IF NOT EXISTS trips (
	trip_id SERIAL PRIMARY KEY,
	login TEXT NOT NULL REFERENCES users(login),
	name TEXT,
	start_date DATE,
	end_date DATE,
	description TEXT,
	status_id INT NOT NULL REFERENCES trip_statuses(trip_status_id),
	access_id INT NOT NULL REFERENCES accesses(access_id)
);