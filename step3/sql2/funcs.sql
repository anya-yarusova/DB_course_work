CREATE OR REPLACE FUNCTION registration(
    p_login text,
    p_password text,
    p_name text,
    p_surname text,
    p_birthdate date
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO users (login, password, name, surname, birt_date)
    VALUES (p_login, p_password, p_name, p_surname, p_birthdate);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_friend(
    p_user_login1 text,
    p_user_login2 text
)
    RETURNS VOID AS $$
DECLARE
    is_exist1 INTEGER;
    is_exist2 INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist1 FROM users where users.login = p_user_login1;
    IF is_exist1 <> 1 THEN
        RAISE EXCEPTION 'Ошибка в логине пользователя1';
    END IF;

    SELECT COUNT(*) INTO is_exist2 FROM users where users.login = p_user_login2;
    IF is_exist2 <> 1 THEN
        RAISE EXCEPTION 'Ошибка в логине пользователя2';
    END IF;

    INSERT INTO friends (user1_login , user2_login)
    VALUES (p_user_login1, p_user_login2);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_trip(
    p_author_login text,
    p_name text,
    p_start_date date,
    p_end_date date,
    p_description text,
    p_status_id int,
    p_access_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_user INTEGER;
    is_exist_status INTEGER;
    is_exist_access INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_user FROM users where users.login = p_author_login;
    IF is_exist_user <> 1 THEN
        RAISE EXCEPTION 'Ошибка в логине пользователя';
    END IF;

    SELECT COUNT(*) INTO is_exist_status FROM trip_statuses where trip_statuses.trip_status_id = p_status_id;
    IF is_exist_status <> 1 THEN
        RAISE EXCEPTION 'Ошибка в статусе поездки';
    END IF;

    SELECT COUNT(*) INTO is_exist_access FROM accesses where accesses.access_id = p_access_id;
    IF is_exist_access <> 1 THEN
        RAISE EXCEPTION 'Ошибка в доступности поездки';
    END IF;

    INSERT INTO trips (login, name, start_date, end_date, description, status_id, access_id)
    VALUES (p_author_login, p_name, p_start_date, p_end_date, p_description, p_status_id, p_access_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_route(
    p_name text,
    p_start_date date,
    p_end_date date,
    p_description text,
    p_type_id int,
    p_access_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_type INTEGER;
    is_exist_access INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_type FROM route_types where route_types.route_type_id = p_type_id;
    IF is_exist_type <> 1 THEN
        RAISE EXCEPTION 'Ошибка в типе маршрута';
    END IF;

    SELECT COUNT(*) INTO is_exist_access FROM accesses where accesses.access_id = p_access_id;
    IF is_exist_access <> 1 THEN
        RAISE EXCEPTION 'Ошибка в доступности маршрута';
    END IF;

    INSERT INTO routes (name, start_time, end_time, description, type_id, access_id)
    VALUES (p_name, p_start_date, p_end_date, p_description, p_type_id, p_access_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_route_to_trip(
    p_route_id int,
    p_trip_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_route INTEGER;
    is_exist_trip INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_route FROM routes where routes.route_id = p_route_id;
    IF is_exist_route <> 1 THEN
        RAISE EXCEPTION 'Ошибка маршруте';
    END IF;

    SELECT COUNT(*) INTO is_exist_trip FROM trips where trips.trip_id = p_trip_id;
    IF is_exist_trip <> 1 THEN
        RAISE EXCEPTION 'Ошибка в путешествии';
    END IF;

    INSERT INTO trip_routes (route_id, trip_id)
    VALUES (p_route_id, p_trip_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_place(
    p_name text,
    p_description text,
    p_location point,
    p_access_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_access INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_access FROM accesses where accesses.access_id = p_access_id;
    IF is_exist_access <> 1 THEN
        RAISE EXCEPTION 'Ошибка в доступности маршрута';
    END IF;

    INSERT INTO places (name, description, location, access_id)
    VALUES (p_name, p_description, p_location, p_access_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_place_to_route(
    p_place_id int,
    p_route_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_route INTEGER;
    is_exist_place INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_route FROM routes where routes.route_id = p_route_id;
    IF is_exist_route <> 1 THEN
        RAISE EXCEPTION 'Ошибка маршруте';
    END IF;

    SELECT COUNT(*) INTO is_exist_place FROM places where places.place_id = p_place_id;
    IF is_exist_place <> 1 THEN
        RAISE EXCEPTION 'Ошибка в месте';
    END IF;

    INSERT INTO route_places (route_id, place_id)
    VALUES (p_route_id, p_place_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION mark_region_as_visited(
    p_region_id int,
    p_map_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_region INTEGER;
    is_exist_map INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_region FROM regions where regions.region_id = p_region_id;
    IF is_exist_region <> 1 THEN
        RAISE EXCEPTION 'Ошибка в регионе';
    END IF;

    SELECT COUNT(*) INTO is_exist_map FROM maps where maps.map_id = p_map_id;
    IF is_exist_map <> 1 THEN
        RAISE EXCEPTION 'Ошибка в карте';
    END IF;

    INSERT INTO visited (map_id, region_id)
    VALUES (p_map_id, p_region_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION change_trip_status(
    p_trip_id int,
    p_status_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_trip INTEGER;
    is_exist_status INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_trip FROM trips where trips.trip_id = p_trip_id;
    IF is_exist_trip <> 1 THEN
        RAISE EXCEPTION 'Ошибка в путешествии';
    END IF;

    SELECT COUNT(*) INTO is_exist_status FROM trip_statuses where trip_statuses.trip_status_id = p_status_id;
    IF is_exist_status <> 1 THEN
        RAISE EXCEPTION 'Ошибка в статусе поездки';
    END IF;

    UPDATE trips
    SET status_id = p_status_id
    WHERE trip_id = p_trip_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION change_trip_access(
    p_trip_id int,
    p_access_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_trip INTEGER;
    is_exist_access INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_trip FROM trips where trips.trip_id = p_trip_id;
    IF is_exist_trip <> 1 THEN
        RAISE EXCEPTION 'Ошибка в путешествии';
    END IF;

    SELECT COUNT(*) INTO is_exist_access FROM accesses where accesses.access_id = p_access_id;
    IF is_exist_access <> 1 THEN
        RAISE EXCEPTION 'Ошибка в доступности маршрута';
    END IF;

    UPDATE trips
    SET access_id = p_access_id
    WHERE trip_id = p_trip_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION change_route_access(
    p_route_id int,
    p_access_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_route INTEGER;
    is_exist_access INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_route FROM routes where routes.route_id = p_route_id;
    IF is_exist_route <> 1 THEN
        RAISE EXCEPTION 'Ошибка маршруте';
    END IF;

    SELECT COUNT(*) INTO is_exist_access FROM accesses where accesses.access_id = p_access_id;
    IF is_exist_access <> 1 THEN
        RAISE EXCEPTION 'Ошибка в доступности маршрута';
    END IF;

    UPDATE routes
    SET access_id = p_access_id
    WHERE route_id = p_route_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION change_place_access(
    p_place_id int,
    p_access_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_place INTEGER;
    is_exist_access INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_place FROM places where places.place_id = p_place_id;
    IF is_exist_place <> 1 THEN
        RAISE EXCEPTION 'Ошибка в месте';
    END IF;

    SELECT COUNT(*) INTO is_exist_access FROM accesses where accesses.access_id = p_access_id;
    IF is_exist_access <> 1 THEN
        RAISE EXCEPTION 'Ошибка в доступности маршрута';
    END IF;

    UPDATE places
    SET access_id = p_access_id
    WHERE place_id = p_place_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_comment_on_trip(
    p_name text,
    p_description text,
    p_rate numeric,
    p_comment_date date,
    p_author_login int,
    p_trip_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_user INTEGER;
    is_exist_trip INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_user FROM users where users.login = p_author_login;
    IF is_exist_user <> 1 THEN
        RAISE EXCEPTION 'Ошибка в логине пользователя';
    END IF;

    SELECT COUNT(*) INTO is_exist_trip FROM trips where trips.trip_id = p_trip_id;
    IF is_exist_trip <> 1 THEN
        RAISE EXCEPTION 'Ошибка в путешествии';
    END IF;

    INSERT INTO comments (name, description, rate_numeric, comment_date, author_login, trip_id)
    VALUES (p_name, p_description, p_rate, p_comment_date, p_author_login, p_trip_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_comment_on_route(
    p_name text,
    p_description text,
    p_rate numeric,
    p_comment_date date,
    p_author_login int,
    p_route_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_user INTEGER;
    is_exist_route INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_user FROM users where users.login = p_author_login;
    IF is_exist_user <> 1 THEN
        RAISE EXCEPTION 'Ошибка в логине пользователя';
    END IF;

    SELECT COUNT(*) INTO is_exist_route FROM routes where routes.route_id = p_route_id;
    IF is_exist_route <> 1 THEN
        RAISE EXCEPTION 'Ошибка маршруте';
    END IF;

    INSERT INTO comments (name, description, rate_numeric, comment_date, author_login, route_id)
    VALUES (p_name, p_description, p_rate, p_comment_date, p_author_login, p_route_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_comment_on_place(
    p_name text,
    p_description text,
    p_rate numeric,
    p_comment_date date,
    p_author_login int,
    p_place_id int
)
    RETURNS VOID AS $$
DECLARE
    is_exist_user INTEGER;
    is_exist_place INTEGER;
BEGIN
    SELECT COUNT(*) INTO is_exist_user FROM users where users.login = p_author_login;
    IF is_exist_user <> 1 THEN
        RAISE EXCEPTION 'Ошибка в логине пользователя';
    END IF;

    SELECT COUNT(*) INTO is_exist_place FROM places where places.place_id = p_place_id;
    IF is_exist_place <> 1 THEN
        RAISE EXCEPTION 'Ошибка в месте';
    END IF;

    INSERT INTO comments (name, description, rate_numeric, comment_date, author_login, place_id)
    VALUES (p_name, p_description, p_rate, p_comment_date, p_author_login, p_place_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION view_statistics(
    p_user_login text
)
RETURNS Table(visited_regions_percentage INT, author_trips_count INT, participation_trips_count INT, routes_count INT, places_count INT) AS $$
DECLARE
    visited_regions_percentage  INTEGER;
    author_trips_count INTEGER;
    participation_trips_count INTEGER;
    routes_count INTEGER;
    places_count INTEGER;
BEGIN
    SELECT maps.percent_visited INTO visited_regions_percentage FROM maps where maps.login = p_user_login;

    SELECT COUNT(*) INTO author_trips_count FROM trips where trips.login = p_user_login;

    SELECT COUNT(*) INTO participation_trips_count FROM participation where participation.user_login = p_user_login;

    SELECT COUNT(*) INTO routes_count
    FROM trips
    JOIN trip_routes on trip_routes.trip_id = trips.trip_id
    where trips.login = p_user_login;

    SELECT COUNT(*) INTO places_count
    FROM trips
    JOIN trip_routes on trip_routes.trip_id = trips.trip_id
    JOIN route_places on trip_routes.trip_id = route_places.trip_id
    where trips.login = p_user_login;

    RETURN (visited_regions_percentage, author_trips_count, participation_trips_count, routes_count, places_count);
END;
$$ LANGUAGE plpgsql;
