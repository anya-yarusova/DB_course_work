import os.path

from main import tables
import psycopg2

#table_names = ['maps', 'users', 'capitals', 'regions', 'accesses', 'route_types', 'routes', 'places', 'trip_statuses', 'trips', 'comments', 'photos', 'trip_routes', 'route_places', 'participation', 'visited', 'friends']

table_names = [i.name for i in tables]
triggers_by_table_name = {
     "routes": ["""CREATE TRIGGER check_route_time_trigger
                BEFORE INSERT OR UPDATE ON routes
 FOR EACH ROW
 EXECUTE FUNCTION check_times();"""],
     "trips": ["""CREATE TRIGGER check_trip_date_trigger
 BEFORE INSERT OR UPDATE ON trips
 FOR EACH ROW
 EXECUTE FUNCTION check_dates();"""],
     "users": ["""CREATE TRIGGER check_password_length_trigger
 BEFORE INSERT OR UPDATE ON users
 FOR EACH ROW
 EXECUTE FUNCTION check_password_length();""",
               """CREATE TRIGGER create_map_for_user
 AFTER INSERT ON users
 FOR EACH ROW
 EXECUTE FUNCTION create_map_for_user();"""],
    "friends": ["""CREATE TRIGGER check_friends_equality
 BEFORE INSERT OR UPDATE ON friends
 FOR EACH ROW
 EXECUTE FUNCTION check_friends_equality();"""],
    "comments": ["""CREATE TRIGGER check_comment_attachment
 BEFORE INSERT OR UPDATE ON comments
 FOR EACH ROW
 EXECUTE FUNCTION check_comment_attachment();"""],
    "visited": ["""CREATE TRIGGER calculate_percentage
 AFTER INSERT OR UPDATE ON visited
 FOR EACH ROW
 EXECUTE FUNCTION calculate_percentage();"""],
}

if __name__ == "__main__":
    conn = psycopg2.connect(
        host="localhost",
        database="postgres",
        user="postgres",
        password="postgres",
        port=5432
    )
    with conn.cursor() as curs:
        curs.execute(open(f"./sql2/triggers.sql", "r").read())
    conn.commit()

    for name in table_names:
        with conn.cursor() as curs:
            print(f"Current table: {name}")
            curs.execute(f"DROP TABLE IF EXISTS {name} CASCADE;")
            curs.execute(open(f"./sql/{name}.schema.sql", "r").read())

            triggers = triggers_by_table_name.get(name, None)
            if triggers:
                for trig in triggers:
                    curs.execute(trig)
                conn.commit()

            if os.path.exists(f"./sql/{name}.data.sql"):
                curs.execute(open(f"./sql/{name}.data.sql", "r").read())
                conn.commit()