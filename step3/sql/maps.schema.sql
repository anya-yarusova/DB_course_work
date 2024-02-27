CREATE TABLE IF NOT EXISTS maps (
	map_id SERIAL PRIMARY KEY,
	login TEXT UNIQUE NOT NULL REFERENCES users(login),
	creation_date DATE NOT NULL,
	access_id INT NOT NULL REFERENCES accesses(access_id)
);