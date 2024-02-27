CREATE OR REPLACE FUNCTION registration(
    p_login text,
    p_password text,
    p_name text,
    p_surname text,
    p_birthdate date
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO users (login, password, name, surname, birthdate, role_id)
    VALUES (p_login, p_password, p_name, p_surname, p_birthdate, p_role_id);
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

    INSERT INTO friends (user_login1 , user_login2)
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

    INSERT INTO trips (author_login, name, start_date, end_date, description, status_id, access_id)
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
    SELECT COUNT(*) INTO is_exist_type FROM route_types where trip_statuses.route_type_id = p_type_id;
    IF is_exist_type <> 1 THEN
        RAISE EXCEPTION 'Ошибка в типе маршрута';
    END IF;

    SELECT COUNT(*) INTO is_exist_access FROM accesses where accesses.access_id = p_access_id;
    IF is_exist_access <> 1 THEN
        RAISE EXCEPTION 'Ошибка в доступности маршрута';
    END IF;

    INSERT INTO routes (name, start_date, end_date, description, type_id, access_id)
    VALUES (p_name, p_start_date, p_end_date, p_description, p_type_id, p_access_id);
END;
$$ LANGUAGE plpgsql;

