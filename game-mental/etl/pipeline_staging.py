from sqlalchemy import create_engine
import pandas as pd
from extract import extract_chunks
from transform import transform
from load import load


engine = create_engine("postgresql://postgres:postgres@localhost:5432/postgres")

def load_staging(chunk):
    chunk.to_sql(
        "staging_game_mental",
        engine,
        if_exists="append",
        index=False
    )

def run_pipeline_staging():
    file_path = "data/game_mental.csv"

    for chunk in extract_chunks(file_path):
        clean_chunk = transform(chunk)
        load_staging(clean_chunk)

if __name__ == "__main__":
    run_pipeline_staging()