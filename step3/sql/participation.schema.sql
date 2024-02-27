CREATE TABLE IF NOT EXISTS participation (
	user_login TEXT NOT NULL REFERENCES users(login),
	trip_id INT NOT NULL REFERENCES trips(trip_id),
	PRIMARY KEY(user_login, trip_id)
);