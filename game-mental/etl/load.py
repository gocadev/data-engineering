from sqlalchemy import create_engine

# connect to PostgreSQL database
engine = create_engine("postgresql://postgres:postgres@localhost:5432/postgres")

"""
    Write a function that takes a chunk of data and writes it to the PostgreSQL database.
"""
def load(chunk):

    chunk.to_sql(
        "game_mental",
        engine,
        if_exists="append",
        index=False
    )