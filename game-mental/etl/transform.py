import pandas as pd

"""
Transform chunk of data:
    gender into category
    other columns into numeric
"""
def transform(chunk):

    chunk["gender"] = chunk["gender"].astype("category")

    numeric_cols = chunk.columns.drop("gender")
    chunk[numeric_cols] = chunk[numeric_cols].apply(pd.to_numeric, errors="coerce")

    return chunk