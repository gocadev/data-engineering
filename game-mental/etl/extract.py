import pandas as pd

"""
    Read CSV file in chunks.
"""
def extract_chunks(file_path, chunksize=100_000):

    for chunk in pd.read_csv(file_path, chunksize=chunksize):
        yield chunk