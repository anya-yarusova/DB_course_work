-- Triggers
CREATE OR REPLACE FUNCTION check_dates()
RETURNS TRIGGER AS $$
BEGIN
      IF NEW.start_date > NEW.end_date THEN
    RAISE EXCEPTION 'End date should be after start date';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_times()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.start_time > NEW.end_time THEN
        RAISE EXCEPTION 'End time should be after start time';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_password_length()
RETURNS TRIGGER AS $$
BEGIN
  IF LENGTH(NEW.password) < 8 THEN
    RAISE EXCEPTION 'Minimum length of password is 8 symbols';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_friends_equality()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.user1_login = NEW.user2_login THEN
    RAISE EXCEPTION 'Friends should not have the same login';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION check_comment_attachment()
    RETURNS TRIGGER AS $$
DECLARE
    field_count INTEGER;
BEGIN
    field_count := (CASE WHEN NEW.trip_id IS NOT NULL THEN 1 ELSE 0 END) +
                   (CASE WHEN NEW.place_id IS NOT NULL THEN 1 ELSE 0 END) +
                   (CASE WHEN NEW.route_id IS NOT NULL THEN 1 ELSE 0 END);
    -- Проверяем условие, что только одно поле должно быть задано
    IF field_count = 1 THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Comment should attach to only one area';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_map_for_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO maps (login,creation_date,access_id,percent_visited) VALUES (NEW.login,current_timestamp,2,0);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION calculate_percentage()
    RETURNS TRIGGER AS $$
DECLARE
    regions_count INTEGER;
DECLARE
    visited_regions_count INTEGER;
BEGIN
    -- number of all regions
    SELECT COUNT(*) INTO regions_count
    FROM regions;

    -- number of visited regions
    SELECT COUNT(*) INTO visited_regions_count
    FROM visited
    WHERE map_id = NEW.map_id;

    UPDATE maps
    SET percent_visited = visited_regions_count / regions_count
    WHERE map_id = NEW.map_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
