CREATE TABLE IF NOT EXISTS photos (
	photo_id SERIAL PRIMARY KEY,
	path TEXT NOT NULL,
	comment_id INT NOT NULL REFERENCES comments(comment_id)
);