CREATE TABLE IF NOT EXISTS friends (
	user1_login TEXT NOT NULL REFERENCES users(login),
	user2_login TEXT NOT NULL REFERENCES users(login),
	PRIMARY KEY(user1_login, user2_login)
);