import os.path

from python.tables import *
from python.base import Table

tables: List[Table] = [USER_TABLE, REGION_CAPITAL_TABLE, REGION_TABLE, ACCESS_TABLE,
                       MAP_TABLE, ROUTE_TYPE_TABLE, ROUTE_TABLE, PLACE_TABLE,
                       TRIP_STATUS_TABLE, TRIP_TABLE, COMMENT_TABLE, PHOTO_TABLE,
                       TRIP_ROUTES_TABLE, ROUTE_PLACES_TABLE, PARTICIPATION_TABLE,
                       VISITED_TABLE, FRIENDS_TABLE]


def write_create_sql(table: Table) -> None:
    with open(f"sql/{table.name}.schema.sql", "w") as f:
        f.write(table.generate_create_sql())


def write_all_create_sql() -> None:
    [write_create_sql(table) for table in tables]


def generate_data_sql(table: Table, cnt: int) -> None:
    cur_list = data.get(table, [])
    if len(cur_list) == 0:
        data[table] = cur_list

    with open(f"sql/{table.name}.data.sql", "w") as f:
        records_cnt = 0
        for i in range(cnt):
            record = table.generate_record_with_constraints()
            if record is None:
                continue
            cur_list.append(record)
            f.write(record.generate_sql())
            records_cnt += 1
            if records_cnt % (cnt // 10) == 0:
                print(f"[debug] Generated {records_cnt} elements for table {table.name}")
        print(f"Total number of rows generated for table {table.name} is {records_cnt}")


def generate_all_data_sql(cnt: int, exclude_table: List[Table] = None) -> None:
    for table in tables:
        initialize_one_to_one_counter(table)
        initialize_uniques(table)
        if not exclude_table or table not in exclude_table:
            generate_data_sql(table, cnt)


def initialize_sequences() -> None:
    for table in tables:
        for field in table.fields:
            if SERIAL == field.value_type:
                sequences[field] = 1


def initialize_one_to_one_counter(table: Table) -> None:
    for field in table.fields:
        if field.reference and field.reference.reference_type == ReferenceType.ONE_TO_ONE:
            one_to_one_counter[(field.reference.field, field)] = 0


def initialize_uniques(table: Table) -> None:
    for field in table.fields:
        if field.constraints and (UNIQUE in field.constraints or PK in field.constraints):
            unique_dict[field] = set()
    if table.constraints:
        for const in table.constraints:
            unique_table_dict[list_hash(const[1])] = set()


def create_sql_dir_if_not_exists() -> None:
    path = "sql"
    if not os.path.exists(path):
        os.mkdir(path)


if __name__ == "__main__":
    create_sql_dir_if_not_exists()
    write_all_create_sql()
    initialize_sequences()
    generate_all_data_sql(10000, [MAP_TABLE, VISITED_TABLE, COMMENT_TABLE, PHOTO_TABLE, FRIENDS_TABLE])
