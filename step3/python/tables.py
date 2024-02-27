from python.base import *
from faker import Faker

fake = Faker('ru_RU')


def generate_bool():
    return str(random.randint(0, 1))


class UserTable(Table):
    LOGIN = Field("login", TEXT, [PK],
                  generate_callback=lambda: fake.first_name()[:4].lower() + fake.last_name()[
                                                                            :4].lower() + fake.first_name()[
                                                                                          :4].lower() + fake.last_name()[
                                                                                                        :4].lower())
    NAME = Field("name", TEXT, [NOT_NULL], generate_callback=fake.first_name)
    SURNAME = Field("surname", TEXT, [NOT_NULL], generate_callback=fake.last_name)
    PASSWORD = Field("password", TEXT, [NOT_NULL], generate_callback=fake.password)
    BIRTH_DATE = Field("birt_date", DATE, generate_callback=fake.date)

    def __init__(self):
        super().__init__("users",
                         [
                             self.LOGIN,
                             self.PASSWORD,
                             self.NAME,
                             self.SURNAME,
                             self.BIRTH_DATE
                         ])


USER_TABLE = UserTable()


class RegionCapitalTable(Table):
    CAPITAL_ID = Field("capital_id", SERIAL, [PK])
    CAPITAL_NAME = Field("capital_name", TEXT, [NOT_NULL, UNIQUE],
                         generate_callback=capital_name_callback)
    CAPITAL_LOCATION = Field("capital_location", POINT, [NOT_NULL],
                             generate_callback=lambda: "POINT" + "(" + str(fake.latitude()) + "," + str(
                                 fake.longitude()) + ")")

    def __init__(self):
        super().__init__("capitals",
                         [
                             self.CAPITAL_ID,
                             self.CAPITAL_NAME,
                             self.CAPITAL_LOCATION
                         ])


REGION_CAPITAL_TABLE = RegionCapitalTable()


class RegionTable(Table):
    REGION_ID = Field("region_id", SERIAL, [PK])
    NAME = Field("name", TEXT, [NOT_NULL, UNIQUE],
                 generate_callback=region_name_callback)
    CAPITAL_ID = Field("capital_id", INT, [NOT_NULL],
                       reference=Reference(REGION_CAPITAL_TABLE, RegionCapitalTable.CAPITAL_ID,
                                           ReferenceType.ONE_TO_ONE))

    def __init__(self):
        super().__init__("regions",
                         [
                             self.REGION_ID,
                             self.NAME,
                             self.CAPITAL_ID
                         ])


REGION_TABLE = RegionTable()


class AccessTable(Table):
    ACCESS_ID = Field("access_id", SERIAL, [PK])
    ALIAS = Field("alias", TEXT, [NOT_NULL, UNIQUE], generate_callback=access_alias_callback)

    def __init__(self):
        super().__init__("accesses",
                         [
                             self.ACCESS_ID,
                             self.ALIAS
                         ])


ACCESS_TABLE = AccessTable()


