CREATE TABLE IF NOT EXISTS route_places (
	place_id INT NOT NULL REFERENCES places(place_id),
	route_id INT NOT NULL REFERENCES routes(route_id),
	PRIMARY KEY(place_id, route_id)
);