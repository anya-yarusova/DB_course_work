import psycopg2
from main import tables

table_names = [i.name for i in tables]
triggers_by_table_name = {
     "route": ["""CREATE TRIGGER check_route_time_trigger
                BEFORE INSERT OR UPDATE ON route
 FOR EACH ROW
 EXECUTE FUNCTION check_times();"""],
     "trip": ["""CREATE TRIGGER check_trip_date_trigger
 BEFORE INSERT OR UPDATE ON trip
 FOR EACH ROW
 EXECUTE FUNCTION check_dates();
 """],
     "users": ["""CREATE TRIGGER check_password_length_trigger
 BEFORE INSERT OR UPDATE ON users
 FOR EACH ROW
 EXECUTE FUNCTION check_password_length();"""]
}

if __name__ == "__main__":
    conn = psycopg2.connect(
        host="localhost",
        database="postgres",
        user="postgres",
        password="postgres",
        port=5432
    )
    #with conn.cursor() as curs:
     #   curs.execute(open(f"./sql/triggers.sql", "r").read())
    #conn.commit()

    for name in table_names:
        with conn.cursor() as curs:
            print(f"Current table: {name}")
            curs.execute(f"DROP TABLE IF EXISTS {name} CASCADE;")
            curs.execute(open(f"./sql/{name}.schema.sql", "r").read())

            #triggers = triggers_by_table_name.get(name, None)
            #if triggers:
            #    for trig in triggers:
             #       curs.execute(trig)
             #   conn.commit()

            curs.execute(open(f"./sql/{name}.data.sql", "r").read())
            conn.commit()