class MapTable(Table):
    MAP_ID = Field("map_id", SERIAL, [PK])
    AUTHOR_LOGIN = Field("login", TEXT, [UNIQUE, NOT_NULL],
                         reference=Reference(USER_TABLE, UserTable.LOGIN, ReferenceType.ONE_TO_ONE))
    CREATION_DATE = Field("creation_date", DATE, [NOT_NULL], generate_callback=fake.date)
    PERCENT_VISITED = Field("percent_visited", INT, [NOT_NULL], generate_callback=lambda: str(random.randint(0, 100)))
    ACCESS_ID = Field("access_id", INT, [NOT_NULL],
                      reference=Reference(ACCESS_TABLE, AccessTable.ACCESS_ID, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("maps",
                         [
                             self.MAP_ID,
                             self.AUTHOR_LOGIN,
                             self.CREATION_DATE,
                             self.PERCENT_VISITED,
                             self.ACCESS_ID
                         ])


MAP_TABLE = MapTable()


class RouteTypeTable(Table):
    ROUTE_TYPE_ID = Field("route_type_id", SERIAL, [PK])
    ALIAS = Field("alias", TEXT, [NOT_NULL, UNIQUE], generate_callback=route_type_alias_callback)
    DESCRIPTION = Field("description", TEXT, generate_callback=fake.text)

    def __init__(self):
        super().__init__("route_types",
                         [
                             self.ROUTE_TYPE_ID,
                             self.ALIAS,
                             self.DESCRIPTION
                         ])


ROUTE_TYPE_TABLE = RouteTypeTable()


class RouteTable(Table):
    ROUTE_ID = Field("route_id", SERIAL, [PK])
    NAME = Field("name", TEXT, generate_callback=fake.last_name)
    DESCRIPTION = Field("description", TEXT, generate_callback=fake.text)
    START_TIME = Field("start_time", TIMESTAMP, [NOT_NULL], generate_callback=lambda: str(fake.date_time_between(start_date='-30d', end_date='-11d')))
    END_TIME = Field("end_time", TIMESTAMP, [NOT_NULL], generate_callback=lambda: str(fake.date_time_between(start_date='-10d', end_date='-1d')))
    TYPE_ID = Field("type_id", INT,
                    reference=Reference(ROUTE_TYPE_TABLE, RouteTypeTable.ROUTE_TYPE_ID,
                                        ReferenceType.MANY_TO_ONE))
    ACCESS_ID = Field("access_id", INT, [NOT_NULL],
                      reference=Reference(ACCESS_TABLE, AccessTable.ACCESS_ID, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("routes",
                         [
                             self.ROUTE_ID,
                             self.NAME,
                             self.DESCRIPTION,
                             self.START_TIME,
                             self.END_TIME,
                             self.TYPE_ID,
                             self.ACCESS_ID
                         ])


ROUTE_TABLE = RouteTable()


class PlaceTable(Table):
    PlACE_ID = Field("place_id", SERIAL, [PK])
    NAME = Field("name", TEXT, generate_callback=fake.street_title)
    DESCRIPTION = Field("description", TEXT, generate_callback=fake.text)
    LOCATION = Field("location", POINT,
                     generate_callback=lambda: "POINT" + "(" + str(fake.latitude()) + "," + str(fake.longitude()) + ")")
    AMOUNT_COMMENTS = Field("amount_comments", INT,
                            generate_callback=lambda: str(random.randint(0, 1000)))
    RATING_NUMERIC = Field("rating_numeric", INT,
                           generate_callback=lambda: str(random.randint(0, 5)))
    ACCESS_ID = Field("access_id", INT, [NOT_NULL],
                      reference=Reference(ACCESS_TABLE, AccessTable.ACCESS_ID, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("places",
                         [
                             self.PlACE_ID,
                             self.NAME,
                             self.DESCRIPTION,
                             self.LOCATION,
                             self.AMOUNT_COMMENTS,
                             self.RATING_NUMERIC,
                             self.ACCESS_ID
                         ])


PLACE_TABLE = PlaceTable()


class TripStatusTable(Table):
    TRIP_STATUS_ID = Field("trip_status_id", SERIAL, [PK])
    ALIAS = Field("alias", TEXT, [NOT_NULL, UNIQUE], generate_callback=trip_status_alias_callback)

    def __init__(self):
        super().__init__("trip_statuses",
                         [
                             self.TRIP_STATUS_ID,
                             self.ALIAS
                         ])


TRIP_STATUS_TABLE = TripStatusTable()


class TripTable(Table):
    TRIP_ID = Field("trip_id", SERIAL, [PK])
    AUTHOR_LOGIN = Field("login", TEXT, [NOT_NULL],
                         reference=Reference(USER_TABLE, UserTable.LOGIN, ReferenceType.MANY_TO_ONE))
    NAME = Field("name", TEXT, generate_callback=fake.first_name)
    START_DATE = Field("start_date", DATE, [NOT_NULL], generate_callback=lambda: str(fake.date_time_between(start_date='-30d', end_date='-11d')))
    END_DATE = Field("end_date", DATE, [NOT_NULL], generate_callback=lambda: str(fake.date_time_between(start_date='-10d', end_date='now')))
    DESCRIPTION = Field("description", TEXT, generate_callback=fake.text)
    STATUS_ID = Field("status_id", INT, [NOT_NULL],
                      reference=Reference(TRIP_STATUS_TABLE, TripStatusTable.TRIP_STATUS_ID, ReferenceType.MANY_TO_ONE))
    ACCESS_ID = Field("access_id", INT, [NOT_NULL],
                      reference=Reference(ACCESS_TABLE, AccessTable.ACCESS_ID, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("trips",
                         [
                             self.TRIP_ID,
                             self.AUTHOR_LOGIN,
                             self.NAME,
                             self.START_DATE,
                             self.END_DATE,
                             self.DESCRIPTION,
                             self.STATUS_ID,
                             self.ACCESS_ID
                         ])


TRIP_TABLE = TripTable()


class CommentTable(Table):
    COMMENT_ID = Field("comment_id", SERIAL, [PK])
    NAME = Field("name", TEXT, generate_callback=fake.first_name)
    DESCRIPTION = Field("description", TEXT, generate_callback=fake.text)
    RATE_NUMERIC = Field("rate_numeric", INT,
                         generate_callback=lambda: str(random.randint(0, 5)))
    COMMENT_DATE = Field("comment_date", DATE, generate_callback=fake.date)
    AUTHOR_LOGIN = Field("author_login", TEXT,
                         reference=Reference(TRIP_TABLE, UserTable.LOGIN, ReferenceType.MANY_TO_ONE))
    PLACE_ID = Field("place_id", INT,
                     reference=Reference(PLACE_TABLE, PlaceTable.PlACE_ID, ReferenceType.MANY_TO_ONE))
    TRIP_ID = Field("trip_id", INT,
                    reference=Reference(TRIP_TABLE, TripTable.TRIP_ID, ReferenceType.MANY_TO_ONE))
    ROUTE_ID = Field("route_id", INT,
                     reference=Reference(ROUTE_TABLE, RouteTable.ROUTE_ID, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("comments",
                         [
                             self.COMMENT_ID,
                             self.NAME,
                             self.DESCRIPTION,
                             self.RATE_NUMERIC,
                             self.COMMENT_DATE,
                             self.AUTHOR_LOGIN,
                             self.PLACE_ID,
                             self.TRIP_ID,
                             self.ROUTE_ID
                         ])


COMMENT_TABLE = CommentTable()


class PhotoTable(Table):
    PHOTO_ID = Field("photo_id", SERIAL, [PK])
    PATH = Field("path", TEXT, [NOT_NULL],
                 generate_callback=lambda: fake.file_path(depth=3, category='image', extension='png'))
    COMMENT_ID = Field("comment_id", INT, [NOT_NULL],
                       reference=Reference(COMMENT_TABLE, CommentTable.COMMENT_ID, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("photos",
                         [
                             self.PHOTO_ID,
                             self.PATH,
                             self.COMMENT_ID
                         ])


PHOTO_TABLE = PhotoTable()


class TripRoutesTable(Table):
    ROUTE_ID = Field("route_id", INT, [NOT_NULL],
                     reference=Reference(ROUTE_TABLE, RouteTable.ROUTE_ID, ReferenceType.MANY_TO_ONE))
    TRIP_ID = Field("trip_id", INT, [NOT_NULL],
                    reference=Reference(TRIP_TABLE, TripTable.TRIP_ID, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("trip_routes",
                         [self.ROUTE_ID,
                          self.TRIP_ID],
                         constraints=[(PK, [self.ROUTE_ID, self.TRIP_ID])])


TRIP_ROUTES_TABLE = TripRoutesTable()


class RoutePlacesTable(Table):
    PLACE_ID = Field("place_id", INT, [NOT_NULL],
                     reference=Reference(PLACE_TABLE, PlaceTable.PlACE_ID, ReferenceType.MANY_TO_ONE))
    ROUTE_ID = Field("route_id", INT, [NOT_NULL],
                     reference=Reference(ROUTE_TABLE, RouteTable.ROUTE_ID, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("route_places",
                         [self.PLACE_ID,
                          self.ROUTE_ID],
                         constraints=[(PK, [self.PLACE_ID, self.ROUTE_ID])])


ROUTE_PLACES_TABLE = RoutePlacesTable()


class ParticipationTable(Table):
    USER_LOGIN = Field("user_login", TEXT, [NOT_NULL],
                       reference=Reference(USER_TABLE, UserTable.LOGIN, ReferenceType.MANY_TO_ONE))
    TRIP_ID = Field("trip_id", INT, [NOT_NULL],
                    reference=Reference(TRIP_TABLE, TripTable.TRIP_ID, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("participation",
                         [self.USER_LOGIN,
                          self.TRIP_ID],
                         constraints=[(PK, [self.USER_LOGIN, self.TRIP_ID])])


PARTICIPATION_TABLE = ParticipationTable()


class VisitedTable(Table):
    MAP_ID = Field("map_id", INT, [NOT_NULL],
                   reference=Reference(MAP_TABLE, MapTable.MAP_ID, ReferenceType.MANY_TO_ONE))
    REGION_ID = Field("region_id", INT, [NOT_NULL],
                      reference=Reference(REGION_TABLE, RegionTable.REGION_ID, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("visited",
                         [self.MAP_ID,
                          self.REGION_ID],
                         constraints=[(PK, [self.MAP_ID, self.REGION_ID])])


VISITED_TABLE = VisitedTable()


class FriendsTable(Table):
    USER1_LOGIN = Field("user1_login", TEXT, [NOT_NULL],
                        reference=Reference(USER_TABLE, UserTable.LOGIN, ReferenceType.MANY_TO_ONE))
    USER2_LOGIN = Field("user2_login", TEXT, [NOT_NULL],
                        reference=Reference(USER_TABLE, UserTable.LOGIN, ReferenceType.MANY_TO_ONE))

    def __init__(self):
        super().__init__("friends",
                         [self.USER1_LOGIN,
                          self.USER2_LOGIN],
                         constraints=[(PK, [self.USER1_LOGIN, self.USER2_LOGIN])])


FRIENDS_TABLE = FriendsTable()
