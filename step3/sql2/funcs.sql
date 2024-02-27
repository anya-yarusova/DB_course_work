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
BEGIN
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
BEGIN
    INSERT INTO trips (author_login, name, start_date, end_date, description, status_id, access_id)
    VALUES (p_author_login, p_name, p_start_date, p_end_date, p_description, p_status_id, p_access_id);
END;
$$ LANGUAGE plpgsql;

