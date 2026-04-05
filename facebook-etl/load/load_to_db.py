import psycopg2

## database connection parameters
DB_HOST = "localhost"
DB_NAME = "snap_project"   
DB_USER = "postgres"
DB_PASSWORD = "postgres"

# connection to PostgreSQL database
def get_connection():

    return psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )


# ---------------------------------------------------------
# LOAD functions for each table
# ---------------------------------------------------------

## insert data into UserEdges table
# rows = [(ego_id, src, dst), ...]
def load_edges(rows):
    if not rows:
        return

    conn = get_connection()
    cur = conn.cursor()

    query = """
        INSERT INTO edges (ego_id, src, dst)
        VALUES (%s, %s, %s)
    """

    cur.executemany(query, rows)
    conn.commit()

    cur.close()
    conn.close()


## insert data into UserFeatures table
# rows = [(ego_id, user_id, feat1, feat2, ...), ...]
def load_features(rows):
    if not rows:
        return

    conn = get_connection()
    cur = conn.cursor()

    query = """
        INSERT INTO UserFeatures (ego_id, user_id, feature_key, feature_value)
        VALUES (%s, %s, %s, %s)
    """

    cur.executemany(query, rows)
    conn.commit()

    cur.close()
    conn.close()

## insert data into EgoUserFeatures table
# row = (ego_id, feat1, feat2, ...)
def load_egofeatures(rows):
    if not rows:
        return

    conn = get_connection()
    cur = conn.cursor()

    query = """
        INSERT INTO EgoUserFeatures (ego_id, feature_key, feature_value)
        VALUES (%s, %s, %s)
    """

    cur.executemany(query, rows)
    conn.commit()

    cur.close()
    conn.close()

## insert data into UserCircles table
# rows = [(ego_id, circle_name), ...]
def load_circles(rows):
    if not rows:
        return

    conn = get_connection()
    cur = conn.cursor()

    query = """
        INSERT INTO UserCircles (ego_id, circle_name)
        VALUES (%s, %s)
    """

    cur.executemany(query, rows)
    conn.commit()

    cur.close()
    conn.close()

## insert data into CircleMembers table
# rows = [(ego_id, circle_name, member_id), ...]
def load_circle_members(rows):
    if not rows:
        return

    conn = get_connection()
    cur = conn.cursor()

    query = """
        INSERT INTO CircleMembers (ego_id, circle_name, member_id)
        VALUES (%s, %s, %s)
    """

    cur.executemany(query, rows)
    conn.commit()

    cur.close()
    conn.close()

## insert data into CombinedEdges table
# rows = [(src, dst), ...]
def load_combined_edges(rows):
    if not rows:
        return

    conn = get_connection()
    cur = conn.cursor()

    query = """
        INSERT INTO CombinedEdges (src, dst)
        VALUES (%s, %s)
    """

    cur.executemany(query, rows)
    conn.commit()

    cur.close()
    conn.close()

def load_feature_names(rows):
    conn = get_connection()
    cur = conn.cursor()

    query = """
        INSERT INTO FeatureNames (feature_key, feature_description)
        VALUES (%s, %s)
        ON CONFLICT (feature_key) DO NOTHING
    """

    cur.executemany(query, rows)
    conn.commit()
    cur.close()
    conn.close()
