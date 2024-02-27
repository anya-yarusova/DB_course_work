CREATE TABLE IF NOT EXISTS trip_routes (
	route_id INT NOT NULL REFERENCES routes(route_id),
	trip_id INT NOT NULL REFERENCES trips(trip_id),
	PRIMARY KEY(route_id, trip_id)
);