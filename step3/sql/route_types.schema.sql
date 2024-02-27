CREATE TABLE IF NOT EXISTS route_types (
	route_type_id SERIAL PRIMARY KEY,
	alias TEXT NOT NULL UNIQUE,
	description TEXT
);