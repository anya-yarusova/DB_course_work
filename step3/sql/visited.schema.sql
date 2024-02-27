CREATE TABLE IF NOT EXISTS visited (
	map_id INT NOT NULL REFERENCES maps(map_id),
	region_id INT NOT NULL REFERENCES regions(region_id),
	PRIMARY KEY(map_id, region_id)
);