from extract import extract_chunks
from transform import transform
from load import load

def run_pipeline():
    file_path = "data/game_mental.csv"

    for chunk in extract_chunks(file_path):
        clean_chunk = transform(chunk)
        load(clean_chunk)

if __name__ == "__main__":
    run_pipeline()